# 🐧 LINUX 101 — A TO Z MASTERCLASS
### A Complete Beginner-to-Advanced Linux Training Guide

> **Target Audience:** Beginners · Cybersecurity Students · DevOps Learners · Cloud Engineers · Ethical Hackers · SOC Analysts  
> **Format:** Slide-by-Slide Presentation · Markdown · Presentation-Ready  
> **Duration:** 3–6 Hour Workshop / Self-Paced Learning Module

---

---

# Slide 1 — Title Slide

```
╷  ╷╭╮╷╷ ╷╷ ╷╶╮ ╭─╮╶╮ 
│  ││╰┤│ │╭┼╯ │ │││ │ 
╰─╴╵╵ ╵╰─╯╵ ╵╶┴╴╰─╯╶┴╴
```

## LINUX 101 — A TO Z MASTERCLASS

**Subtitle:** From Zero to Linux Hero — Foundations, Administration, Security & Cloud

---

- 🌐 Open Source · Free · Powerful · Universal
- 🔒 Used in Servers · Cloud · Cybersecurity · AI · DevOps
- 🚀 Powers 96% of the world's top web servers
- 🤖 Runs 100% of the world's Top500 supercomputers

```
$ echo "Welcome to Linux 101"
Welcome to Linux 101
$ whoami
student
$ uname -r
6.5.0-21-generic
```

---

---

# Slide 2 — What Is Linux?

## Introduction to Linux

---

### What Is Linux?

- Linux is a **free, open-source operating system** (OS)
- Based on **UNIX** — built for stability, security, and multi-user environments
- Created by **Linus Torvalds** in 1991 as a personal project
- Not just one OS — Linux is a **kernel** (core engine)
- Linux kernel + GNU tools = **complete operating system**

---

### Key Characteristics

| Feature | Description |
|---|---|
| **Free** | Download, use, modify — at zero cost |
| **Open Source** | Full source code is publicly available |
| **Secure** | Community audited, hardened by default |
| **Stable** | Servers run for years without rebooting |
| **Flexible** | Runs on phones, servers, supercomputers, IoT |
| **Multi-user** | Multiple users can work simultaneously |
| **Multitasking** | Runs thousands of processes at once |

---

### Linux vs GNU/Linux

```
What most people call "Linux":

  GNU Tools (bash, coreutils, gcc...)
  +
  Linux Kernel (hardware management)
  =
  GNU/Linux Operating System
```

- **Richard Stallman** (GNU Project) + **Linus Torvalds** (Kernel) = Linux as we know it

---

---

# Slide 3 — Why Linux Matters

## Why Linux Dominates the World

---

### Linux by the Numbers

| Domain | Linux Share |
|---|---|
| Web Servers | **96.3%** of top 1 million websites |
| Cloud Infrastructure | **~90%** of AWS, Azure, GCP workloads |
| Supercomputers | **100%** of Top500 supercomputers |
| Android Devices | **3+ billion** devices (Linux kernel) |
| Stock Exchanges | NYSE, NASDAQ run Linux |
| Smart TVs / IoT | Majority of embedded systems |
| Docker Containers | All containers run on Linux |

---

### Why Choose Linux?

- 💸 **Free forever** — no licensing fees
- 🔒 **Security-first** — no built-in spyware or ads
- ⚡ **Performance** — lightweight, fast, efficient
- 🔧 **Full control** — customize everything
- 🛠️ **Developer-friendly** — native tools, compilers, scripting
- 🌍 **Community** — millions of contributors worldwide
- 📦 **Software freedom** — 50,000+ free packages

---

### Who Uses Linux?

```
Google      → Linux (servers + Android)
Amazon      → AWS runs on Linux
NASA        → Mission-critical systems
US Military → Security-cleared Linux systems
CERN        → Particle physics experiments
Facebook    → 100% Linux infrastructure
Netflix     → Linux-powered streaming
```

---

---

# Slide 4 — History of Linux

## A Brief Timeline

---

### Unix & Linux Timeline

```
1969 ── UNIX created at Bell Labs (Thompson & Ritchie)
         Multi-user, multi-tasking OS for mainframes

1984 ── GNU Project launched by Richard Stallman
         "Free Software" movement begins

1987 ── MINIX released (educational UNIX-like OS)
         Linus Torvalds studies it at university

1991 ── Linus Torvalds posts Linux kernel v0.01
         "Just a hobby, won't be big like GNU"

1992 ── Linux adopts GPL license (Free Software)
         Community contributions begin flooding in

1993 ── Slackware & Debian founded — first major distros

1994 ── Linux 1.0 released — production-ready

1996 ── Linux 2.0 — multi-processor support added

2003 ── Fedora & Gentoo released

2004 ── Ubuntu founded by Mark Shuttleworth
         "Linux for Human Beings"

2007 ── Android announced (Linux kernel inside)

2008 ── Red Hat Enterprise Linux dominates enterprise

2011 ── Linux kernel 3.0 milestone release

2015 ── Microsoft begins loving Linux (WSL in 2016)

2020 ── Linux 5.x — improved ARM, RISC-V support

2022 ── Linux kernel 6.0 released
         Runs on everything from watches to supercomputers

2024 ── Linux 6.x continues dominance in cloud & AI
```

---

### Key People

| Person | Contribution |
|---|---|
| **Dennis Ritchie** | Created UNIX and C language |
| **Ken Thompson** | Co-created UNIX |
| **Richard Stallman** | GNU Project, GPL license |
| **Linus Torvalds** | Linux kernel creator |
| **Mark Shuttleworth** | Founded Ubuntu |

---

---

# Slide 5 — Operating System Fundamentals

## What Does an OS Actually Do?

---

### What Is an Operating System?

- Software that **manages hardware and software resources**
- Acts as a **bridge** between user programs and hardware
- Handles: CPU time · Memory · Storage · I/O devices · Networks

---

### Core OS Components

```
┌─────────────────────────────────────────────┐
│               USER SPACE                    │
│  (Applications: Firefox, Python, Bash...)   │
├─────────────────────────────────────────────┤
│              SYSTEM CALLS                   │
│  (Interface: read, write, open, fork...)    │
├─────────────────────────────────────────────┤
│              LINUX KERNEL                   │
│  Process Mgmt │ Memory │ FS │ Networking    │
├─────────────────────────────────────────────┤
│             DEVICE DRIVERS                  │
│  (Communicate with physical hardware)       │
├─────────────────────────────────────────────┤
│               HARDWARE                      │
│        CPU │ RAM │ Disk │ NIC │ GPU         │
└─────────────────────────────────────────────┘
```

---

### OS Responsibilities

| Function | Description |
|---|---|
| **Process Management** | Creates, schedules, kills processes |
| **Memory Management** | Allocates RAM, manages virtual memory |
| **File System** | Organizes, reads, writes files |
| **Device Management** | Controls hardware via drivers |
| **Networking** | TCP/IP stack, sockets |
| **Security** | Users, permissions, access control |
| **I/O Management** | Keyboard, screen, disk input/output |

---

---

# Slide 6 — Linux Architecture

## How Linux Is Structured

---

### Architecture Overview

```
┌────────────────────────────────────────────────┐
│                  USER SPACE                    │
│                                                │
│  ┌──────────┐  ┌──────────┐  ┌──────────────┐ │
│  │  Shell   │  │   Apps   │  │  Libraries   │ │
│  │  (bash)  │  │ (python) │  │   (glibc)    │ │
│  └──────────┘  └──────────┘  └──────────────┘ │
│                                                │
├────────────────────────────────────────────────┤
│            SYSTEM CALL INTERFACE               │
│        (read, write, open, fork, exec)         │
├────────────────────────────────────────────────┤
│                 LINUX KERNEL                   │
│                                                │
│  ┌──────────┐ ┌──────────┐ ┌────────────────┐ │
│  │ Process  │ │  Memory  │ │   Filesystem   │ │
│  │ Sched.   │ │  Mgmt.   │ │   (ext4, xfs)  │ │
│  └──────────┘ └──────────┘ └────────────────┘ │
│  ┌──────────┐ ┌──────────┐ ┌────────────────┐ │
│  │ Network  │ │  Device  │ │  IPC / Signals │ │
│  │  Stack   │ │  Drivers │ │                │ │
│  └──────────┘ └──────────┘ └────────────────┘ │
├────────────────────────────────────────────────┤
│                   HARDWARE                     │
│         CPU │ RAM │ Disk │ NIC │ GPU │ USB     │
└────────────────────────────────────────────────┘
```

---

### Key Architecture Concepts

| Component | Role |
|---|---|
| **User Space** | Where all user programs run (bash, Firefox, Python) |
| **Shell** | Interface between user and kernel (bash, zsh) |
| **System Calls** | How programs request kernel services |
| **Kernel** | Core engine — controls everything |
| **Daemons** | Background services (sshd, cron, nginx) |
| **Device Drivers** | Kernel modules that talk to hardware |
| **Hardware** | Physical components the kernel manages |

---

### Monolithic Kernel

- Linux uses a **monolithic kernel** design
- All core functions run in **kernel space** (fast, efficient)
- Supports **loadable kernel modules** (add/remove without reboot)

```bash
# View loaded kernel modules
lsmod

# Load a module
sudo modprobe <module_name>

# Remove a module
sudo rmmod <module_name>
```

---

---

# Slide 7 — Linux Kernel Deep Dive

## The Heart of the OS

---

### What Does the Kernel Actually Do?

- **Process Scheduling** — decides which process runs on CPU when
- **Memory Management** — allocates/frees RAM, manages virtual memory
- **Filesystem Management** — reads/writes to ext4, xfs, btrfs
- **Network Stack** — handles TCP/IP, sockets, routing
- **Device Management** — controls hardware via drivers
- **System Calls** — secure bridge from user space to kernel
- **Security Enforcement** — permissions, namespaces, cgroups

---

### Process Scheduling

```
CPU Time Slicing:

Process A ──█████──────█████──────█████──
Process B ────────█████──────█████──────
Process C ──────────────────────────████

Scheduler algorithm: CFS (Completely Fair Scheduler)
```

---

### Kernel Modules

```bash
# List all loaded modules
lsmod | head -20

# Show module info
modinfo ext4

# Load module temporarily
sudo modprobe usb_storage

# Make permanent (add to /etc/modules)
echo "usb_storage" | sudo tee -a /etc/modules
```

---

### Kernel Version

```bash
$ uname -r
6.5.0-21-generic
  │   │  │
  │   │  └── Patch level
  │   └────── Minor version
  └────────── Major version
```

---

---

# Slide 8 — Linux vs Windows vs macOS

## Comparison Table

---

### Feature Comparison

| Feature | Linux | Windows | macOS |
|---|---|---|---|
| **Cost** | Free | $139–$200+ | Free (Mac only) |
| **Open Source** | ✅ Yes | ❌ No | ❌ No |
| **Security** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Stability** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Performance** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Customization** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| **Gaming** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| **Server Usage** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ |
| **Developer Tools** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Terminal** | Native bash/zsh | PowerShell/WSL | Terminal/zsh |
| **Virus Risk** | Very Low | High | Low |
| **Software Library** | 50,000+ packages | Large | Moderate |

---

### Server Market Share

```
Linux    ████████████████████████████████████ 96.3%
Windows  ████ 3.2%
Other    █ 0.5%
```

---

---

# Slide 9 — Linux Distributions

## Choosing Your Linux

---

### What Is a Distribution (Distro)?

```
Linux Kernel
    +
GNU Tools (bash, coreutils)
    +
Package Manager (apt, dnf, pacman)
    +
Desktop Environment (GNOME, KDE)
    +
Default Applications
    =
Linux Distribution
```

---

### Major Distributions Overview

| Distro | Base | Package Mgr | Best For | Difficulty |
|---|---|---|---|---|
| **Ubuntu** | Debian | apt | Beginners, Desktop, Server | ⭐ Easy |
| **Linux Mint** | Ubuntu | apt | Windows Switchers | ⭐ Easy |
| **Debian** | Debian | apt | Stability, Servers | ⭐⭐ Medium |
| **Fedora** | Red Hat | dnf | Developers, Cutting-Edge | ⭐⭐ Medium |
| **CentOS Stream** | Red Hat | dnf | Enterprise Labs | ⭐⭐ Medium |
| **RHEL** | Red Hat | dnf | Enterprise Production | ⭐⭐⭐ Hard |
| **Kali Linux** | Debian | apt | Cybersecurity, Pen Testing | ⭐⭐⭐ Hard |
| **Parrot OS** | Debian | apt | Forensics, Privacy | ⭐⭐ Medium |
| **Arch Linux** | Arch | pacman | Advanced Users | ⭐⭐⭐⭐⭐ Expert |
| **Alpine Linux** | Alpine | apk | Containers, Minimal | ⭐⭐⭐ Hard |
| **Raspberry Pi OS** | Debian | apt | IoT, Embedded | ⭐ Easy |

---

### Distribution Family Tree

```
UNIX
 └── Linux Kernel (1991)
      ├── Debian Family
      │    ├── Ubuntu ── Linux Mint, Pop!_OS, elementary OS
      │    ├── Kali Linux
      │    └── Parrot OS
      │
      ├── Red Hat Family
      │    ├── RHEL ── CentOS Stream, Rocky Linux
      │    └── Fedora
      │
      ├── Arch Family
      │    └── Arch Linux ── Manjaro, EndeavourOS
      │
      └── Specialized
           ├── Alpine (containers)
           ├── Tails (privacy)
           └── Gentoo (source-based)
```

---

---

# Slide 10 — Kali Linux & Cybersecurity

## Linux for Ethical Hacking

---

### What Is Kali Linux?

- Debian-based distribution built for **cybersecurity professionals**
- Maintained by **Offensive Security**
- Contains **600+ pre-installed security tools**
- Used for: Penetration testing · Digital forensics · Reverse engineering · OSINT

---

### Cybersecurity Disciplines

| Discipline | Description |
|---|---|
| **Penetration Testing** | Authorized hacking to find vulnerabilities |
| **Digital Forensics** | Investigate crimes using disk/memory analysis |
| **Vulnerability Assessment** | Identify security weaknesses in systems |
| **Wireless Security** | Test WiFi networks (WPA2, WPS) |
| **Web App Testing** | Find SQL injection, XSS, CSRF |
| **OSINT** | Open Source Intelligence gathering |
| **Malware Analysis** | Reverse engineer malicious code |

---

### Essential Cybersecurity Tools in Kali

| Tool | Purpose | Example |
|---|---|---|
| **Nmap** | Network scanner & port mapper | `nmap -sV 192.168.1.0/24` |
| **Wireshark** | Network packet analyzer | GUI — capture traffic |
| **Burp Suite** | Web app security testing | Intercept HTTP requests |
| **Metasploit** | Exploitation framework | `msfconsole` |
| **Hydra** | Brute-force password cracker | `hydra -l admin -P list.txt ssh://target` |
| **Aircrack-ng** | WiFi security testing | `aircrack-ng capture.cap` |
| **John the Ripper** | Password cracking | `john --wordlist=rockyou.txt hash.txt` |
| **Sqlmap** | SQL injection automation | `sqlmap -u "http://site/page?id=1"` |
| **Gobuster** | Web directory brute-forcer | `gobuster dir -u http://site -w list.txt` |
| **Nikto** | Web server vulnerability scanner | `nikto -h http://target.com` |

---

### Basic Nmap Examples

```bash
# Scan a single host
nmap 192.168.1.1

# Scan with version detection
nmap -sV 192.168.1.1

# Aggressive scan
nmap -A 192.168.1.1

# Scan entire subnet
nmap -sn 192.168.1.0/24

# OS detection
nmap -O 192.168.1.1

# Scan specific ports
nmap -p 22,80,443 192.168.1.1
```

> ⚠️ **Legal Warning:** Only scan systems you own or have explicit written permission to test. Unauthorized scanning is illegal.

---

---

# Slide 11 — Linux Installation & Boot Process

## From Power On to Login

---

### Boot Process — Step by Step

```
┌─────────────────────────────────────────────────┐
│  POWER ON                                       │
└──────────────────┬──────────────────────────────┘
                   ▼
┌─────────────────────────────────────────────────┐
│  BIOS / UEFI                                    │
│  • POST (Power-On Self Test)                    │
│  • Checks CPU, RAM, storage                     │
│  • Finds bootable device                        │
└──────────────────┬──────────────────────────────┘
                   ▼
┌─────────────────────────────────────────────────┐
│  BOOTLOADER (GRUB2)                             │
│  • Loaded from /boot/grub/                      │
│  • Shows OS selection menu                      │
│  • Loads Linux kernel from /boot/               │
└──────────────────┬──────────────────────────────┘
                   ▼
┌─────────────────────────────────────────────────┐
│  KERNEL LOADS                                   │
│  • Decompresses into RAM                        │
│  • Detects hardware                             │
│  • Loads initramfs (temporary root FS)          │
└──────────────────┬──────────────────────────────┘
                   ▼
┌─────────────────────────────────────────────────┐
│  INITRAMFS / INITRD                             │
│  • Temporary filesystem in RAM                  │
│  • Loads essential drivers                      │
│  • Mounts real root filesystem                  │
└──────────────────┬──────────────────────────────┘
                   ▼
┌─────────────────────────────────────────────────┐
│  SYSTEMD (PID 1)                                │
│  • First real process started                   │
│  • Manages all services & daemons               │
│  • Reaches target (multi-user / graphical)      │
└──────────────────┬──────────────────────────────┘
                   ▼
┌─────────────────────────────────────────────────┐
│  LOGIN PROMPT                                   │
│  • TTY text login OR                            │
│  • Display Manager (GDM, SDDM) for GUI          │
└─────────────────────────────────────────────────┘
```

---

### BIOS vs UEFI

| Feature | BIOS | UEFI |
|---|---|---|
| **Age** | Legacy (1975) | Modern (2000s) |
| **Boot disk size** | Max 2TB (MBR) | Supports 9.4ZB (GPT) |
| **Boot speed** | Slower | Faster |
| **Security** | None | Secure Boot |
| **Interface** | Text only | GUI available |
| **Partition table** | MBR | GPT |

---

### Useful Boot Commands

```bash
# View systemd boot time analysis
systemd-analyze

# See which services slow down boot
systemd-analyze blame

# Check system targets
systemctl list-units --type=target

# Change default target (runlevel)
sudo systemctl set-default multi-user.target
```

---

---

# Slide 12 — Linux Filesystem Hierarchy

## Understanding the / Directory Structure

---

### Full Filesystem Tree

```
/ (Root — everything starts here)
│
├── bin/       → Essential user binaries (ls, cp, bash)
├── boot/      → Bootloader, kernel images (vmlinuz, grub)
├── dev/       → Device files (sda, tty, null, random)
├── etc/       → System-wide configuration files
├── home/      → User home directories
│   ├── alice/
│   └── bob/
├── lib/       → Shared libraries for /bin and /sbin
├── lib64/     → 64-bit libraries
├── media/     → Auto-mount point for USB, CD-ROM
├── mnt/       → Temporary manual mount points
├── opt/       → Optional third-party software
├── proc/      → Virtual filesystem — live kernel/process data
├── root/      → Home directory for root user
├── run/       → Runtime data (PIDs, sockets) — cleared on reboot
├── sbin/      → System administration binaries (fdisk, ip)
├── srv/       → Data for services (web, FTP)
├── sys/       → Virtual FS — hardware info (sysfs)
├── tmp/       → Temporary files — cleared on reboot
├── usr/       → User programs, libraries, documentation
│   ├── bin/   → Non-essential user commands
│   ├── lib/   → Libraries
│   ├── local/ → Locally compiled software
│   └── share/ → Shared data, man pages
└── var/       → Variable data — logs, mail, databases
    ├── log/   → System logs
    ├── www/   → Web server files
    └── spool/ → Print queues, mail
```

---

### Key Directory Reference

| Directory | Purpose | Important Files |
|---|---|---|
| `/etc` | All config files | `/etc/passwd`, `/etc/hosts`, `/etc/ssh/sshd_config` |
| `/var/log` | System logs | `auth.log`, `syslog`, `kern.log` |
| `/proc` | Live kernel data | `/proc/cpuinfo`, `/proc/meminfo`, `/proc/uptime` |
| `/dev` | Device files | `/dev/sda` (disk), `/dev/null`, `/dev/random` |
| `/boot` | Boot files | `vmlinuz`, `initrd.img`, `grub/grub.cfg` |
| `/home` | User data | `/home/username/.bashrc`, `.ssh/` |
| `/tmp` | Temp files | Cleared each reboot — don't store important data |
| `/opt` | 3rd party apps | Google Chrome, proprietary software |

---

### Understanding Inodes

```bash
# View inode numbers
ls -li /etc/passwd

# Inode = unique file identity (metadata, not name)
# Stores: permissions, owner, size, timestamps
# Does NOT store: filename or actual data

# Check inode usage
df -i

# Find files by inode
find / -inum 12345
```

---

### Links: Hard vs Symbolic

```bash
# Hard link — same inode, different name
ln original.txt hardlink.txt

# Symbolic (soft) link — pointer to another file
ln -s /etc/nginx/nginx.conf nginx.conf

# Difference:
# Hard link: still works if original deleted
# Symlink: breaks if original deleted
```

---

---

# Slide 13 — Linux Terminal & Shell

## Command Line Mastery

---

### Terminal vs Shell vs Console

| Term | Meaning |
|---|---|
| **Terminal** | Window/interface to interact with shell |
| **TTY** | TeleTYpewriter — hardware terminal concept |
| **Shell** | Program that processes your commands |
| **Console** | Physical terminal (tty1–tty6 in Linux) |
| **Bash** | Most common shell (Bourne Again Shell) |

---

### Shell Comparison

| Shell | Name | Features | Default On |
|---|---|---|---|
| **bash** | Bourne Again Shell | Standard, scriptable | Ubuntu, Debian |
| **zsh** | Z Shell | Plugins, themes (Oh My Zsh) | macOS, Kali |
| **fish** | Fish Shell | Auto-suggest, colorful | Optional |
| **sh** | Bourne Shell | POSIX, minimal | All Unix |
| **dash** | Debian Almquist | Fast, minimal | Debian (scripts) |

---

### Environment Variables

```bash
# View all environment variables
env

# Print specific variable
echo $HOME
echo $PATH
echo $USER
echo $SHELL

# Set temporary variable
MY_VAR="hello"
echo $MY_VAR

# Set permanent variable (add to ~/.bashrc)
export MY_NAME="Alice"

# View PATH (where shell looks for commands)
echo $PATH
# /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Add directory to PATH
export PATH=$PATH:/opt/mytools/bin
```

---

### Terminal Shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl + C` | Kill current process |
| `Ctrl + Z` | Suspend process to background |
| `Ctrl + D` | Exit / EOF |
| `Ctrl + L` | Clear screen |
| `Ctrl + A` | Jump to beginning of line |
| `Ctrl + E` | Jump to end of line |
| `Ctrl + R` | Reverse search history |
| `Tab` | Auto-complete |
| `↑ ↓` | Navigate command history |

---

---

# Slide 14 — Basic Linux Commands

## Essential Commands Every User Must Know

---

### Navigation Commands

```bash
# Print Working Directory — where am I?
pwd
# Output: /home/alice

# List files (basic)
ls

# List with details (permissions, size, date)
ls -la

# List with human-readable sizes
ls -lah

# Change directory
cd /etc
cd ..        # go up one level
cd ~         # go to home directory
cd -         # go to previous directory

# Clear the terminal screen
clear        # or press Ctrl+L
```

---

### File Viewing Commands

```bash
# Display file contents
cat /etc/hostname

# Display with line numbers
cat -n /etc/passwd

# Page through large files
less /var/log/syslog
# (q to quit, / to search, n for next)

# First 10 lines
head /etc/passwd

# First 20 lines
head -n 20 /var/log/syslog

# Last 10 lines
tail /var/log/syslog

# Follow file in real-time (great for logs!)
tail -f /var/log/auth.log

# Count lines, words, characters
wc -l /etc/passwd
```

---

### System Information Commands

```bash
# Linux kernel version
uname -r

# Full system info
uname -a

# Current logged-in user
whoami

# Currently logged-in users
who
w

# System uptime
uptime

# Disk usage (human readable)
df -h

# Directory size
du -sh /var/log

# Memory usage
free -h

# CPU info
cat /proc/cpuinfo | grep "model name"

# Show hostname
hostname

# Show current date and time
date
```

---

### Text Search — grep

```bash
# Search for word in file
grep "error" /var/log/syslog

# Case-insensitive search
grep -i "error" /var/log/syslog

# Show line numbers
grep -n "error" /var/log/syslog

# Search recursively in directory
grep -r "password" /etc/

# Invert match (lines NOT matching)
grep -v "debug" /var/log/syslog

# Count matches
grep -c "error" /var/log/syslog

# Extended regex
grep -E "error|warning|critical" /var/log/syslog
```

---

### Text Processing — awk & sed

```bash
# awk — field-based text processing
# Print first column
awk '{print $1}' /etc/passwd

# Print usernames from /etc/passwd
awk -F: '{print $1}' /etc/passwd

# Print lines where field > 1000
awk -F: '$3 > 1000 {print $1, $3}' /etc/passwd

# sed — stream editor
# Replace text
sed 's/old/new/g' file.txt

# Delete line 5
sed '5d' file.txt

# Print only lines 10-20
sed -n '10,20p' file.txt

# In-place replacement
sed -i 's/http/https/g' config.txt
```

---

### Finding Files

```bash
# Find files by name
find / -name "*.conf" 2>/dev/null

# Find in specific directory
find /etc -name "ssh*"

# Find by file type
find /var -type f -name "*.log"

# Find by size (larger than 100MB)
find / -size +100M 2>/dev/null

# Find and execute command
find /tmp -name "*.tmp" -delete

# Find modified in last 24 hours
find /var/log -mtime -1

# Locate (faster, uses database)
sudo updatedb
locate nginx.conf
```

---

---

# Slide 15 — File & Directory Management

## Create, Copy, Move, Delete

---

### Creating Files & Directories

```bash
# Create empty file
touch file.txt

# Create file with content
echo "Hello Linux" > hello.txt

# Append to file
echo "Line 2" >> hello.txt

# Create directory
mkdir myproject

# Create nested directories
mkdir -p projects/linux/scripts

# Create multiple directories
mkdir dir1 dir2 dir3
```

---

### Copying & Moving

```bash
# Copy file
cp source.txt destination.txt

# Copy directory recursively
cp -r /home/alice/docs /backup/

# Copy with progress
cp -rv /home/alice /backup/

# Move (rename) file
mv oldname.txt newname.txt

# Move to directory
mv file.txt /home/alice/documents/

# Move multiple files
mv *.txt /backup/

# Interactive (prompt before overwrite)
mv -i file.txt /existing_location/
```

---

### Deleting Files

```bash
# Delete a file
rm file.txt

# Delete directory and contents (CAREFUL!)
rm -rf /tmp/old_folder

# Interactive deletion (prompts)
rm -i file.txt

# Delete all .log files
rm *.log

# Safe deletion with trash (if available)
trash file.txt

# ⚠️ NEVER RUN:
# rm -rf /     ← Destroys entire system!
# rm -rf /*    ← Same destruction!
```

---

### Archiving & Compression

```bash
# Create tar archive
tar -cvf archive.tar /home/alice/

# Create compressed archive (gzip)
tar -czf archive.tar.gz /home/alice/

# Create compressed archive (bzip2)
tar -cjf archive.tar.bz2 /home/alice/

# Extract tar archive
tar -xvf archive.tar

# Extract .tar.gz
tar -xzf archive.tar.gz

# Extract to specific directory
tar -xzf archive.tar.gz -C /tmp/

# Compress with gzip
gzip file.txt       # creates file.txt.gz

# Decompress
gunzip file.txt.gz

# Zip / Unzip
zip archive.zip file1.txt file2.txt
unzip archive.zip -d /output/directory
```

---

---

# Slide 16 — Users & Groups

## Managing Identities in Linux

---

### User Concepts

```
root (UID 0)      → Superuser — unlimited power
System users      → UIDs 1–999, run services (www-data, sshd)
Regular users     → UIDs 1000+, real human users

Every user has:
  - Username
  - UID (User ID)
  - GID (Primary Group ID)
  - Home directory
  - Login shell
```

---

### Important Files

```bash
# User account information
cat /etc/passwd
# Format: username:x:UID:GID:comment:home:shell
# alice:x:1001:1001:Alice Smith:/home/alice:/bin/bash

# Password hashes (shadow file — root only)
sudo cat /etc/shadow
# alice:$6$hash...:19000:0:99999:7:::

# Group information
cat /etc/group
# sudo:x:27:alice,bob

# View your own ID info
id
id alice
```

---

### User Management Commands

```bash
# Add new user
sudo useradd -m -s /bin/bash alice

# Set password
sudo passwd alice

# Add user with full options
sudo useradd -m -s /bin/bash -c "Alice Smith" -G sudo alice

# Delete user
sudo userdel alice

# Delete user AND home directory
sudo userdel -r alice

# Modify user — add to group
sudo usermod -aG sudo alice
sudo usermod -aG docker alice

# Switch user
su - alice

# Switch to root
sudo su -
# or
sudo -i

# Run command as another user
sudo -u alice ls /home/alice
```

---

### Group Management

```bash
# Create group
sudo groupadd developers

# Add user to group
sudo usermod -aG developers alice

# View user's groups
groups alice

# View all groups
cat /etc/group

# Delete group
sudo groupdel developers

# Change file group
chgrp developers project.txt
```

---

---

# Slide 17 — Linux Permissions & Ownership

## The rwx Security Model

---

### Understanding Permissions

```
$ ls -la /etc/passwd
-rw-r--r-- 1 root root 2847 Jan 15 10:20 /etc/passwd
│││      │   │    │
│││      │   │    └── Group owner
│││      │   └─────── User owner
│││      └─────────── Number of hard links
│││
│└┘─────────────────── Group permissions (r--)
│ └──────────────────── Other permissions (r--)
└────────────────────── User/Owner permissions (rw-)

 ┌─── File type: - (file), d (dir), l (link)
 │┌── User:  r (read) w (write) x (execute)
 ││┌─ Group: r (read) - (no write) - (no exec)
 │││┌ Others:r (read) - (no write) - (no exec)
-rw-r--r--
```

---

### Permission Values

| Symbol | Meaning | Octal Value |
|---|---|---|
| `r` | Read | 4 |
| `w` | Write | 2 |
| `x` | Execute | 1 |
| `-` | No permission | 0 |

```
Common permission sets:
  755  →  rwxr-xr-x  →  Owner: all; Group/Other: read+execute
  644  →  rw-r--r--  →  Owner: read+write; Others: read only
  600  →  rw-------  →  Owner only (private keys, configs)
  777  →  rwxrwxrwx  →  Everyone has full access (⚠️ dangerous)
  400  →  r--------  →  Read only, owner only (SSH keys)
```

---

### chmod — Change Permissions

```bash
# Symbolic method
chmod u+x script.sh          # add execute for user
chmod g-w file.txt           # remove write from group
chmod o=r file.txt           # set others to read only
chmod a+x script.sh          # add execute for ALL

# Octal method (most common)
chmod 755 script.sh          # rwxr-xr-x
chmod 644 config.txt         # rw-r--r--
chmod 600 private.key        # rw-------
chmod 700 secret_dir/        # rwx------
chmod 400 aws_key.pem        # r--------

# Recursive (apply to all files in directory)
chmod -R 755 /var/www/html/

# Common security patterns:
# SSH private key:    chmod 600 ~/.ssh/id_rsa
# SSH authorized:     chmod 644 ~/.ssh/authorized_keys
# Web server files:   chmod 644 *.html *.php
# Shell scripts:      chmod 755 deploy.sh
```

---

### chown — Change Ownership

```bash
# Change owner
chown alice file.txt

# Change owner and group
chown alice:developers file.txt

# Change only group
chown :developers file.txt
# Same as: chgrp developers file.txt

# Recursive ownership change
chown -R www-data:www-data /var/www/html/

# Change ownership of symlink itself
chown -h alice symlink.txt
```

---

### Special Permissions

```bash
# SUID (Set User ID) — runs as file owner
# Dangerous if set on scripts!
chmod u+s /usr/bin/passwd
# Shows as: -rwsr-xr-x

# SGID (Set Group ID) — inherits group
chmod g+s /shared/directory/
# Shows as: drwxr-sr-x

# Sticky Bit — only owner can delete (used on /tmp)
chmod +t /tmp
# Shows as: drwxrwxrwt

# View with octal
stat -c "%a %n" /tmp
# 1777 /tmp  (1 = sticky bit)
```

---

---

# Slide 18 — Process & Service Management

## Controlling What Runs

---

### What Is a Process?

```
Every running program = a process
Every process has:
  - PID  (Process ID)      → unique number
  - PPID (Parent PID)      → who spawned it
  - UID  (User ID)         → who owns it
  - State: R(unning), S(leeping), Z(ombie), T(stopped)
  - Priority (nice value: -20 to 19)
```

---

### Viewing Processes

```bash
# Show all processes
ps aux

# Show process tree
ps auxf

# Search for specific process
ps aux | grep nginx

# Interactive process viewer
top
htop     # Enhanced version (sudo apt install htop)

# Show processes for specific user
ps -u alice

# Find process ID by name
pgrep nginx
pidof nginx

# Show process and children
pstree

# Real-time process monitoring
watch -n 2 "ps aux | grep python"
```

---

### Managing Processes

```bash
# Kill by PID (SIGTERM — graceful)
kill 1234

# Force kill (SIGKILL — immediate)
kill -9 1234

# Kill by name
pkill nginx
killall nginx

# Send different signals
kill -15 PID    # SIGTERM (graceful stop)
kill -9  PID    # SIGKILL (force kill)
kill -1  PID    # SIGHUP  (reload config)
kill -2  PID    # SIGINT  (Ctrl+C)

# Background / Foreground
command &        # Run in background
jobs             # List background jobs
fg %1            # Bring job 1 to foreground
bg %1            # Resume suspended job in background
Ctrl+Z           # Suspend current process

# Process priority (nice value)
nice -n 10 command          # Start with lower priority
renice -n 5 -p 1234         # Change running process priority
```

---

### Service Management with systemctl

```bash
# Start a service
sudo systemctl start nginx

# Stop a service
sudo systemctl stop nginx

# Restart a service
sudo systemctl restart nginx

# Reload config without restart
sudo systemctl reload nginx

# Enable on boot
sudo systemctl enable nginx

# Disable from boot
sudo systemctl disable nginx

# Check status
sudo systemctl status nginx

# View all running services
systemctl list-units --type=service --state=running

# View failed services
systemctl --failed

# View service logs
journalctl -u nginx

# Follow service logs in real-time
journalctl -u nginx -f

# Logs from last boot
journalctl -b
```

---

---

# Slide 19 — Package Management

## Installing & Managing Software

---

### What Is a Package Manager?

- Handles installation, updating, and removal of software
- Resolves dependencies automatically
- Downloads from trusted **repositories**
- Verifies package integrity with signatures

---

### apt — Debian/Ubuntu

```bash
# Update package list from repositories
sudo apt update

# Upgrade all installed packages
sudo apt upgrade -y

# Full system upgrade (may remove packages)
sudo apt full-upgrade

# Install package
sudo apt install nginx

# Install multiple packages
sudo apt install -y git curl vim htop tmux

# Remove package (keep config files)
sudo apt remove nginx

# Remove package AND config files
sudo apt purge nginx

# Remove unused dependencies
sudo apt autoremove

# Search for package
apt search nginx

# Show package info
apt show nginx

# List installed packages
dpkg --list
apt list --installed

# Fix broken packages
sudo apt --fix-broken install
```

---

### dnf — Fedora/RHEL/CentOS

```bash
# Update all packages
sudo dnf update -y

# Install package
sudo dnf install nginx

# Remove package
sudo dnf remove nginx

# Search
sudo dnf search nginx

# Show info
sudo dnf info nginx

# List installed
dnf list installed

# Clean cache
sudo dnf clean all

# Reinstall package
sudo dnf reinstall nginx
```

---

### pacman — Arch Linux

```bash
# Sync + update all packages
sudo pacman -Syu

# Install package
sudo pacman -S nginx

# Remove package
sudo pacman -R nginx

# Remove package + dependencies
sudo pacman -Rs nginx

# Search
pacman -Ss nginx

# Show info
pacman -Si nginx

# List installed
pacman -Q

# Clean package cache
sudo pacman -Sc
```

---

### Package Manager Quick Reference

| Action | apt | dnf | pacman |
|---|---|---|---|
| Update lists | `apt update` | `dnf check-update` | `pacman -Sy` |
| Upgrade all | `apt upgrade` | `dnf upgrade` | `pacman -Su` |
| Install | `apt install pkg` | `dnf install pkg` | `pacman -S pkg` |
| Remove | `apt remove pkg` | `dnf remove pkg` | `pacman -R pkg` |
| Search | `apt search pkg` | `dnf search pkg` | `pacman -Ss pkg` |
| Info | `apt show pkg` | `dnf info pkg` | `pacman -Si pkg` |
| List installed | `dpkg --list` | `dnf list installed` | `pacman -Q` |

---

---

# Slide 20 — Linux Networking

## Connecting, Communicating, Diagnosing

---

### Network Fundamentals

```
IP Address   → Identifies device on network
Subnet Mask  → Defines network boundaries
Gateway      → Router — exit point to internet
DNS          → Translates domain names to IPs
Port         → Logical endpoint (SSH=22, HTTP=80, HTTPS=443)
MAC Address  → Hardware address of network interface
```

---

### Viewing Network Info

```bash
# Show all network interfaces and IPs
ip addr show
ip a                 # short form

# Show specific interface
ip addr show eth0

# Show routing table
ip route show
ip r

# Show default gateway
ip route | grep default

# Show network statistics
ip -s link

# Legacy commands (older systems)
ifconfig             # like ip addr
route -n             # like ip route

# Show hostname and DNS
hostname
hostname -I          # just the IP addresses
cat /etc/resolv.conf # DNS servers
```

---

### Connectivity Testing

```bash
# Ping — test if host is reachable
ping google.com
ping -c 4 8.8.8.8        # send 4 packets only

# Trace route — see path to destination
traceroute google.com
mtr google.com           # live traceroute (better)

# DNS lookup
nslookup google.com
dig google.com
dig +short google.com    # just the IP

# Check if port is open
nc -zv 192.168.1.1 22
telnet 192.168.1.1 80    # legacy

# Show open ports on YOUR system
ss -tulnp
netstat -tulnp          # legacy
```

---

### SSH — Secure Shell

```bash
# Connect to remote server
ssh user@192.168.1.100

# Connect on non-standard port
ssh -p 2222 user@server.com

# Connect with private key
ssh -i ~/.ssh/mykey.pem user@server.com

# Copy file TO remote
scp file.txt user@server:/home/user/

# Copy file FROM remote
scp user@server:/home/user/file.txt ./

# Copy directory recursively
scp -r mydir/ user@server:/tmp/

# SSH tunnel (port forwarding)
ssh -L 8080:localhost:80 user@server.com

# Generate SSH key pair
ssh-keygen -t ed25519 -C "your@email.com"

# Copy public key to server
ssh-copy-id user@server.com
```

---

### HTTP Tools

```bash
# Download a file
wget https://example.com/file.zip

# Download quietly
wget -q https://example.com/file.zip

# curl — transfer data
curl https://api.example.com

# Send GET request with headers
curl -H "Authorization: Bearer TOKEN" https://api.example.com/data

# POST JSON data
curl -X POST -H "Content-Type: application/json" \
     -d '{"key":"value"}' https://api.example.com

# Check HTTP headers only
curl -I https://example.com

# Follow redirects
curl -L https://example.com

# Download and save
curl -o output.html https://example.com

# Get public IP
curl ifconfig.me
curl api.ipify.org
```

---

### Network Monitoring

```bash
# Watch live traffic (requires root)
sudo tcpdump -i eth0

# Filter by host
sudo tcpdump -i eth0 host 192.168.1.1

# Filter by port
sudo tcpdump -i eth0 port 80

# Show connections
ss -tulnp

# Watch bandwidth usage
sudo iftop
sudo nethogs     # per process

# Check open firewall ports
sudo ufw status verbose
sudo iptables -L -n -v
```

---

---

# Slide 21 — Linux Security

## Hardening, Firewalls & Best Practices

---

### Security Principles

```
🔐 Principle of Least Privilege → Give minimum access needed
🔄 Defense in Depth             → Multiple security layers
🔍 Audit Everything             → Log, monitor, alert
🔒 Secure by Default            → Disable what you don't use
🔁 Keep Updated                 → Patch vulnerabilities fast
```

---

### UFW — Uncomplicated Firewall

```bash
# Enable UFW
sudo ufw enable

# Check status
sudo ufw status verbose

# Allow SSH (do this BEFORE enabling!)
sudo ufw allow 22/tcp
sudo ufw allow ssh

# Allow specific port
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Allow port range
sudo ufw allow 8000:9000/tcp

# Deny specific port
sudo ufw deny 23/tcp        # Block Telnet

# Allow from specific IP
sudo ufw allow from 192.168.1.100

# Delete a rule
sudo ufw delete allow 80/tcp

# Reset all rules
sudo ufw reset
```

---

### iptables — Advanced Firewall

```bash
# View current rules
sudo iptables -L -n -v

# Allow established connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP/HTTPS
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Drop all other incoming traffic
sudo iptables -A INPUT -j DROP

# Save rules permanently
sudo iptables-save > /etc/iptables/rules.v4

# Restore rules
sudo iptables-restore < /etc/iptables/rules.v4
```

---

### SSH Hardening

```bash
# Edit SSH config
sudo nano /etc/ssh/sshd_config

# Key settings to change:
Port 2222                    # Non-default port
PermitRootLogin no           # Disable root SSH
PasswordAuthentication no    # Keys only
MaxAuthTries 3               # Limit login attempts
AllowUsers alice bob         # Whitelist users only
Protocol 2                   # SSH protocol 2 only
ClientAliveInterval 300      # Timeout idle sessions
X11Forwarding no             # Disable GUI forwarding

# Restart SSH after changes
sudo systemctl restart sshd

# Install Fail2Ban (auto-ban brute force)
sudo apt install fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Check Fail2Ban jails
sudo fail2ban-client status
sudo fail2ban-client status sshd
```

---

### SELinux & AppArmor

```bash
# SELinux (Red Hat / Fedora)
getenforce                   # Check SELinux status
sudo setenforce 1            # Enforcing mode
sudo setenforce 0            # Permissive mode
cat /etc/selinux/config

# AppArmor (Ubuntu / Debian)
sudo aa-status               # Check status
sudo aa-enforce /etc/apparmor.d/*  # Enable all profiles
sudo aa-disable /etc/apparmor.d/usr.sbin.nginx  # Disable profile
```

---

### Security Audit Commands

```bash
# Check recent logins
last
lastb                 # failed logins

# Who is logged in now
who
w

# Check listening services
ss -tulnp

# Find SUID files (security risk if misconfigured)
find / -perm -4000 2>/dev/null

# Find world-writable files
find / -perm -002 -type f 2>/dev/null

# Check for unattended-upgrades
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

# View sudo log
sudo cat /var/log/auth.log | grep sudo
```

---

---

# Slide 22 — Bash Scripting

## Automate Everything

---

### What Is Bash Scripting?

- Writing a sequence of commands in a file
- Execute them automatically as a script
- Saves time, eliminates repetition, reduces errors
- Used for: backups, deployments, monitoring, automation

---

### Script Structure

```bash
#!/bin/bash
# This is a comment
# Script: hello.sh
# Purpose: Demonstrate bash basics

# Variables
NAME="Linux"
VERSION=101
DATE=$(date +%Y-%m-%d)

# Print output
echo "Welcome to $NAME $VERSION"
echo "Today is: $DATE"

# Run the script:
# chmod +x hello.sh
# ./hello.sh
```

---

### Variables & Input

```bash
#!/bin/bash

# Define variables
GREETING="Hello"
USER_NAME="Alice"
NUMBER=42

# User input
read -p "Enter your name: " INPUT_NAME
echo "Hello, $INPUT_NAME!"

# Command output as variable
CURRENT_DIR=$(pwd)
echo "You are in: $CURRENT_DIR"

# Arithmetic
RESULT=$((10 + 5))
echo "10 + 5 = $RESULT"

# Special variables
echo "Script name: $0"
echo "First argument: $1"
echo "All arguments: $@"
echo "Number of arguments: $#"
echo "Last command exit code: $?"
```

---

### Conditionals

```bash
#!/bin/bash

# if / elif / else
AGE=20

if [ $AGE -lt 18 ]; then
    echo "Minor"
elif [ $AGE -ge 18 ] && [ $AGE -lt 65 ]; then
    echo "Adult"
else
    echo "Senior"
fi

# File checks
FILE="/etc/passwd"
if [ -f "$FILE" ]; then
    echo "$FILE exists"
elif [ -d "$FILE" ]; then
    echo "$FILE is a directory"
else
    echo "$FILE not found"
fi

# String comparison
if [ "$USER" = "root" ]; then
    echo "Running as root!"
fi

# Comparison operators:
# -eq  equal to
# -ne  not equal to
# -gt  greater than
# -lt  less than
# -ge  greater than or equal
# -le  less than or equal
# -z   string is empty
# -f   file exists
# -d   directory exists
# -r   file is readable
```

---

### Loops

```bash
#!/bin/bash

# For loop
for i in {1..5}; do
    echo "Count: $i"
done

# Loop over files
for file in /etc/*.conf; do
    echo "Config file: $file"
done

# Loop over array
SERVERS=("web01" "web02" "db01" "cache01")
for server in "${SERVERS[@]}"; do
    echo "Pinging $server..."
    ping -c 1 $server > /dev/null && echo "$server is UP" || echo "$server is DOWN"
done

# While loop
COUNTER=0
while [ $COUNTER -lt 5 ]; do
    echo "Counter: $COUNTER"
    ((COUNTER++))
done

# Until loop (opposite of while)
until [ $COUNTER -eq 0 ]; do
    echo "Counting down: $COUNTER"
    ((COUNTER--))
done
```

---

### Functions

```bash
#!/bin/bash

# Define function
greet() {
    local NAME=$1      # local variable
    echo "Hello, $NAME!"
}

# Function with return value
add_numbers() {
    local RESULT=$(( $1 + $2 ))
    echo $RESULT
}

# Call functions
greet "Alice"
greet "Bob"

SUM=$(add_numbers 10 20)
echo "Sum: $SUM"

# Check if command ran successfully
check_service() {
    if systemctl is-active --quiet $1; then
        echo "✓ $1 is running"
    else
        echo "✗ $1 is NOT running"
    fi
}

check_service nginx
check_service mysql
```

---

### Real-World Script Examples

```bash
#!/bin/bash
# ===================================
# SCRIPT: system_backup.sh
# PURPOSE: Backup home directory
# ===================================

BACKUP_SOURCE="/home"
BACKUP_DEST="/backup"
DATE=$(date +%Y%m%d_%H%M%S)
ARCHIVE="backup_$DATE.tar.gz"
LOG="/var/log/backup.log"

# Create backup directory
mkdir -p $BACKUP_DEST

echo "[$(date)] Starting backup..." | tee -a $LOG

# Perform backup
if tar -czf "$BACKUP_DEST/$ARCHIVE" $BACKUP_SOURCE 2>/dev/null; then
    SIZE=$(du -sh "$BACKUP_DEST/$ARCHIVE" | cut -f1)
    echo "[$(date)] ✓ Backup successful: $ARCHIVE ($SIZE)" | tee -a $LOG
else
    echo "[$(date)] ✗ Backup FAILED!" | tee -a $LOG
    exit 1
fi

# Remove backups older than 7 days
find $BACKUP_DEST -name "backup_*.tar.gz" -mtime +7 -delete
echo "[$(date)] Old backups cleaned up." | tee -a $LOG
```

---

```bash
#!/bin/bash
# ===================================
# SCRIPT: server_monitor.sh
# PURPOSE: Check server health
# ===================================

echo "========== SERVER HEALTH CHECK =========="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo ""

# CPU Load
echo "--- CPU Load ---"
uptime
echo ""

# Memory
echo "--- Memory Usage ---"
free -h
echo ""

# Disk
echo "--- Disk Usage ---"
df -h | grep -v tmpfs
echo ""

# Services check
echo "--- Service Status ---"
for service in nginx mysql ssh; do
    if systemctl is-active --quiet $service; then
        echo "  ✓ $service is RUNNING"
    else
        echo "  ✗ $service is STOPPED"
    fi
done

echo ""
echo "=========================================="
```

---

---

# Slide 23 — Logging & Monitoring

## Know What Your System Is Doing

---

### Important Log Files

| Log File | Purpose |
|---|---|
| `/var/log/syslog` | General system messages (Ubuntu/Debian) |
| `/var/log/messages` | General system messages (RHEL/Fedora) |
| `/var/log/auth.log` | Authentication, sudo, SSH logins |
| `/var/log/kern.log` | Kernel messages |
| `/var/log/dmesg` | Boot-time hardware messages |
| `/var/log/nginx/access.log` | Nginx web server access |
| `/var/log/nginx/error.log` | Nginx errors |
| `/var/log/mysql/error.log` | MySQL database errors |
| `/var/log/dpkg.log` | Package install history |
| `/var/log/apt/history.log` | apt command history |

---

### Reading Logs

```bash
# View entire log
cat /var/log/syslog

# Follow log in real-time
tail -f /var/log/syslog

# Last 50 lines
tail -n 50 /var/log/auth.log

# Search logs
grep "Failed password" /var/log/auth.log
grep "error" /var/log/nginx/error.log

# Search multiple logs
grep -r "Out of memory" /var/log/

# View kernel ring buffer
dmesg
dmesg | tail -20
dmesg | grep -i error

# Boot messages
dmesg -T        # with readable timestamps
```

---

### journalctl — systemd Logs

```bash
# View all logs
journalctl

# Follow in real-time
journalctl -f

# From current boot only
journalctl -b

# From previous boot
journalctl -b -1

# Filter by service
journalctl -u nginx
journalctl -u ssh -f

# Filter by time
journalctl --since "2024-01-01 00:00:00"
journalctl --since "1 hour ago"
journalctl --since yesterday --until today

# Filter by priority
journalctl -p err          # errors
journalctl -p warning      # warnings

# Kernel messages
journalctl -k

# Disk usage of journal
journalctl --disk-usage

# Clean old logs
sudo journalctl --vacuum-time=7d
sudo journalctl --vacuum-size=500M
```

---

### System Monitoring Tools

```bash
# Real-time processes
top
htop          # enhanced (install if needed)

# I/O statistics
iostat -x 1

# Disk activity
iotop         # (sudo required)

# Network bandwidth
iftop         # per interface
nethogs       # per process
nload         # traffic graph

# Performance snapshot
vmstat 1 5    # virtual memory stats
sar -u 1 5    # CPU usage over time

# Comprehensive monitoring
glances       # all-in-one monitor
```

---

---

# Slide 24 — Linux in Cloud Computing

## Linux Powering the Cloud

---

### Cloud Providers & Linux

| Provider | Linux Services | Common Distros |
|---|---|---|
| **AWS** | EC2, Lambda, EKS, Fargate | Ubuntu, Amazon Linux 2, RHEL |
| **Google Cloud** | Compute Engine, GKE, Cloud Run | Debian, Ubuntu, CentOS |
| **Microsoft Azure** | VMs, AKS, Container Instances | Ubuntu, RHEL, Debian |
| **DigitalOcean** | Droplets, Kubernetes | Ubuntu, Debian, Fedora |
| **Linode/Akamai** | Compute, Kubernetes | Ubuntu, Debian, Arch |

---

### EC2 / Cloud VM Basics

```bash
# Connect to AWS EC2 instance
ssh -i mykey.pem ubuntu@ec2-XX-XX-XX-XX.compute.amazonaws.com

# Install AWS CLI
sudo apt install awscli -y
aws configure

# List S3 buckets
aws s3 ls

# Upload to S3
aws s3 cp file.txt s3://my-bucket/

# View running instances
aws ec2 describe-instances

# User data script (runs at boot on EC2)
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx
```

---

### Docker on Linux

```bash
# Install Docker
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Run container
docker run hello-world

# Run Ubuntu container interactively
docker run -it ubuntu bash

# Run nginx web server
docker run -d -p 80:80 --name webserver nginx

# List running containers
docker ps

# List all containers
docker ps -a

# Stop container
docker stop webserver

# View logs
docker logs webserver

# Build image from Dockerfile
docker build -t myapp:1.0 .

# Push to registry
docker push myrepo/myapp:1.0
```

---

### Kubernetes Basics

```bash
# Install kubectl
sudo snap install kubectl --classic

# View cluster info
kubectl cluster-info

# Get all nodes
kubectl get nodes

# Get all pods
kubectl get pods -A

# Deploy nginx
kubectl create deployment nginx --image=nginx

# Expose as service
kubectl expose deployment nginx --port=80 --type=NodePort

# Scale deployment
kubectl scale deployment nginx --replicas=3

# View deployment
kubectl describe deployment nginx

# Delete deployment
kubectl delete deployment nginx
```

---

---

# Slide 25 — Linux in DevOps

## Automation, CI/CD & Infrastructure

---

### DevOps Tools on Linux

```
┌────────────────────────────────────────────┐
│           DEVOPS TOOLCHAIN                 │
│                                            │
│  Source Control  →  Git / GitHub / GitLab  │
│  CI/CD           →  Jenkins / GitHub Actions│
│  Config Mgmt     →  Ansible / Chef / Puppet│
│  Containers      →  Docker / Podman        │
│  Orchestration   →  Kubernetes             │
│  IaC             →  Terraform / Pulumi     │
│  Monitoring      →  Prometheus / Grafana   │
│  Logging         →  ELK Stack / Loki       │
└────────────────────────────────────────────┘
```

---

### Ansible Basics

```yaml
# Ansible Playbook: install_nginx.yml
---
- name: Install and configure Nginx
  hosts: webservers
  become: yes

  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes

    - name: Install Nginx
      apt:
        name: nginx
        state: present

    - name: Start and enable Nginx
      systemd:
        name: nginx
        state: started
        enabled: yes

    - name: Allow HTTP through firewall
      ufw:
        rule: allow
        port: 80
        proto: tcp
```

```bash
# Run the playbook
ansible-playbook -i inventory install_nginx.yml
```

---

### Terraform Basics

```hcl
# Create an AWS EC2 instance
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Ubuntu 22.04
  instance_type = "t2.micro"

  tags = {
    Name = "Linux101-WebServer"
  }

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl start nginx
    EOF
}

output "public_ip" {
  value = aws_instance.web.public_ip
}
```

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

---

### CI/CD with GitHub Actions

```yaml
# .github/workflows/deploy.yml
name: Deploy to Linux Server

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v3

    - name: Run tests
      run: |
        echo "Running tests..."
        python -m pytest tests/

    - name: Deploy via SSH
      uses: appleboy/ssh-action@master
      with:
        host: ${{ secrets.SERVER_HOST }}
        username: ${{ secrets.SERVER_USER }}
        key: ${{ secrets.SSH_PRIVATE_KEY }}
        script: |
          cd /var/www/myapp
          git pull origin main
          pip install -r requirements.txt
          sudo systemctl restart myapp
```

---

---

# Slide 26 — Linux in Cybersecurity

## SOC, SIEM & Threat Hunting

---

### Security Operations (SOC) on Linux

```
SOC Analyst Daily Tasks:
  → Monitor SIEM alerts
  → Analyze logs (/var/log/auth.log, syslog)
  → Investigate suspicious processes
  → Correlate events across systems
  → Respond to incidents
  → Hunt for threats proactively
```

---

### Log Analysis for Security

```bash
# Failed SSH login attempts
grep "Failed password" /var/log/auth.log | \
  awk '{print $11}' | sort | uniq -c | sort -rn | head -20

# Successful logins
grep "Accepted password\|Accepted publickey" /var/log/auth.log

# Users who used sudo
grep "sudo:" /var/log/auth.log | grep "COMMAND"

# New user accounts created
grep "useradd\|adduser" /var/log/auth.log

# Check for rootkit (rkhunter)
sudo apt install rkhunter
sudo rkhunter --update
sudo rkhunter --check

# Check for rootkit (chkrootkit)
sudo apt install chkrootkit
sudo chkrootkit
```

---

### Threat Hunting Commands

```bash
# Find unusual SUID binaries
find / -perm -4000 -type f 2>/dev/null | \
  grep -v -E "(/bin/|/usr/bin/|/usr/sbin/)"

# Find recently modified files
find /etc /usr /bin -newer /etc/passwd -type f 2>/dev/null

# Check active network connections
ss -tulnp
netstat -tulnp

# Look for unusual listening ports
ss -tulnp | awk '{print $5}' | cut -d: -f2 | sort -n | uniq

# Check cron jobs (persistence mechanism)
crontab -l
cat /etc/cron*
ls /var/spool/cron/

# Check startup scripts
systemctl list-units --type=service --state=enabled

# Check /tmp for executables (common malware location)
find /tmp /dev/shm -type f -executable 2>/dev/null
```

---

### Incident Response Checklist

```bash
# 1. Identify the incident
who                          # Who is logged in?
last                         # Recent login history
ps aux                       # Running processes
ss -tulnp                    # Network connections

# 2. Contain the threat
sudo ufw default deny        # Block all traffic
sudo kill -9 <SUSPICIOUS_PID>

# 3. Collect evidence
sudo tar -czf /tmp/evidence_$(date +%s).tar.gz \
  /var/log /tmp /etc/cron.d /etc/cron.daily

# 4. Analyze
dmesg | grep -i error
journalctl -b -p err
strings /proc/<PID>/exe      # Examine process binary

# 5. Recover
# Restore from clean backup
# Reinstall compromised packages
# Reset credentials
```

---

---

# Slide 27 — Linux Interview Questions

## Beginner to Advanced

---

### Beginner Questions

**Q1: What is Linux?**
> Linux is a free, open-source operating system based on UNIX, created by Linus Torvalds in 1991. It consists of the Linux kernel plus GNU tools.

**Q2: What is the difference between Linux and Unix?**
> UNIX is a proprietary OS from Bell Labs (1969). Linux is an open-source UNIX-like OS. Linux is inspired by UNIX but written from scratch and is freely available.

**Q3: What does `ls -la` do?**
> Lists all files (including hidden) in long format, showing permissions, owner, size, and modification date.

**Q4: What is sudo?**
> `sudo` (superuser do) allows permitted users to run commands with root privileges without logging in as root.

**Q5: What is the difference between `rm` and `rmdir`?**
> `rmdir` removes empty directories only. `rm -rf` removes directories and all their contents recursively.

**Q6: How do you check disk space?**
> `df -h` shows disk space by filesystem. `du -sh /path` shows directory size.

**Q7: What is `/etc/passwd`?**
> It stores user account information: username, UID, GID, home directory, and login shell. Passwords are stored in `/etc/shadow`.

---

### Intermediate Questions

**Q8: What is a zombie process?**
> A zombie process has finished execution but still has an entry in the process table because the parent hasn't called `wait()`. View with `ps aux | grep Z`.

**Q9: Explain the difference between a hard link and a soft link.**
> Hard link: another name for the same inode (same data). Soft link (symlink): a pointer to another file's path. Hard links can't cross filesystems; symlinks can.

**Q10: What is the `sticky bit`?**
> When set on a directory (`chmod +t /tmp`), only the file owner can delete their files even if others have write access. Used on `/tmp`.

**Q11: How do you find which process is listening on port 80?**
> `sudo ss -tulnp | grep :80` or `sudo netstat -tulnp | grep :80` or `sudo lsof -i :80`

**Q12: What is the difference between `kill` and `kill -9`?**
> `kill PID` sends SIGTERM (15) — graceful shutdown. `kill -9 PID` sends SIGKILL — immediate forced termination, cannot be caught or ignored.

**Q13: Explain the Linux boot sequence.**
> BIOS/UEFI → GRUB2 bootloader → Kernel loads → initramfs → systemd (PID 1) → Services start → Login prompt

**Q14: What is `inode`?**
> An inode is a data structure that stores file metadata (permissions, owner, size, timestamps, data block pointers) but NOT the filename. Each file has a unique inode number.

---

### Advanced Questions

**Q15: What is the difference between process and thread?**
> A process is an independent program instance with its own memory space. A thread is a lightweight unit within a process sharing the same memory space. Linux uses `pthreads`.

**Q16: How does the Linux scheduler work?**
> Linux uses the Completely Fair Scheduler (CFS). It maintains a red-black tree of processes ordered by virtual runtime, always scheduling the process with least CPU time.

**Q17: What is a kernel panic?**
> A kernel panic occurs when the kernel encounters a fatal error it cannot recover from (hardware failure, corrupted kernel data). The system halts and displays an error message.

**Q18: Explain cgroups and namespaces.**
> **cgroups** limit resource usage (CPU, memory, I/O) per process group. **Namespaces** isolate system resources (PID, network, filesystem). Together they form the foundation of **containers** (Docker, LXC).

**Q19: How does SSH key authentication work?**
> Server holds your public key. Client signs a challenge with private key. Server verifies signature using stored public key. No password transmitted — cryptographically secure.

**Q20: What is SELinux and how does it differ from standard permissions?**
> SELinux is a Mandatory Access Control (MAC) system. Standard Linux uses Discretionary Access Control (DAC) where owners control permissions. SELinux enforces policy rules regardless of file permissions, controlled by the kernel.

---

---

# Slide 28 — Linux Q&A Database

## 50 Essential Questions & Answers

---

### Basics & Commands

| # | Question | Answer |
|---|---|---|
| 1 | What command shows current directory? | `pwd` |
| 2 | How to create a directory? | `mkdir dirname` |
| 3 | How to view file contents? | `cat file` or `less file` |
| 4 | How to search text in file? | `grep "text" file` |
| 5 | How to count lines in file? | `wc -l file` |
| 6 | How to show running processes? | `ps aux` or `top` |
| 7 | How to kill process by PID? | `kill PID` or `kill -9 PID` |
| 8 | Show disk usage? | `df -h` |
| 9 | Show memory usage? | `free -h` |
| 10 | Check kernel version? | `uname -r` |

---

### Filesystem & Permissions

| # | Question | Answer |
|---|---|---|
| 11 | What is `/proc`? | Virtual FS with live kernel/process data |
| 12 | What stores user accounts? | `/etc/passwd` |
| 13 | What stores password hashes? | `/etc/shadow` (root only) |
| 14 | What does `chmod 755` mean? | rwxr-xr-x — owner all, others read+exec |
| 15 | How to change file owner? | `chown user:group file` |
| 16 | What is SUID? | File runs with owner's privileges |
| 17 | What is sticky bit? | Only owner can delete file in directory |
| 18 | Where are system logs? | `/var/log/` |
| 19 | How to create symlink? | `ln -s target linkname` |
| 20 | How to find large files? | `find / -size +100M` |

---

### Networking

| # | Question | Answer |
|---|---|---|
| 21 | Show IP address | `ip addr show` |
| 22 | Test connectivity | `ping 8.8.8.8` |
| 23 | Show open ports | `ss -tulnp` |
| 24 | SSH to server | `ssh user@host` |
| 25 | Copy file via SSH | `scp file user@host:/path` |
| 26 | DNS lookup | `nslookup domain` or `dig domain` |
| 27 | Trace network path | `traceroute google.com` |
| 28 | Show routing table | `ip route show` |
| 29 | Capture packets | `tcpdump -i eth0` |
| 30 | Download file | `wget URL` or `curl -O URL` |

---

### Security

| # | Question | Answer |
|---|---|---|
| 31 | Enable firewall | `sudo ufw enable` |
| 32 | Allow SSH through UFW | `sudo ufw allow 22/tcp` |
| 33 | Check failed logins | `grep "Failed" /var/log/auth.log` |
| 34 | Find SUID files | `find / -perm -4000 2>/dev/null` |
| 35 | Disable root login | Edit `/etc/ssh/sshd_config` → PermitRootLogin no |
| 36 | Generate SSH key | `ssh-keygen -t ed25519` |
| 37 | View sudo access | `sudo -l` |
| 38 | Check listening services | `ss -tulnp` |
| 39 | View user login history | `last` and `lastb` |
| 40 | Scan for rootkits | `sudo rkhunter --check` |

---

### Package & Service Management

| # | Question | Answer |
|---|---|---|
| 41 | Update package list | `sudo apt update` |
| 42 | Upgrade all packages | `sudo apt upgrade` |
| 43 | Install package | `sudo apt install package` |
| 44 | Remove package | `sudo apt remove package` |
| 45 | Start a service | `sudo systemctl start nginx` |
| 46 | Enable service on boot | `sudo systemctl enable nginx` |
| 47 | Check service status | `systemctl status nginx` |
| 48 | View service logs | `journalctl -u nginx` |
| 49 | List running services | `systemctl list-units --state=running` |
| 50 | Reload service config | `sudo systemctl reload nginx` |

---

---

# Slide 29 — Linux Career Paths

## Your Future in Linux

---

### Career Map

```
Linux Skills
     │
     ├──► Linux System Administrator
     │     Salary: $65K – $120K
     │     Certs: LPIC-1, LFCA, CompTIA Linux+
     │
     ├──► DevOps Engineer
     │     Salary: $90K – $160K
     │     Certs: Docker, Kubernetes (CKA), AWS
     │
     ├──► Cloud Engineer
     │     Salary: $95K – $170K
     │     Certs: AWS SAA, GCP ACE, Azure AZ-900
     │
     ├──► Cybersecurity / Penetration Tester
     │     Salary: $80K – $150K
     │     Certs: CEH, OSCP, CompTIA Security+
     │
     ├──► SOC Analyst
     │     Salary: $55K – $100K
     │     Certs: CompTIA CySA+, GCIA, Blue Team+
     │
     └──► Site Reliability Engineer (SRE)
           Salary: $120K – $200K+
           Certs: CKA, AWS DevOps Pro, GCP DevOps
```

---

### Certifications Roadmap

| Level | Certification | Provider | Focus |
|---|---|---|---|
| **Beginner** | Linux Essentials | LPI | Core concepts |
| **Beginner** | LFCA | Linux Foundation | Cloud admin |
| **Beginner** | CompTIA Linux+ | CompTIA | Admin basics |
| **Intermediate** | LPIC-1 | LPI | Admin skills |
| **Intermediate** | LPIC-2 | LPI | Advanced admin |
| **Intermediate** | RHCSA | Red Hat | RHEL admin |
| **Advanced** | RHCE | Red Hat | Automation |
| **Advanced** | CKA | CNCF | Kubernetes admin |
| **Security** | OSCP | Offensive Security | Pen testing |
| **Security** | CEH | EC-Council | Ethical hacking |

---

---

# Slide 30 — Linux Learning Roadmap

## Beginner → Expert

---

### Phase 1: Beginner (Months 1–3)

```
✅ Install Ubuntu / Linux Mint in VM (VirtualBox / VMware)
✅ Learn terminal basics: ls, cd, pwd, mkdir, rm
✅ Understand filesystem hierarchy (/etc, /home, /var)
✅ File operations: cat, cp, mv, touch, nano
✅ Basic permissions: chmod, chown, sudo
✅ Package manager: apt update, apt install
✅ Process basics: ps, top, kill
✅ Text editing: nano (easy) and basic vim
✅ Shell: bash environment, $PATH, history

🎯 Projects:
  - Set up a LAMP stack (Linux + Apache + MySQL + PHP)
  - Write a "hello world" bash script
  - Configure UFW firewall
```

---

### Phase 2: Intermediate (Months 3–9)

```
✅ Bash scripting: variables, loops, functions, automation
✅ Network basics: ip, ping, ssh, curl, ss
✅ Service management: systemctl, journalctl
✅ User & group management: useradd, passwd, groups
✅ Advanced permissions: SUID, SGID, sticky bit
✅ Log analysis: /var/log, grep patterns
✅ Cron jobs: automated scheduling
✅ Vim editor: proper usage
✅ Git: version control basics
✅ Docker: containers fundamentals
✅ Networking: SSH keys, SSH config, SCP

🎯 Projects:
  - Automated backup script with cron
  - Docker web application deployment
  - SSH hardened server setup
  - Server health monitoring script
```

---

### Phase 3: Advanced (Months 9–18)

```
✅ Kubernetes: pods, deployments, services, ingress
✅ CI/CD: GitHub Actions, Jenkins pipelines
✅ Infrastructure as Code: Ansible, Terraform
✅ Security: SELinux, iptables, fail2ban, auditd
✅ Performance tuning: sysctl, kernel parameters
✅ Storage: LVM, RAID, NFS, Samba
✅ Cloud: AWS EC2, S3, VPC on Linux
✅ Monitoring: Prometheus, Grafana, alerting
✅ Logging: ELK Stack (Elasticsearch, Logstash, Kibana)
✅ Kernel: compilation basics, module development

🎯 Projects:
  - Production Kubernetes cluster with monitoring
  - Full CI/CD pipeline (code → test → deploy)
  - Terraform-provisioned cloud infrastructure
  - Security hardened Linux server (CIS Benchmark)
```

---

### Recommended Tools to Learn

| Category | Tools |
|---|---|
| **Terminal** | tmux, zsh + Oh My Zsh, fzf |
| **Editors** | vim/neovim, VS Code with SSH remote |
| **Monitoring** | htop, glances, Prometheus, Grafana |
| **Containers** | Docker, Kubernetes, Helm |
| **Automation** | Ansible, Terraform, bash scripts |
| **Security** | nmap, Wireshark, fail2ban, rkhunter |
| **Networking** | tcpdump, mtr, iperf3 |
| **Version Control** | git, GitHub, GitLab |

---

---

# Slide 31 — Summary & Key Takeaways

## What We Covered Today

---

### Core Concepts Recap

```
01  Linux = Kernel + GNU Tools + Distro
02  Everything is a file in Linux
03  Filesystem starts at / (root)
04  Permissions: rwx, chmod, chown, sudo
05  Processes have PIDs, managed by systemctl
06  Package managers handle all software
07  SSH is the secure way to access remote systems
08  Logs are in /var/log — always check them
09  Bash scripts automate repetitive tasks
10  Security: least privilege, firewall, updates
```

---

### The Most Important Linux Commands

```bash
# Navigation
pwd · ls -la · cd · find

# Files
cat · less · head · tail · grep · nano · vim

# Management
mkdir · rm · cp · mv · touch · tar

# System
df -h · free -h · uname -r · uptime · top

# Permissions
chmod · chown · sudo · su

# Processes
ps aux · kill · systemctl · journalctl

# Networking
ip addr · ping · ssh · curl · ss

# Packages
apt update · apt install · apt upgrade
```

---

### Final Tips for Success

- 🖥️ **Use Linux daily** — install it, don't just read about it
- 🔧 **Break things on purpose** — best way to learn to fix them
- 📖 **Read man pages** — `man ls`, `man chmod`, `man ssh`
- 🤝 **Join the community** — r/linuxquestions, Linux forums
- 📁 **Build real projects** — web server, backup scripts, monitoring
- 🔒 **Learn security from day 1** — it's not optional
- 🎯 **Choose a path** — SysAdmin, DevOps, or Cybersecurity
- 📜 **Get certified** — LFCA, LPIC-1, or CompTIA Linux+

---

### Top Resources

| Resource | URL |
|---|---|
| **Linux Journey** | linuxjourney.com |
| **Linux Foundation** | training.linuxfoundation.org |
| **OverTheWire** | overthewire.org (security wargames) |
| **TryHackMe** | tryhackme.com (hands-on labs) |
| **HackTheBox** | hackthebox.com (CTF challenges) |
| **Ryan's Tutorials** | ryanstutorials.net/linuxtutorial |
| **TLDR Pages** | tldr.sh (quick command reference) |
| **ExplainShell** | explainshell.com |
| **Linux Man Pages** | man7.org |

---

---

# Slide 32 — Thank You

## Questions & Discussion

---

```
██████╗  ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║█████╗
██║  ██║██║   ██║██║╚██╗██║██╔══╝
██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
```

## 🐧 Thank You for Learning Linux!

---

### Key Reminders

- ✅ **Practice daily** — even 30 minutes matters
- ✅ **Build projects** — real experience beats tutorials
- ✅ **Read the docs** — `man`, `--help`, official wikis
- ✅ **Join communities** — Linux is open source, so is its community
- ✅ **Never stop learning** — Linux evolves constantly

---

### Quick Reference Card

```bash
# SURVIVAL COMMANDS — remember these!

man <command>      # Read manual for ANY command
command --help     # Quick help for any command
Ctrl + C           # Kill running process
Ctrl + Z           # Suspend process
Tab                # Auto-complete everything
history            # See command history
!!                 # Repeat last command
sudo !!            # Repeat last command as root

# If you break something:
sudo apt --fix-broken install
sudo dpkg --configure -a
```

---

### Let's Connect

```
💬  Ask questions — no question is too basic
🌐  Explore: linuxjourney.com | tldr.sh
📦  Install: VirtualBox + Ubuntu (free)
🔐  Practice: TryHackMe | OverTheWire
📜  Certify: LFCA | LPIC-1 | Linux+
```

---

```
$ shutdown -h now
"The computer is yours — command it."

                        — Linux Philosophy
```

---

> **Linux 101 — A to Z Masterclass**  
> Version 1.0 · Open Source · Share Freely  
> Built with ❤️ for the Linux Community  

---

*End of Presentation*
