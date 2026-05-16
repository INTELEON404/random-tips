# 🔐 SOC & Network Security — Complete Guide
### IDS | IPS | HIDS | NIDS | Firewall | SOC | SIEM | Logs | NAC | NDR
> বাস্তব উদাহরণ দিয়ে সম্পূর্ণ SOC Concepts শেখো — Beginner থেকে Intermediate

---

## 📑 Table of Contents

1. [Cyber Security Overview](#1-cyber-security-overview)
2. [Firewall — কী ও কীভাবে কাজ করে](#2-firewall)
3. [IDS — Intrusion Detection System](#3-ids)
4. [IPS — Intrusion Prevention System](#4-ips)
5. [IDS vs IPS](#5-ids-vs-ips)
6. [HIDS — Host-Based IDS](#6-hids)
7. [NIDS — Network-Based IDS](#7-nids)
8. [HIDS vs NIDS](#8-hids-vs-nids)
9. [Architecture of IDS/IPS](#9-architecture-of-idsips)
10. [Detection Methods — Signature vs Anomaly](#10-detection-methods)
11. [Log কী ও Log Analysis](#11-log--log-analysis)
12. [SOC — Security Operations Center](#12-soc)
13. [SIEM — কী ও কীভাবে কাজ করে](#13-siem)
14. [Types of SIEM Tools](#14-types-of-siem-tools)
15. [NAC — Network Access Control](#15-nac)
16. [NDR — Network Detection & Response](#16-ndr)
17. [Real-Life Attack Scenario](#17-real-life-attack-scenario)
18. [SOC Analyst Career Path](#18-soc-analyst-career-path)
19. [Best Practices & Checklist](#19-best-practices--checklist)
20. [Summary Table](#20-summary-table)

---

## 1. Cyber Security Overview

### কেন Cyber Security দরকার?

আজকের দুনিয়ায় প্রায় সবকিছু Internet-নির্ভর:

| সেক্টর | উদাহরণ |
|--------|---------|
| 💰 Finance | Online Banking, Mobile Banking |
| 🏥 Healthcare | Digital Patient Records, Hospital Systems |
| 🏛️ Government | E-passport, Tax System, NID Database |
| 🛒 Commerce | E-commerce, Payment Gateway |
| 📚 Education | Online Exam, Student Portal |

এই সিস্টেমগুলো **Cyber Attack**-এর শিকার হলে বিশাল ক্ষতি হয়।

### সাধারণ Cyber Attack-এর ধরন:

```
Cyber Attacks
├── Malware (Virus, Ransomware, Spyware)
├── Phishing (Fake Email / Website)
├── SQL Injection (Database Attack)
├── DDoS (Server Overload Attack)
├── Man-in-the-Middle (Traffic Intercept)
├── Brute Force (Password Guessing)
└── Zero-Day Exploit (Unknown Vulnerability)
```

### Building Analogy — পুরো Guide-এর মূল উদাহরণ:

> একটি বড় **Corporate Office Building** ধরো। সেখানে আছে:
> - 🚪 Main Gate Guard → **Firewall**
> - 📷 CCTV Camera → **IDS**
> - 💂 Smart Guard → **IPS**
> - 🖥️ Control Room → **SOC**
> - 🤖 AI Camera Analysis → **SIEM / NDR**
> - 🪪 ID Card System → **NAC**
>
> Cyber Security-তে ঠিক এই জিনিসগুলোই থাকে — শুধু নামগুলো আলাদা।

---

## 2. Firewall

### Firewall কী?

**Firewall** হলো Network-এর প্রথম সুরক্ষার স্তর। এটি Incoming ও Outgoing Network Traffic পর্যবেক্ষণ করে এবং **পূর্বনির্ধারিত Security Rules** অনুযায়ী Traffic Allow বা Block করে।

### বাস্তব উদাহরণ:

> তুমি একটি Apartment Building-এ ঢুকতে চাইছো। Gate-এ Guard বসে আছে। সে চেক করবে:
> - তুমি কে?
> - কোথা থেকে আসছো?
> - কার কাছে যাবে?
> - Permission আছে?
>
> সব ঠিক থাকলে → ✅ **Allow**
> কোনো সমস্যা থাকলে → ❌ **Block**

### Firewall কীভাবে কাজ করে — Step by Step:

```
Internet থেকে Traffic আসলো
          ↓
Firewall Rule Check করে
          ↓
     ┌────┴────┐
  Rule Match   Rule Match নেই
     ↓              ↓
  ✅ Allow       ❌ Block
     ↓              ↓
 Network-এ      Log-এ লেখা
  ঢুকলো          হলো
```

### Firewall Rules-এর উদাহরণ:

```
Rule 1: Allow TCP Port 80 (HTTP)       → Web Traffic
Rule 2: Allow TCP Port 443 (HTTPS)     → Secure Web
Rule 3: Block TCP Port 23 (Telnet)     → Insecure Protocol
Rule 4: Block IP 192.168.1.100         → Suspicious IP
Rule 5: Allow UDP Port 53 (DNS)        → Domain Lookup
Rule 6: Block All Others               → Default Deny
```

### Firewall-এর ধরন:

| ধরন | কাজ | উদাহরণ |
|-----|-----|--------|
| **Packet Filter Firewall** | IP, Port দেখে Block করে | সবচেয়ে Basic |
| **Stateful Firewall** | Connection-এর State Track করে | আরও Smart |
| **Application Firewall** | App-Level Traffic দেখে | WAF (Web Application Firewall) |
| **Next-Gen Firewall (NGFW)** | Deep Packet Inspection করে | Palo Alto, Fortinet |
| **Cloud Firewall** | Cloud Infrastructure রক্ষা করে | AWS Security Group |

### Firewall কোথায় থাকে?

```
Internet → [Firewall] → DMZ → [Internal Firewall] → Internal Network
                          ↓
                     Web Server
                     Mail Server
```

> **DMZ (Demilitarized Zone):** Public Server রাখার জন্য একটি আলাদা Zone — সম্পূর্ণ Internal Network-এর বাইরে, কিন্তু Internet-এরও বাইরে।

### Real Example — Firewall Block:

```log
[FIREWALL ALERT]
Time     : 2026-05-16 02:34:11
Action   : BLOCK
Src IP   : 45.33.32.156 (Russia)
Dst IP   : 192.168.10.5
Port     : 22 (SSH)
Reason   : Blacklisted IP — Brute Force Attempt
```

---

## 3. IDS

### IDS কী? — Intrusion Detection System

**IDS** হলো একটি Monitoring System যা Network বা System-এ সন্দেহজনক Activity **শনাক্ত** করে এবং Alert পাঠায়। কিন্তু এটি নিজে কোনো Action নেয় না।

### বাস্তব উদাহরণ:

> Shopping Mall-এ CCTV Camera আছে। একজন সন্দেহজনক লোক ঘুরাঘুরি করছে।
> Camera সেটা Detect করলো → **Alarm বাজলো।**
> কিন্তু Camera নিজে তাকে আটকায়নি।
>
> এটাই IDS — **দেখে + জানায়, কিন্তু থামায় না।**

### IDS কী Monitor করে?

```
IDS Monitor করে:
├── Network Traffic Patterns
├── Login Attempts (Failed/Unusual)
├── Port Scanning Activity
├── Malware Signatures
├── File System Changes
├── Protocol Anomalies
└── Bandwidth Spikes
```

### IDS Alert-এর উদাহরণ:

```log
[IDS ALERT - HIGH SEVERITY]
Time      : 2026-05-16 03:12:44
Alert     : Port Scan Detected
Source IP : 203.0.113.42
Target    : 192.168.1.0/24
Ports     : 1-65535 (Full Range Scan)
Action    : ALERT SENT to SOC Team
Note      : Possible Reconnaissance Attack
```

### IDS-এর সীমাবদ্ধতা:

| সমস্যা | ব্যাখ্যা |
|--------|---------|
| False Positive | Normal Traffic-কেও Attack মনে করে |
| False Negative | Real Attack Miss করে |
| শুধু Detect করে | Block করতে পারে না |
| Encrypted Traffic | HTTPS Traffic দেখতে পারে না (সবসময়) |

---

## 4. IPS

### IPS কী? — Intrusion Prevention System

**IPS** হলো IDS-এর উন্নত সংস্করণ। এটি শুধু Detect করে না, বরং সন্দেহজনক Traffic **স্বয়ংক্রিয়ভাবে Block** করে দেয়।

### বাস্তব উদাহরণ:

> এবার শুধু Camera নয়, একজন **Smart Guard** আছে। সে শুধু সন্দেহজনক লোক দেখেই Alarm দেয় না — বরং তাকে **ভেতরে ঢুকতেই দেয় না।**
>
> এটাই IPS — **দেখে + থামায়।**

### IPS কীভাবে কাজ করে?

```
Traffic আসলো
     ↓
IPS Inspect করলো
     ↓
  ┌──┴──┐
Normal  Suspicious
  ↓         ↓
Allow    ┌──┴──────────────┐
         Block    Log    Alert SOC
```

### IPS-এর Action Types:

| Action | কী করে |
|--------|--------|
| **Drop** | Packet মুছে দেয় |
| **Block** | IP বা Session Block করে |
| **Reset** | TCP Connection Reset করে |
| **Quarantine** | Device কে আলাদা করে |
| **Alert** | SOC Team-কে জানায় |

### IPS Real Block Example:

```log
[IPS ACTION - BLOCKED]
Time      : 2026-05-16 11:45:22
Threat    : SQL Injection Attempt
Src IP    : 45.76.123.89
Target    : 192.168.10.20 (Web Server)
Payload   : ' OR '1'='1'; DROP TABLE users;--
Action    : CONNECTION BLOCKED + IP BANNED
Duration  : 24 hours
```

---

## 5. IDS vs IPS

### পার্থক্য এক নজরে:

| বিষয় | IDS | IPS |
|------|-----|-----|
| পূর্ণ নাম | Intrusion Detection System | Intrusion Prevention System |
| কাজ | Detect + Alert | Detect + Block |
| ধরন | Passive (নিষ্ক্রিয়) | Active (সক্রিয়) |
| Network-এ অবস্থান | Out-of-band (Traffic Copy দেখে) | Inline (মাঝখানে থাকে) |
| Latency | কম | একটু বেশি |
| False Positive ঝুঁকি | কম ক্ষতিকর | বেশি ক্ষতিকর (Block করে) |
| উদাহরণ | CCTV Camera | Security Guard |
| Response | Manual (SOC করে) | Automatic |

### কোনটা ব্যবহার করবো?

```
যদি তুমি চাও শুধু Monitor করতে → IDS
যদি তুমি চাও Automatic Protection → IPS
Best Practice → IDS + IPS একসাথে ব্যবহার করো
```

> 🎯 **মনে রাখার সূত্র:**
> - **IDS** = CCTV + Alarm 📷🔔
> - **IPS** = CCTV + Alarm + Guard 📷🔔💂

---

## 6. HIDS

### HIDS কী? — Host-Based Intrusion Detection System

**HIDS** একটি নির্দিষ্ট Device (Host) — যেমন Laptop, Server বা PC — তে Install থাকে এবং সেই Device-এর সব Activity Monitor করে।

### বাস্তব উদাহরণ:

> তোমার নিজের Room-এ একটি Camera আছে। Room-এর ভেতরে কেউ কিছু করলে (Drawer খুললে, Laptop ছুঁলে) — সাথে সাথে তুমি জানতে পারবে।
>
> এটাই HIDS — **তোমার Device-এর নিজস্ব Watchman।**

### HIDS কী Monitor করে?

```
HIDS Monitor করে:
├── 📁 File Integrity (File Change হলে Alert)
├── 🔑 Login Attempts (Local ও Remote)
├── ⚙️ Running Processes (Suspicious Process চললে)
├── 📋 System Logs (Event Log, Auth Log)
├── 🔧 Registry Changes (Windows-এ)
├── 🌐 Network Connections (কোথায় Connect করছে)
└── 👤 User Privilege Changes (Admin হলো কে)
```

### HIDS Real Alert Example:

```log
[HIDS ALERT]
Host      : WORKSTATION-42
Time      : 2026-05-16 14:22:10
Event     : Critical File Modified
File      : /etc/passwd
Old Hash  : a1b2c3d4e5f6...
New Hash  : z9y8x7w6v5u4...
User      : unknown_process
Action    : ALERT — Possible Privilege Escalation
```

### HIDS-এর জনপ্রিয় Tools:

| Tool | বিশেষত্ব |
|------|---------|
| **OSSEC** | Open Source, Multi-platform |
| **Wazuh** | OSSEC-এর উন্নত সংস্করণ |
| **Tripwire** | File Integrity Monitoring |
| **Samhain** | Unix/Linux-এর জন্য |
| **Windows Defender** | Windows-এ Built-in HIDS |

---

## 7. NIDS

### NIDS কী? — Network-Based Intrusion Detection System

**NIDS** পুরো Network-এর Traffic Monitor করে। এটি Network-এর একটি Strategic Point-এ বসানো থাকে এবং সব Packet পরীক্ষা করে।

### বাস্তব উদাহরণ:

> University Campus-এর Main Gate-এ একজন Officer সব Student-এর Bag Check করছে। কেউ কিছু Suspicious নিয়ে আসলে সাথে সাথে ধরা পড়বে।
>
> এটাই NIDS — **পুরো Network-এর Traffic চেক করা।**

### NIDS কোথায় বসানো হয়?

```
Internet
    ↓
[Firewall]
    ↓
[NIDS Sensor] ←── এখানে বসানো থাকে
    ↓
Internal Network
├── Server Farm
├── Workstations
└── Database
```

### NIDS কী Detect করে?

```
NIDS Detect করে:
├── Port Scanning (Reconnaissance)
├── DDoS Attack Traffic
├── ARP Spoofing
├── DNS Poisoning
├── Malware Communication (C2 Traffic)
├── Unusual Data Exfiltration
└── Protocol Violations
```

### NIDS-এর জনপ্রিয় Tools:

| Tool | বিশেষত্ব |
|------|---------|
| **Snort** | সবচেয়ে জনপ্রিয় Open Source NIDS |
| **Suricata** | Multi-threaded, High Performance |
| **Zeek (Bro)** | Network Traffic Analyzer |
| **AIDE** | File Integrity + Network |

### NIDS Real Example:

```log
[NIDS ALERT - CRITICAL]
Time      : 2026-05-16 22:10:05
Sensor    : Network-Segment-B
Event     : DDoS Attack Detected
Source    : Multiple IPs (Botnet)
Target    : 192.168.10.1 (Web Server)
Traffic   : 98 Gbps (Normal: 500 Mbps)
Packets   : 2.3 Million/sec
Action    : ALERT + Rate Limiting Applied
```

---

## 8. HIDS vs NIDS

### পার্থক্য এক নজরে:

| বিষয় | HIDS | NIDS |
|------|------|------|
| কোথায় কাজ করে | একটি Device-এ | পুরো Network-এ |
| কী দেখে | Device Activity | Network Traffic |
| Install হয় | প্রতিটি Device-এ | Network Point-এ |
| Encrypted Traffic | দেখতে পারে ✅ | দেখতে পারে না ❌ |
| Performance Impact | হ্যাঁ (Device-এ Load) | না (Network-এ আলাদা) |
| Coverage | Limited (একটি Device) | Broad (পুরো Network) |
| উদাহরণ | Room-এর Camera | Building-এর সব CCTV |

### Best Practice:

> **HIDS + NIDS একসাথে ব্যবহার করো।**
>
> HIDS → Device-level Threat
> NIDS → Network-level Threat
>
> দুটো মিলিয়ে → **Complete Coverage** ✅

---

## 9. Architecture of IDS/IPS

### IDS/IPS-এর ভেতরে কী কী থাকে?

```
┌─────────────────────────────────────────────┐
│              IDS/IPS System                 │
│                                             │
│  ┌──────────┐    ┌──────────────────────┐   │
│  │  Sensor  │───▶│   Capture Engine     │   │
│  │(Traffic  │    │ (Packet Collection)  │   │
│  │Collector)│    └──────────┬───────────┘   │
│  └──────────┘               │               │
│                             ▼               │
│                  ┌──────────────────────┐   │
│                  │  Analysis Engine     │   │
│                  │  (Rule Processing)   │   │
│                  └──────────┬───────────┘   │
│                             │               │
│               ┌─────────────┴─────────────┐ │
│               ▼                           ▼ │
│  ┌─────────────────────┐  ┌─────────────────┐│
│  │  Signature Database │  │ Anomaly Baseline ││
│  │ (Known Attack List) │  │  (Normal Behavior││
│  └─────────────────────┘  └─────────────────┘│
│                             │               │
│                             ▼               │
│                  ┌──────────────────────┐   │
│                  │  Response Module     │   │
│                  │ Alert / Block / Log  │   │
│                  └──────────┬───────────┘   │
│                             │               │
│                             ▼               │
│                  ┌──────────────────────┐   │
│                  │  Management Console  │   │
│                  │   (Dashboard/UI)     │   │
│                  └──────────────────────┘   │
└─────────────────────────────────────────────┘
```

### প্রতিটি Component-এর কাজ:

| Component | কাজ | উদাহরণ |
|-----------|-----|--------|
| **Sensor** | Network Traffic Capture করে | CCTV Camera |
| **Capture Engine** | Packet সংগ্রহ করে | Video Recorder |
| **Analysis Engine** | Traffic Analyze করে | Security Officer |
| **Signature Database** | Known Attack Pattern রাখে | Criminal Database |
| **Anomaly Baseline** | Normal Behavior Define করে | স্বাভাবিক আচরণের নিয়ম |
| **Response Module** | Alert / Block করে | Alarm System |
| **Management Console** | Admin-কে দেখায় | Control Room Screen |

### IDS/IPS Deployment Modes:

**Inline Mode (IPS):**
```
Traffic → [IPS] → Network
          ↑
    মাঝখানে থাকে, Block করতে পারে
```

**Passive/Tap Mode (IDS):**
```
Traffic → Network
    ↓ (Copy)
   [IDS]
          ↑
    Side-এ থাকে, শুধু দেখে
```

---

## 10. Detection Methods

### দুটি প্রধান Detection পদ্ধতি:

---

### 🔍 Signature-Based Detection

**কীভাবে কাজ করে:**
Known Attack-এর একটি **Pattern Library** থাকে। নতুন Traffic সেই Pattern-এর সাথে মেলানো হয়।

**বাস্তব উদাহরণ:**
> Police আগে থেকেই Wanted Criminal-এর ছবি চিনে রাখে। কেউ মিললে সাথে সাথে ধরে।

```
Signature Example:
Alert tcp any any -> any 80 (
  msg:"SQL Injection Attempt";
  content:"OR 1=1";
  classtype:web-application-attack;
  sid:1001;
)
```

| সুবিধা | অসুবিধা |
|--------|---------|
| False Positive কম | নতুন (Zero-Day) Attack ধরতে পারে না |
| দ্রুত Detection | Database নিয়মিত Update করতে হয় |
| নির্ভরযোগ্য | Unknown Malware Miss হয় |

---

### 🧠 Anomaly-Based Detection

**কীভাবে কাজ করে:**
প্রথমে Normal Behavior শেখে (Baseline)। তারপর যখন কিছু স্বাভাবিকের বাইরে হয়, Alert দেয়।

**বাস্তব উদাহরণ:**
> একজন Student সবসময় শান্ত। হঠাৎ একদিন চিৎকার শুরু করলো। Teacher বুঝবে — কিছু একটা হয়েছে।

```
Normal Baseline:
  - Average Traffic: 100 Mbps
  - Login Time: 9 AM - 6 PM
  - Location: Dhaka, BD

Anomaly Detected:
  - Traffic: 2000 Mbps (20x বেশি!) → Alert
  - Login Time: 3 AM → Alert
  - Location: North Korea → Alert
```

| সুবিধা | অসুবিধা |
|--------|---------|
| নতুন Attack ধরতে পারে | False Positive বেশি হতে পারে |
| Zero-Day-এ কার্যকর | Baseline তৈরিতে সময় লাগে |
| AI/ML দিয়ে উন্নত | জটিল Configuration |

---

### 🔗 Hybrid Detection (Best Practice)

> **Signature + Anomaly দুটো একসাথে ব্যবহার করো।**
>
> Known Attack → Signature দিয়ে ধরো
> Unknown Attack → Anomaly দিয়ে ধরো

---

## 11. Log & Log Analysis

### Log কী?

**Log** হলো System বা Application-এর সব Activity-র স্বয়ংক্রিয় রেকর্ড। প্রতিটি ঘটনা — Login, Error, File Change, Network Connection — Log-এ লেখা হয়।

### বাস্তব উদাহরণ:

> তোমার Phone-এ আছে:
> - 📞 Call History → কে কখন Call করেছে
> - 💬 SMS History → কী Message এসেছে
> - 🌐 Browser History → কোন Website দেখেছো
>
> Computer-এও ঠিক এভাবে সব কিছুর History রাখা হয় — এটাই **Log।**

### Log-এর ধরন:

```
Logs
├── System Log       → OS-এর Event (Boot, Crash, Error)
├── Application Log  → Software-এর Activity
├── Security Log     → Login, Auth, Policy Change
├── Network Log      → Traffic, Connection, Firewall
├── Database Log     → Query, Access, Change
├── Web Server Log   → HTTP Request, Response, Error
└── Audit Log        → কে কী করেছে (Compliance)
```

### Log-এর ফরম্যাট:

**Syslog Format:**
```log
May 16 03:22:10 server01 sshd[1234]: Failed password for root from 45.33.32.156 port 54321 ssh2
```

**Windows Event Log:**
```log
Event ID : 4625
Time     : 2026-05-16 03:22:10
Type     : Audit Failure
Source   : Security
Message  : An account failed to log on
Account  : Administrator
IP       : 45.33.32.156
```

**Web Server Log (Apache):**
```log
45.33.32.156 - - [16/May/2026:03:22:10 +0600] "GET /admin/login.php HTTP/1.1" 404 1234
```

### Log Analysis কী?

**Log Analysis** হলো Log-এর ভেতর থেকে গুরুত্বপূর্ণ তথ্য বের করে Attack বা সমস্যা শনাক্ত করার প্রক্রিয়া।

**বাস্তব উদাহরণ:**
> School Teacher Attendance Sheet দেখে বুঝতে পারে:
> - কে প্রতিদিন Late আসে
> - কে বেশি Absent থাকে
> - কোনো Pattern আছে কিনা
>
> Security Analyst Log দেখে ঠিক একইভাবে Attack Pattern বোঝে।

### Suspicious Log Pattern:

```
🚨 Brute Force Attack:
  - একই IP থেকে ৫০০ বার Failed Login (৫ মিনিটে)

🚨 After-Hours Access:
  - রাত ৩টায় Admin Login (স্বাভাবিক সময় ৯টা-৬টা)

🚨 Geo-Anomaly:
  - সকালে Dhaka থেকে Login → ১ ঘণ্টা পরে Russia থেকে Login
  (একজন মানুষ ১ ঘণ্টায় দুই দেশে থাকতে পারে না)

🚨 Data Exfiltration:
  - রাতে হঠাৎ 50 GB Data বাইরে যাচ্ছে

🚨 Privilege Escalation:
  - Normal User হঠাৎ Admin Permission নিলো
```

### Log Management Best Practices:

```
✅ Centralized Log Collection (সব Log এক জায়গায়)
✅ Log Rotation (পুরনো Log Archive করো)
✅ Log Integrity (Log Tamper-proof রাখো)
✅ Retention Policy (কতদিন রাখবে ঠিক করো)
✅ Real-time Monitoring (তাৎক্ষণিক দেখো)
✅ Automated Alerting (Suspicious হলে Alert)
```

---

## 12. SOC

### SOC কী? — Security Operations Center

**SOC** হলো একটি Organization-এর **Central Security Hub** যেখানে Trained Security Analysts সর্বদা (24/7/365) Cyber Threats Monitor করে, Detect করে এবং Respond করে।

### বাস্তব উদাহরণ:

> **Airport Control Tower** কল্পনা করো। সেখানে:
> - বড় Screen-এ সব Flight Track করা হয়
> - কোনো Problem হলে সাথে সাথে Alert আসে
> - Trained Staff দ্রুত Decision নেয়
> - সব কিছু 24/7 Monitor চলে
>
> **SOC = Cyber Security-র Airport Control Tower।**

### SOC-এর মূল কাজ:

```
SOC Functions:
├── 🔍 Continuous Monitoring (24/7 দেখা)
├── 🚨 Alert Triage (কোনটা Real, কোনটা False)
├── 🔎 Incident Investigation (কী হয়েছে বোঝা)
├── 🚑 Incident Response (দ্রুত ঠিক করা)
├── 🦠 Malware Analysis (Virus বিশ্লেষণ)
├── 🎯 Threat Hunting (লুকানো Threat খোঁজা)
├── 📊 Reporting (Management-কে জানানো)
└── 🔄 Continuous Improvement (শেখা ও উন্নতি)
```

### SOC Team Structure:

```
┌─────────────────────────────────────┐
│            SOC Manager              │
│     (পুরো Team পরিচালনা)            │
└────────────────┬────────────────────┘
                 │
    ┌────────────┼────────────┐
    ▼            ▼            ▼
┌────────┐  ┌────────┐  ┌────────┐
│ Tier 1 │  │ Tier 2 │  │ Tier 3 │
│Analyst │  │Analyst │  │Analyst │
└────────┘  └────────┘  └────────┘
    │            │            │
Alert      Deep          Advanced
দেখে,    Investigation,  Threat
Basic     Incident       Hunting,
চেক       Handle        Malware
করে                    Analysis
```

### SOC Analyst-এর কাজের ধাপ:

**Incident Response Lifecycle:**

```
1. PREPARATION
   └── Tools Setup, Playbook তৈরি, Team Training

2. DETECTION & ANALYSIS
   └── Alert দেখা, Log চেক, Severity নির্ধারণ

3. CONTAINMENT
   └── Infected Device Isolate, Attack ছড়ানো থামানো

4. ERADICATION
   └── Malware মুছে ফেলা, Vulnerability ঠিক করা

5. RECOVERY
   └── System Restore, Normal Operation ফিরিয়ে আনা

6. LESSONS LEARNED
   └── কী হয়েছিল, কীভাবে ঠিক করা গেলো, ভবিষ্যতে কী করবো
```

### SOC-এ ব্যবহৃত Tools:

| Category | Tool |
|----------|------|
| SIEM | Splunk, QRadar, Wazuh |
| Ticketing | ServiceNow, Jira |
| Threat Intel | VirusTotal, MISP, ThreatConnect |
| Forensics | Autopsy, FTK, Volatility |
| SOAR | Palo Alto XSOAR, IBM Resilient |
| EDR | CrowdStrike, Carbon Black, SentinelOne |

---

## 13. SIEM

### SIEM কী? — Security Information & Event Management

**SIEM** হলো একটি Platform যা বিভিন্ন Source থেকে **Security Data ও Log Collect** করে, সেগুলো **Correlate** করে এবং **Real-time Threat Detection** করে।

### বাস্তব উদাহরণ:

> একটি বড় City-তে ৫০০টি CCTV Camera আছে। প্রতিটির ভিডিও আলাদাভাবে দেখা সম্ভব না। তাই সব ভিডিও একটি **Central Room-এ** আনা হলো এবং **AI দিয়ে Analyze** করা হচ্ছে।
>
> এটাই SIEM — **সব Security Data এক জায়গায়, AI দিয়ে বিশ্লেষণ।**

### SIEM কীভাবে কাজ করে?

```
Data Sources:
Firewall Logs ──────┐
Server Logs ────────┤
Application Logs ───┤
Network Logs ───────┼──▶ [SIEM] ──▶ Normalize ──▶ Correlate ──▶ Alert
IDS/IPS Alerts ─────┤              & Store        & Analyze
Endpoint Logs ──────┤
Cloud Logs ─────────┘
```

### SIEM-এর মূল কাজ:

| কাজ | ব্যাখ্যা |
|-----|---------|
| **Log Collection** | সব Device থেকে Log সংগ্রহ |
| **Normalization** | বিভিন্ন Format-কে একই রূপে আনা |
| **Correlation** | বিভিন্ন Event-এর সংযোগ খোঁজা |
| **Alerting** | Suspicious Activity-তে Alert |
| **Dashboards** | Real-time Security Status দেখানো |
| **Reporting** | Compliance ও Management Report |
| **Forensics** | Attack-এর পরে Investigation সহায়তা |

### SIEM Correlation — কেন দরকার?

**আলাদাভাবে দেখলে:**
```
Event 1: Failed Login at 2 AM       → হয়তো ঘুম থেকে উঠে ভুল করেছে
Event 2: Login from Russia           → হয়তো সে Russia-তে আছে
Event 3: Admin Access Granted        → হয়তো Permission নিয়েছে
Event 4: 50GB Data Transferred out   → হয়তো Backup নিচ্ছে
```

**SIEM সব একসাথে দেখলে:**
```
🚨 HIGH PRIORITY ALERT:
রাত ২টায় Russia থেকে Login → Admin নিলো → 50GB বাইরে গেলো
= এটা DATA BREACH! তাৎক্ষণিক Action দরকার!
```

### SIEM Use Case Examples:

```
Use Case 1: Brute Force Detection
  Rule: একই IP থেকে ৫ মিনিটে ১০+ Failed Login
  Action: Alert + IP Block

Use Case 2: Impossible Travel
  Rule: দুটো Login-এর মাঝে সময়/দূরত্ব অসম্ভব
  Action: Account Lock + Alert

Use Case 3: Ransomware Detection
  Rule: দ্রুত অনেক File Encrypt হচ্ছে
  Action: Critical Alert + Network Isolate

Use Case 4: Insider Threat
  Rule: নিজের কাজের বাইরে Data Access করছে
  Action: Alert + Access Review
```

---

## 14. Types of SIEM Tools

### SIEM Tool Comparison:

| Tool | ধরন | বিশেষত্ব | Best For |
|------|-----|---------|---------|
| **Splunk** | Commercial | Most Powerful, Rich Dashboard | Large Enterprise |
| **IBM QRadar** | Commercial | Advanced AI, Best Correlation | Large Enterprise |
| **Microsoft Sentinel** | Cloud | Azure Integration, Pay-as-go | Cloud-first Org |
| **Wazuh** | Open Source | Free, OSSEC-based, HIDS+SIEM | SMB, Learning |
| **ELK Stack** | Open Source | Flexible, Elasticsearch | Technical Teams |
| **Graylog** | Open Source/Commercial | Easy Log Management | Mid-size Org |
| **LogRhythm** | Commercial | Built-in SOAR, AI | Enterprise |
| **AlienVault OSSIM** | Open Source | All-in-one Security | Small Teams |

### SIEM Architecture:

```
┌──────────────────────────────────────────────────┐
│                   SIEM Platform                  │
│                                                  │
│  ┌─────────────┐    ┌─────────────┐              │
│  │   Collector  │    │   Indexer   │              │
│  │(Log Ingestion│───▶│  (Storage & │              │
│  │  & Parsing) │    │  Indexing)  │              │
│  └─────────────┘    └──────┬──────┘              │
│                            │                     │
│                  ┌─────────▼─────────┐           │
│                  │  Correlation       │           │
│                  │  Engine            │           │
│                  │  (Rule Matching)   │           │
│                  └─────────┬─────────┘           │
│                            │                     │
│           ┌────────────────┼────────────────┐    │
│           ▼                ▼                ▼    │
│     ┌──────────┐   ┌──────────┐   ┌──────────┐  │
│     │  Alert   │   │Dashboard │   │ Reports  │  │
│     │  Engine  │   │(Real-time│   │(Scheduled│  │
│     └──────────┘   │  View)   │   │  PDF)    │  │
│                    └──────────┘   └──────────┘  │
└──────────────────────────────────────────────────┘
```

### Wazuh — বিস্তারিত (Open Source Best Choice):

```
Wazuh Features:
├── Log Analysis (সব Log চেক)
├── Intrusion Detection (Attack ধরা)
├── File Integrity Monitoring (File Change ধরা)
├── Vulnerability Detection (Weak Point খোঁজা)
├── Configuration Assessment (Security Check)
├── Incident Response (Auto Response)
└── Regulatory Compliance (PCI DSS, GDPR, HIPAA)
```

---

## 15. NAC

### NAC কী? — Network Access Control

**NAC** হলো একটি Security Solution যা নিশ্চিত করে শুধুমাত্র **Authorized ও Compliant Device** Network-এ প্রবেশ করতে পারবে।

### বাস্তব উদাহরণ:

> একটি Office-এ প্রবেশ করতে **ID Card** লাগে। কিন্তু শুধু ID Card থাকলেই হবে না — Card-এ সেই Building-এর Access Permission থাকতে হবে।
>
> NAC-ও ঠিক তেমন — শুধু Authorized Device নয়, Device-টি **Security Policy Follow করছে কিনা** সেটাও দেখে।

### NAC কী চেক করে?

```
Device Network-এ ঢুকতে চাইলো
              ↓
NAC চেক করে:
├── ✅ Device কি Registered?
├── ✅ Antivirus আছে ও Updated?
├── ✅ OS আছে ও Patched?
├── ✅ Firewall চালু আছে?
├── ✅ Company Policy Follow করছে?
└── ✅ Certificate Valid?
              ↓
        সব ঠিক? → ✅ Network Access
        সমস্যা?  → ❌ Block / Quarantine
```

### NAC-এর Action Options:

| Situation | NAC-এর Action |
|-----------|--------------|
| সব Compliant | Full Network Access ✅ |
| Antivirus নেই | Guest VLAN-এ রাখো, Update করতে বলো |
| Unknown Device | Block করো |
| Outdated OS | Quarantine করো |
| Malware পাওয়া গেলো | Isolate করো + Alert |

### NAC Deployment Types:

```
Pre-Admission NAC:
  Network-এ ঢোকার আগেই চেক করে।
  "ঢোকার আগে দরজায় চেক।"

Post-Admission NAC:
  ঢোকার পরেও Continuously Monitor করে।
  "ঢোকার পরেও চোখে রাখে।"
```

### Popular NAC Solutions:

| Tool | বিশেষত্ব |
|------|---------|
| **Cisco ISE** | Enterprise NAC, 802.1X Support |
| **Aruba ClearPass** | Multi-vendor, BYOD Support |
| **ForeScout** | Agentless NAC |
| **PacketFence** | Open Source NAC |

---

## 16. NDR

### NDR কী? — Network Detection & Response

**NDR** হলো একটি Advanced Security Technology যা AI ও Machine Learning ব্যবহার করে Network Traffic-এ **Sophisticated ও Hidden Threats** শনাক্ত করে এবং স্বয়ংক্রিয়ভাবে Response দেয়।

### বাস্তব উদাহরণ:

> একটি Smart AI Security System আছে যা:
> - সব CCTV-র ভিডিও একসাথে দেখে
> - মানুষের আচরণের Pattern শেখে
> - অস্বাভাবিক কিছু হলে AI নিজেই Alert দেয়
> - অনেক ক্ষেত্রে নিজেই Action নেয়
>
> এটাই NDR — **AI-powered Smart Network Monitoring।**

### NDR vs Traditional IDS/IPS:

| বিষয় | Traditional IDS/IPS | NDR |
|------|---------------------|-----|
| Detection Method | Rule/Signature Based | AI/ML Based |
| Unknown Threat | দুর্বল | শক্তিশালী |
| Encrypted Traffic | দেখতে পারে না | Metadata দেখে |
| Response | Manual/Basic | Automated/Smart |
| False Positive | বেশি | কম |
| East-West Traffic | সীমিত | ভালো |

### NDR কী করতে পারে?

```
NDR Capabilities:
├── 🤖 AI-based Threat Detection
├── 🔍 Deep Packet Inspection
├── 📊 Behavior Analytics (UEBA)
├── 🌐 East-West Traffic Monitoring (Internal)
├── 🔐 Encrypted Traffic Analysis
├── ⚡ Automated Response (SOAR Integration)
├── 🕵️ Threat Hunting Support
└── 📈 Network Visibility ও Topology Mapping
```

### NDR Real Scenario:

```
Scenario: APT (Advanced Persistent Threat) Attack

Day 1:  Hacker Email দিয়ে ঢুকলো (Phishing)
Day 5:  ধীরে ধীরে Network-এ ছড়াচ্ছে (Lateral Movement)
Day 15: Secret Data সংগ্রহ করছে (Exfiltration Prep)
Day 30: Data বাইরে পাঠানোর চেষ্টা

Traditional IDS: Day 30-এ ধরতো (অনেক দেরি)
NDR: Day 5-এ Unusual Behavior দেখেই Alert দিতো!
```

### Popular NDR Solutions:

| Tool | বিশেষত্ব |
|------|---------|
| **Darktrace** | AI Self-learning, "Immune System" |
| **Vectra AI** | AI-driven, Attack Signal Intelligence |
| **ExtraHop** | Real-time Network Intelligence |
| **Cisco Stealthwatch** | Enterprise NDR, Cisco Integration |
| **Corelight** | Zeek-based Open Source NDR |

---

## 17. Real-Life Attack Scenario

### সম্পূর্ণ Attack Scenario — সব Technology একসাথে

**Scenario: একটি Bank-এ Cyber Attack**

```
🏦 Bank Network Architecture:
Internet → Firewall → DMZ → Internal Network
                       ↓
                  Web Server
                  Mail Server
                       ↓
              Internal Network:
              - Core Banking System
              - Employee Workstations
              - Database Server
```

**Attack Timeline:**

```
⏰ 09:00 AM — Reconnaissance
  Hacker: Bank-এর Website Scan করলো
  NIDS: Port Scan Alert দিলো → SOC Tier 1 দেখলো

⏰ 11:30 AM — Phishing Email
  Hacker: Fake HR Email পাঠালো Employee-কে
  Employee: Malicious Attachment Download করলো
  HIDS: Unknown Process Alert দিলো

⏰ 12:15 PM — Malware Execution
  Malware: Employee PC-তে চালু হলো
  HIDS: File Change + Suspicious Process Alert
  SIEM: Multiple Alerts Correlate করলো → High Priority

⏰ 02:30 PM — Lateral Movement
  Malware: Network-এ ছড়ানোর চেষ্টা করলো
  NDR: Unusual Internal Traffic Detect করলো
  NAC: Infected PC-কে Quarantine করলো

⏰ 03:00 PM — SOC Response
  Tier 2 Analyst: Investigation শুরু করলো
  Action: Infected PC Network থেকে বিচ্ছিন্ন
  IPS: Malware C2 Server-এর IP Block করলো

⏰ 04:00 PM — Containment Complete
  SOC Manager: Incident Declared Contained
  Forensics: Evidence Collection শুরু
  Report: Management-কে জানানো হলো

⏰ Next Day — Recovery
  IT Team: Clean Restore করলো
  Security Team: Vulnerability Patch করলো
  Training: Employee Phishing Training দেওয়া হলো
```

**কোন Technology কী করলো:**

| Technology | কাজ |
|-----------|-----|
| **NIDS** | Port Scan প্রথমে Detect করলো |
| **HIDS** | Malware Execution Alert দিলো |
| **SIEM** | সব Alert Correlate করে High Priority দিলো |
| **NDR** | Lateral Movement Detect করলো |
| **NAC** | Infected Device Isolate করলো |
| **IPS** | C2 Communication Block করলো |
| **Firewall** | External Communication Filter করলো |
| **SOC** | পুরো Response Coordinate করলো |

---

## 18. SOC Analyst Career Path

### তুমি কীভাবে SOC Analyst হবে?

```
Beginner Level:
├── Networking Basics (TCP/IP, DNS, HTTP)
├── Linux & Windows OS
├── Basic Security Concepts
└── CompTIA Security+ Certification

Junior SOC Analyst (Tier 1):
├── Log Analysis
├── Alert Triage
├── SIEM Tool Usage (Splunk/Wazuh)
├── Basic Incident Response
└── CEH / eJPT Certification

Mid-Level SOC Analyst (Tier 2):
├── Malware Analysis (Basic)
├── Network Forensics
├── Threat Intelligence
├── Scripting (Python/Bash)
└── GCIH / CySA+ Certification

Senior SOC Analyst (Tier 3):
├── Advanced Threat Hunting
├── Reverse Engineering
├── Red Team Knowledge
├── SOAR/Automation
└── GCIA / OSCP Certification
```

### SOC Analyst-এর Daily Tasks:

```
Morning:
  ✅ Overnight Alert Review করো
  ✅ Open Incident Status চেক করো
  ✅ Threat Intelligence Feed দেখো

During Shift:
  ✅ Real-time Alert Monitor করো
  ✅ Investigation করো
  ✅ Incident Ticket Update করো
  ✅ Team-এর সাথে Communicate করো

End of Shift:
  ✅ Handover Note তৈরি করো
  ✅ Daily Report লেখো
  ✅ Open Case Next Shift-এ দাও
```

---

## 19. Best Practices & Checklist

### Organization-এর জন্য Security Checklist:

**Network Security:**
```
✅ Firewall সব Layer-এ (Perimeter, Internal, Host)
✅ IDS/IPS Deployed এবং Updated
✅ Network Segmentation (VLAN)
✅ NAC দিয়ে Device Control
✅ VPN সব Remote Access-এ
✅ NDR দিয়ে East-West Traffic Monitor
```

**Identity & Access:**
```
✅ MFA (Multi-Factor Authentication) সবখানে
✅ Least Privilege Principle (দরকারি Permission-ই শুধু)
✅ Regular Password Policy
✅ Privileged Account Monitoring
✅ Zero Trust Architecture
```

**Monitoring & Response:**
```
✅ SIEM দিয়ে Central Log Collection
✅ 24/7 SOC (নিজের বা Managed)
✅ Incident Response Plan তৈরি রাখো
✅ Regular Drill/Tabletop Exercise করো
✅ Threat Intelligence Feed Subscribe করো
```

**Endpoint Security:**
```
✅ EDR (Endpoint Detection & Response) সব Device-এ
✅ Regular Patch Management
✅ Application Whitelisting
✅ USB Control Policy
✅ Full Disk Encryption
```

**People & Process:**
```
✅ নিয়মিত Security Awareness Training
✅ Phishing Simulation করো
✅ Vendor/Third-party Risk Assessment
✅ Regular Penetration Testing
✅ Backup ও Disaster Recovery Plan
```

---

## 20. Summary Table

### সব Concept এক নজরে:

| Technology | পূর্ণ নাম | মূল কাজ | Building Analogy | জনপ্রিয় Tool |
|-----------|----------|---------|-----------------|--------------|
| **Firewall** | — | Traffic Allow/Block | Main Gate Guard | pfSense, Palo Alto |
| **IDS** | Intrusion Detection System | Detect + Alert | CCTV Camera | Snort, Suricata |
| **IPS** | Intrusion Prevention System | Detect + Block | Smart Guard | Snort (Inline), Suricata |
| **HIDS** | Host-Based IDS | Device Monitor | Room Camera | Wazuh, OSSEC |
| **NIDS** | Network-Based IDS | Network Monitor | Building CCTV | Snort, Zeek |
| **Log** | — | Activity Record | Call History | Syslog, Windows Event |
| **SOC** | Security Operations Center | 24/7 Monitor & Response | Airport Control Room | Processes + People |
| **SIEM** | Security Info & Event Mgmt | Log Collect + Correlate | AI Camera Analysis | Splunk, Wazuh, QRadar |
| **NAC** | Network Access Control | Device Access Control | ID Card System | Cisco ISE, PacketFence |
| **NDR** | Network Detection & Response | AI Threat Detect | Smart AI Guard | Darktrace, Vectra |

---

## 💬 Final Thought

> **Cyber Security মানে শুধু Tool Install করা না।**
>
> এটা হলো একটি **Ecosystem:**
>
> ```
> Technology (Tool)
>       +
> Process (Procedure)
>       +
> People (Skilled Analyst)
>       =
> Real Security
> ```
>
> যত ভালো Monitoring, তত দ্রুত Attack ধরা যাবে।
> যত দ্রুত Response, তত কম ক্ষতি হবে।

---

*🔐 Stay Secure | 🛡️ Think Like a Defender | 👨‍💻 Learn Continuously*

> **এই Guide টি তৈরি করা হয়েছে SOC Analyst, Security Student এবং IT Professional-দের জন্য।**
