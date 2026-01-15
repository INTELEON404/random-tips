# S3 Bucket Recon

**Author:** `~/.lostsec@coffinxp`

This document contains specialized Google and GitHub dorks used for discovering exposed Amazon S3 buckets and sensitive AWS credentials.

---

## 🔍 Google Dorks

Use these queries to find indexed S3 buckets and directory listings via Google search.

| Search Type | Dork Query |
| --- | --- |
| **Specific Target** | `site:s3.amazonaws.com "target.com"` |
| **Wildcard Subdomains** | `site:*.s3.amazonaws.com "target.com"` |
| **External Regions** | `site:s3-external-1.amazonaws.com "target.com"` |
| **Dualstack Endpoints** | `site:s3.dualstack.us-east-1.amazonaws.com "target.com"` |
| **URL Discovery** | `site:amazonaws.com inurl:s3.amazonaws.com` |
| **Directory Listing** | `site:s3.amazonaws.com intitle:"index of"` |
| **Path Search** | `site:s3.amazonaws.com inurl:".s3.amazonaws.com/"` |
| **Bucket Indexing** | `site:s3.amazonaws.com intitle:"index of" "bucket"` |

### 🛠 Combined Query Example

The following query targets multiple S3 endpoints for a specific organization (e.g., NASA):

```text
(site:*.s3.amazonaws.com OR site:*.s3-external-1.amazonaws.com OR site:*.s3.dualstack.us-east-1.amazonaws.com OR site:*.s3.ap-south-1.amazonaws.com) "nasa"

```

---

## 🛠 Github Dorks

Use these queries within GitHub to find hardcoded credentials or bucket names in source code.

* `org:nasa "amazonaws"`
* `org:nasa "bucket_name"`
* `org:nasa "aws_access_key"`
* `org:nasa "aws_access_key_id"`
* `org:nasa "aws_key"`
* `org:nasa "aws_secret"`
* `org:nasa "aws_secret_key"`
* `org:nasa "S3_BUCKET"`

---

> [!WARNING]
> **Disclaimer:** These dorks are intended for authorized security research and ethical hacking purposes only. Accessing data without explicit permission is illegal.
