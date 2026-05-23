#!/usr/bin/env python3
"""
AWS S3 Bucket Reconnaissance Tool

A professional-grade reconnaissance utility for security researchers and bug bounty hunters.
Performs automated discovery and validation of AWS S3 buckets from subdomain/URL lists.

Author: Security Research Team
Version: 2.0.0
License: MIT
"""

import argparse
import logging
import re
import shutil
import subprocess
import sys
import time
from collections import defaultdict
from dataclasses import dataclass, field
from enum import Enum
from pathlib import Path
from typing import Dict, List, Optional, Set, Tuple
from urllib.parse import urlparse

import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry


# ============================================================================
# Configuration & Constants
# ============================================================================

class RiskLevel(Enum):
    """Risk classification for discovered S3 buckets."""
    HIGH = "HIGH"
    MEDIUM = "MEDIUM"
    LOW = "LOW"
    UNKNOWN = "UNKNOWN"


class ExitCode(Enum):
    """Application exit codes."""
    SUCCESS = 0
    INPUT_ERROR = 1
    NETWORK_ERROR = 2
    INTERRUPTED = 3
    UNEXPECTED = 99


@dataclass
class ScannerConfig:
    """Configuration for the S3 reconnaissance scanner."""
    max_retries: int = 2
    request_timeout: int = 10
    backoff_factor: float = 0.5
    rate_limit_delay: float = 0.5
    user_agent: str = (
        "S3ReconScanner/2.0 "
        "(Security Research Tool; "
        "+https://github.com/security-researcher/s3-recon)"
    )

    # S3 Pattern Definitions
    s3_patterns: re.Pattern = field(default_factory=lambda: re.compile(
        r"""
        (?:https?://)?                              # Optional protocol
        (?:
            (?:[^./]+)                              # Bucket name
            \.s3(?:-website)?                       # S3 service indicator
            (?:-[a-z]{2}-[a-z]+-\d+)?               # Optional region
            \.amazonaws\.com                         # AWS domain
            |
            s3\.amazonaws\.com/([^/]+)              # Path-style bucket
        )
        """,
        re.IGNORECASE | re.VERBOSE
    ))

    bucket_name_patterns: List[re.Pattern] = field(default_factory=lambda: [
        re.compile(r'^(.+?)\.s3\.amazonaws\.com$', re.IGNORECASE),
        re.compile(
            r'^(.+?)\.s3(?:-website)?\.[a-z]{2}-[a-z]+-\d+\.amazonaws\.com$',
            re.IGNORECASE
        ),
        re.compile(r'^s3\.amazonaws\.com/(.+?)(?:/.*)?$', re.IGNORECASE),
        re.compile(
            r'^s3\.[a-z]{2}-[a-z]+-\d+\.amazonaws\.com/(.+?)(?:/.*)?$',
            re.IGNORECASE
        ),
    ])

    retry_status_codes: Set[int] = field(default_factory=lambda: {
        500, 502, 503, 504
    })

    # Risk classification mapping
    risk_mapping: Dict[int, RiskLevel] = field(default_factory=lambda: {
        200: RiskLevel.HIGH,
        403: RiskLevel.MEDIUM,
        404: RiskLevel.LOW,
    })


# ============================================================================
# Data Models
# ============================================================================

@dataclass
class NormalizedHost:
    """Represents a normalized and validated hostname."""
    original: str
    hostname: str
    is_valid: bool


@dataclass
class S3Bucket:
    """Represents a discovered S3 bucket with metadata."""
    name: str
    sources: Set[str] = field(default_factory=set)
    endpoints: Set[str] = field(default_factory=set)

    def add_source(self, source: str, endpoint: str) -> None:
        """Add a source subdomain and endpoint mapping."""
        self.sources.add(source)
        self.endpoints.add(endpoint)


@dataclass
class ValidationResult:
    """Results from bucket validation."""
    bucket_name: str
    sources: List[str] = field(default_factory=list)
    endpoints: List[str] = field(default_factory=list)
    http_status: int = 0
    risk_level: RiskLevel = RiskLevel.UNKNOWN
    aws_cli_output: Optional[str] = None
    error_message: Optional[str] = None


# ============================================================================
# Logging Configuration
# ============================================================================

def configure_logging() -> logging.Logger:
    """Configure and return application logger."""
    logger = logging.getLogger("S3Recon")
    logger.setLevel(logging.INFO)

    if not logger.handlers:
        handler = logging.StreamHandler(sys.stderr)
        formatter = logging.Formatter(
            '[%(asctime)s] %(levelname)-8s %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)

    return logger


logger = configure_logging()


# ============================================================================
# Input Layer
# ============================================================================

class InputFileReader:
    """Reads and parses input files containing subdomains and URLs."""

    @staticmethod
    def read(filepath: str) -> List[str]:
        """
        Read lines from input file, filtering empty lines and comments.

        Args:
            filepath: Path to the input file.

        Returns:
            List of non-empty, non-comment lines.

        Raises:
            FileNotFoundError: If the input file does not exist.
            PermissionError: If the file cannot be read due to permissions.
        """
        file_path = Path(filepath)

        if not file_path.exists():
            logger.error(f"Input file not found: {filepath}")
            raise FileNotFoundError(f"Input file not found: {filepath}")

        if not file_path.is_file():
            logger.error(f"Path is not a file: {filepath}")
            raise ValueError(f"Path is not a file: {filepath}")

        try:
            with file_path.open('r', encoding='utf-8') as file:
                lines = [
                    line.strip()
                    for line in file
                    if line.strip() and not line.strip().startswith('#')
                ]
            logger.info(f"Successfully loaded {len(lines)} entries from {filepath}")
            return lines
        except PermissionError:
            logger.error(f"Permission denied reading file: {filepath}")
            raise
        except Exception as e:
            logger.error(f"Error reading input file: {e}")
            raise


# ============================================================================
# Normalization Layer
# ============================================================================

class DomainNormalizer:
    """Validates and normalizes domain names from raw input."""

    DOMAIN_PATTERN = re.compile(
        r'^'
        r'(?:[a-zA-Z0-9]'                    # First character
        r'(?:[a-zA-Z0-9-]{0,61}'             # Middle characters
        r'[a-zA-Z0-9])?\.)'                  # Last character before dot
        r'+'                                  # Repeat for subdomains
        r'[a-zA-Z]{2,}'                      # TLD
        r'$'
    )

    @classmethod
    def normalize(cls, raw_input: str) -> Optional[NormalizedHost]:
        """
        Normalize raw input to a clean hostname.

        Args:
            raw_input: Raw string that may be a domain, URL, or malformed input.

        Returns:
            NormalizedHost object if valid, None otherwise.
        """
        if not raw_input or not raw_input.strip():
            return None

        raw_input = raw_input.strip()

        # Add protocol for consistent parsing if missing
        if not raw_input.startswith(('http://', 'https://')):
            raw_input = f'https://{raw_input}'

        try:
            parsed = urlparse(raw_input)
            hostname = parsed.hostname

            if not hostname:
                return None

            hostname = hostname.lower().strip()

            if not cls._validate_structure(hostname):
                logger.debug(f"Invalid domain structure: {hostname}")
                return None

            return NormalizedHost(
                original=raw_input,
                hostname=hostname,
                is_valid=True
            )

        except Exception as e:
            logger.debug(f"Normalization failed for '{raw_input}': {e}")
            return None

    @classmethod
    def _validate_structure(cls, hostname: str) -> bool:
        """
        Validate domain name structure and length.

        Args:
            hostname: The hostname to validate.

        Returns:
            True if the domain structure is valid.
        """
        if not hostname or len(hostname) > 253:
            return False

        return bool(cls.DOMAIN_PATTERN.match(hostname))


# ============================================================================
# S3 Detection & Extraction Layer
# ============================================================================

class S3BucketAnalyzer:
    """Detects S3 bucket patterns and extracts bucket information."""

    def __init__(self, config: ScannerConfig):
        self.config = config
        self.buckets: Dict[str, S3Bucket] = {}

    def analyze_host(self, hostname: str, original_source: str) -> Optional[str]:
        """
        Analyze a hostname for S3 patterns and extract bucket info.

        Args:
            hostname: Normalized hostname to analyze.
            original_source: Original input source for mapping.

        Returns:
            Bucket name if S3 pattern detected, None otherwise.
        """
        if not self._is_s3_hostname(hostname):
            return None

        bucket_name = self._extract_bucket_name(hostname)
        if not bucket_name:
            return None

        self._register_bucket(bucket_name, original_source, hostname)
        return bucket_name

    def _is_s3_hostname(self, hostname: str) -> bool:
        """Check if hostname matches S3 patterns."""
        return bool(self.config.s3_patterns.search(hostname))

    def _extract_bucket_name(self, hostname: str) -> Optional[str]:
        """Extract bucket name from S3 hostname."""
        for pattern in self.config.bucket_name_patterns:
            match = pattern.match(hostname)
            if match:
                bucket_name = match.group(1).lower().strip()
                # Remove any trailing path components
                bucket_name = bucket_name.split('/')[0]
                return bucket_name
        return None

    def _register_bucket(
        self,
        bucket_name: str,
        source: str,
        endpoint: str
    ) -> None:
        """Register a discovered bucket with its source and endpoint."""
        if bucket_name not in self.buckets:
            self.buckets[bucket_name] = S3Bucket(name=bucket_name)

        self.buckets[bucket_name].add_source(source, endpoint)

    def get_buckets(self) -> Dict[str, S3Bucket]:
        """Return all discovered buckets."""
        return self.buckets


# ============================================================================
# HTTP Client & Validation Layer
# ============================================================================

class HTTPClient:
    """HTTP client with retry logic for bucket validation."""

    def __init__(self, config: ScannerConfig):
        self.config = config
        self.session = self._create_session()

    def _create_session(self) -> requests.Session:
        """Create a requests session with retry strategy."""
        session = requests.Session()

        retry_strategy = Retry(
            total=self.config.max_retries,
            backoff_factor=self.config.backoff_factor,
            status_forcelist=list(self.config.retry_status_codes),
            allowed_methods=["HEAD", "GET"],
            raise_on_status=False
        )

        adapter = HTTPAdapter(
            max_retries=retry_strategy,
            pool_connections=10,
            pool_maxsize=10
        )

        session.mount("https://", adapter)
        session.mount("http://", adapter)
        session.headers.update({
            "User-Agent": self.config.user_agent,
            "Accept": "*/*",
            "Accept-Encoding": "gzip, deflate",
        })

        return session

    def check_endpoint(self, endpoint: str) -> Optional[int]:
        """
        Check an endpoint via HTTP HEAD/GET request.

        Args:
            endpoint: The endpoint to check (without protocol).

        Returns:
            HTTP status code if successful, None if all attempts fail.
        """
        for protocol in ['https://', 'http://']:
            url = f"{protocol}{endpoint}"
            status = self._attempt_request(url)
            if status is not None:
                return status
        return None

    def _attempt_request(self, url: str) -> Optional[int]:
        """Attempt HTTP request with fallback from HEAD to GET."""
        try:
            # Try HEAD first (less bandwidth)
            response = self.session.head(
                url,
                timeout=self.config.request_timeout,
                allow_redirects=True
            )
            if response.status_code != 405:  # Method Not Allowed
                return response.status_code

            # Fallback to GET
            response = self.session.get(
                url,
                timeout=self.config.request_timeout,
                allow_redirects=True,
                stream=True
            )
            response.close()
            return response.status_code

        except requests.exceptions.Timeout:
            logger.debug(f"Timeout connecting to {url}")
        except requests.exceptions.ConnectionError:
            logger.debug(f"Connection error for {url}")
        except requests.exceptions.SSLError:
            logger.debug(f"SSL error for {url}")
        except requests.exceptions.RequestException as e:
            logger.debug(f"Request failed for {url}: {e}")

        return None

    def close(self):
        """Close the HTTP session."""
        self.session.close()


class AWSValidator:
    """Validates S3 buckets using AWS CLI if available."""

    def __init__(self):
        self.aws_available = shutil.which('aws') is not None
        if not self.aws_available:
            logger.info("AWS CLI not found - skipping AWS validation")

    def check_bucket(self, bucket_name: str) -> Optional[str]:
        """
        Check bucket accessibility via AWS CLI.

        Args:
            bucket_name: The S3 bucket name to check.

        Returns:
            CLI output string or None if unavailable.
        """
        if not self.aws_available:
            return None

        try:
            result = subprocess.run(
                ['aws', 's3', 'ls', f's3://{bucket_name}'],
                capture_output=True,
                text=True,
                timeout=15
            )

            if result.returncode == 0:
                output = result.stdout.strip()
                return output if output else "(empty bucket)"
            else:
                error = result.stderr.strip()
                return f"Error: {error[:100]}"

        except subprocess.TimeoutExpired:
            return "Error: AWS CLI timeout"
        except Exception as e:
            return f"Error: {str(e)[:100]}"


class BucketValidator:
    """Orchestrates bucket validation through HTTP and AWS CLI."""

    def __init__(self, config: ScannerConfig):
        self.config = config
        self.http_client = HTTPClient(config)
        self.aws_validator = AWSValidator()

    def validate(self, bucket: S3Bucket) -> ValidationResult:
        """
        Validate a single S3 bucket.

        Args:
            bucket: The S3Bucket to validate.

        Returns:
            ValidationResult with status and risk assessment.
        """
        result = ValidationResult(
            bucket_name=bucket.name,
            sources=sorted(bucket.sources),
            endpoints=sorted(bucket.endpoints),
        )

        # HTTP validation
        for endpoint in sorted(bucket.endpoints):
            status_code = self.http_client.check_endpoint(endpoint)
            if status_code is not None:
                result.http_status = status_code
                result.risk_level = self.config.risk_mapping.get(
                    status_code,
                    RiskLevel.UNKNOWN
                )
                break
        else:
            result.error_message = "All HTTP checks failed"
            result.risk_level = RiskLevel.UNKNOWN

        # AWS CLI validation
        result.aws_cli_output = self.aws_validator.check_bucket(bucket.name)

        return result

    def cleanup(self):
        """Clean up resources."""
        self.http_client.close()


# ============================================================================
# Reporting Layer
# ============================================================================

class ReportFormatter:
    """Formats and displays reconnaissance results."""

    @staticmethod
    def format(results: List[ValidationResult]) -> str:
        """
        Format results into a professional report.

        Args:
            results: List of validation results to format.

        Returns:
            Formatted report string.
        """
        if not results:
            return "\nNo S3 buckets discovered.\n"

        # Calculate statistics
        stats = defaultdict(int)
        for result in results:
            stats[result.risk_level.value] += 1

        report = []
        report.append("")
        report.append("=" * 80)
        report.append("AWS S3 BUCKET RECONNAISSANCE REPORT")
        report.append("=" * 80)
        report.append("")
        report.append(f"Scan Date: {time.strftime('%Y-%m-%d %H:%M:%S')}")
        report.append(f"Total Buckets Discovered: {len(results)}")
        report.append("")
        report.append("Risk Summary:")
        report.append(f"  🔴 HIGH     (Publicly Accessible): {stats.get('HIGH', 0)}")
        report.append(f"  🟡 MEDIUM   (Exists but Restricted): {stats.get('MEDIUM', 0)}")
        report.append(f"  🟢 LOW      (Not Found/404): {stats.get('LOW', 0)}")
        report.append(f"  ⚪ UNKNOWN  (Connection Error): {stats.get('UNKNOWN', 0)}")
        report.append("")
        report.append("-" * 80)

        # Sort by risk severity
        risk_priority = {
            RiskLevel.HIGH: 0,
            RiskLevel.MEDIUM: 1,
            RiskLevel.LOW: 2,
            RiskLevel.UNKNOWN: 3
        }
        results.sort(key=lambda x: risk_priority.get(x.risk_level, 99))

        # Format individual findings
        for idx, result in enumerate(results, 1):
            risk_symbol = {
                RiskLevel.HIGH: '🔴',
                RiskLevel.MEDIUM: '🟡',
                RiskLevel.LOW: '🟢',
                RiskLevel.UNKNOWN: '⚪'
            }.get(result.risk_level, '⚪')

            report.append("")
            report.append(
                f"[{idx:03d}] {risk_symbol} {result.risk_level.value} RISK"
            )
            report.append(f"      Bucket: {result.bucket_name}")
            report.append(f"      Status: HTTP {result.http_status or 'N/A'}")

            if result.sources:
                report.append(f"      Sources: {', '.join(result.sources[:3])}")
                if len(result.sources) > 3:
                    report.append(f"              (+ {len(result.sources) - 3} more)")

            if result.endpoints:
                report.append(f"      Endpoint: {result.endpoints[0]}")

            if result.aws_cli_output:
                cli_output = result.aws_cli_output
                if len(cli_output) > 100:
                    cli_output = cli_output[:97] + "..."
                report.append(f"      AWS CLI: {cli_output}")

            if result.error_message:
                report.append(f"      Error: {result.error_message}")

        report.append("")
        report.append("=" * 80)
        report.append("SCAN COMPLETE")
        report.append("=" * 80)
        report.append("")

        return '\n'.join(report)

    @staticmethod
    def display(results: List[ValidationResult]) -> None:
        """Display formatted results to stdout."""
        print(ReportFormatter.format(results))

    @staticmethod
    def save_to_file(
        results: List[ValidationResult],
        output_path: str
    ) -> None:
        """
        Save results to a file.

        Args:
            results: Validation results to save.
            output_path: Path to output file.
        """
        report = ReportFormatter.format(results)
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(report)
        logger.info(f"Report saved to {output_path}")


# ============================================================================
# Pipeline Orchestrator
# ============================================================================

class S3ReconPipeline:
    """
    Main pipeline orchestrating the S3 reconnaissance process.

    This class coordinates all layers of the reconnaissance pipeline:
    1. Input reading and parsing
    2. Domain normalization and validation
    3. S3 bucket detection and extraction
    4. Bucket validation via HTTP and AWS CLI
    5. Results reporting and output
    """

    def __init__(self, config: Optional[ScannerConfig] = None):
        """
        Initialize the pipeline with configuration.

        Args:
            config: Scanner configuration. Uses defaults if not provided.
        """
        self.config = config or ScannerConfig()
        self.analyzer = S3BucketAnalyzer(self.config)
        self.validator = BucketValidator(self.config)
        self.reporter = ReportFormatter()

    def execute(self, input_file: str, output_file: Optional[str] = None) -> List[ValidationResult]:
        """
        Execute the complete S3 reconnaissance pipeline.

        Args:
            input_file: Path to input file with subdomains/URLs.
            output_file: Optional path to save report output.

        Returns:
            List of validation results for discovered buckets.
        """
        logger.info("=" * 60)
        logger.info("Starting S3 Reconnaissance Pipeline")
        logger.info("=" * 60)

        try:
            # Phase 1: Input Processing
            logger.info("Phase 1/4: Reading input file")
            raw_entries = InputFileReader.read(input_file)

            # Phase 2: Normalization
            logger.info("Phase 2/4: Normalizing domains")
            normalized_hosts = self._normalize_entries(raw_entries)
            logger.info(f"Normalized {len(normalized_hosts)} valid hostnames")

            # Phase 3: S3 Detection
            logger.info("Phase 3/4: Detecting S3 buckets")
            self._detect_buckets(normalized_hosts)
            buckets = self.analyzer.get_buckets()
            logger.info(f"Discovered {len(buckets)} unique S3 buckets")

            if not buckets:
                logger.info("No S3 buckets found. Exiting.")
                return []

            # Phase 4: Validation
            logger.info("Phase 4/4: Validating bucket accessibility")
            results = self._validate_buckets(buckets)

            # Reporting
            self.reporter.display(results)

            if output_file:
                self.reporter.save_to_file(results, output_file)

            logger.info("Pipeline execution completed successfully")
            return results

        except Exception as e:
            logger.error(f"Pipeline execution failed: {e}")
            raise
        finally:
            self.validator.cleanup()

    def _normalize_entries(self, raw_entries: List[str]) -> List[NormalizedHost]:
        """Normalize raw input entries to validated hostnames."""
        normalized = []
        for entry in raw_entries:
            result = DomainNormalizer.normalize(entry)
            if result and result.is_valid:
                normalized.append(result)
        return normalized

    def _detect_buckets(self, hosts: List[NormalizedHost]) -> None:
        """Detect and extract S3 bucket information from hosts."""
        for host in hosts:
            self.analyzer.analyze_host(host.hostname, host.original)

    def _validate_buckets(
        self,
        buckets: Dict[str, S3Bucket]
    ) -> List[ValidationResult]:
        """Validate discovered S3 buckets."""
        results = []
        total = len(buckets)

        for idx, (name, bucket) in enumerate(buckets.items(), 1):
            logger.info(f"Validating bucket {idx}/{total}: {name}")

            try:
                result = self.validator.validate(bucket)
                results.append(result)

                # Log brief result
                status = f"HTTP {result.http_status}" if result.http_status else "Failed"
                logger.debug(
                    f"  {name}: {status} - {result.risk_level.value}"
                )

            except Exception as e:
                logger.error(f"Validation failed for {name}: {e}")
                results.append(ValidationResult(
                    bucket_name=name,
                    sources=sorted(bucket.sources),
                    endpoints=sorted(bucket.endpoints),
                    error_message=str(e)
                ))

            # Rate limiting between requests
            if idx < total:
                time.sleep(self.config.rate_limit_delay)

        return results


# ============================================================================
# CLI Interface
# ============================================================================

def create_argument_parser() -> argparse.ArgumentParser:
    """Create and configure the argument parser."""
    parser = argparse.ArgumentParser(
        description=(
            "AWS S3 Bucket Reconnaissance Tool - "
            "Professional security research utility"
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s -f subdomains.txt
  %(prog)s --file urls.txt --output report.txt
  %(prog)s -f domains.txt -v

Input File Format:
  - One subdomain or URL per line
  - Lines starting with # are treated as comments
  - Empty lines are automatically skipped
  - Supports: domains, full URLs, and malformed inputs

Risk Classifications:
  HIGH    (200) - Publicly accessible bucket
  MEDIUM  (403) - Bucket exists but is restricted
  LOW     (404) - Bucket not found or deleted
        """
    )

    parser.add_argument(
        '-f', '--file',
        required=True,
        type=str,
        help='Path to input file containing subdomains/URLs'
    )

    parser.add_argument(
        '-o', '--output',
        type=str,
        default=None,
        help='Save report to specified output file'
    )

    parser.add_argument(
        '-v', '--verbose',
        action='store_true',
        default=False,
        help='Enable verbose debug logging'
    )

    parser.add_argument(
        '--timeout',
        type=int,
        default=10,
        help='HTTP request timeout in seconds (default: 10)'
    )

    parser.add_argument(
        '--retries',
        type=int,
        default=2,
        help='Maximum retry attempts for failed requests (default: 2)'
    )

    parser.add_argument(
        '--delay',
        type=float,
        default=0.5,
        help='Delay between requests in seconds (default: 0.5)'
    )

    return parser


def main() -> None:
    """Main entry point for the S3 reconnaissance tool."""
    parser = create_argument_parser()
    args = parser.parse_args()

    # Configure logging level
    if args.verbose:
        logger.setLevel(logging.DEBUG)
        logger.debug("Verbose logging enabled")

    # Create custom configuration
    config = ScannerConfig(
        request_timeout=args.timeout,
        max_retries=args.retries,
        rate_limit_delay=args.delay
    )

    # Execute pipeline
    pipeline = S3ReconPipeline(config=config)

    try:
        pipeline.execute(
            input_file=args.file,
            output_file=args.output
        )
        sys.exit(ExitCode.SUCCESS.value)

    except FileNotFoundError as e:
        logger.error(str(e))
        sys.exit(ExitCode.INPUT_ERROR.value)

    except KeyboardInterrupt:
        logger.info("Scan interrupted by user")
        sys.exit(ExitCode.INTERRUPTED.value)

    except requests.exceptions.RequestException as e:
        logger.error(f"Network error: {e}")
        sys.exit(ExitCode.NETWORK_ERROR.value)

    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        if args.verbose:
            import traceback
            traceback.print_exc()
        sys.exit(ExitCode.UNEXPECTED.value)


if __name__ == "__main__":
    main()
