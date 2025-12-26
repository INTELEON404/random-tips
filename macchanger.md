# Auto MAC Changer (Boot Edition)

A simple Python script that automatically randomizes your network interface's MAC address **on every boot**, preserving the original vendor (OUI) for maximum compatibility and stealth.

Ideal for privacy on **Kali Linux**, Ubuntu, or any systemd-based distro.

![Privacy](https://img.shields.io/badge/Privacy-Enhanced-blue) ![Linux](https://img.shields.io/badge/Linux-only-green) ![Python](https://img.shields.io/badge/Python-3-brightgreen)

## Features

- Auto-detects first active non-loopback interface
- New random MAC (vendor-preserving) on **every reboot**
- Silent & non-interactive — perfect for systemd
- Logs changes to journal
- Safe error handling

## Requirements

- Linux with `iproute2` (`ip` command)
- `ethtool` (optional, for permanent MAC detection)
- systemd
- Root access (via service)

## Installation

### 1. Save the Script

```bash
sudo tee /usr/local/bin/macchanger.py > /dev/null << 'EOF'
#!/usr/bin/env python3
import subprocess, re, random, sys, os

def run_command(cmd):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: {result.stderr.strip()}", file=sys.stderr)
        sys.exit(1)
    return result.stdout.strip()

def is_root():
    return os.getuid() == 0

def get_active_interfaces():
    output = run_command("ip -o link show up")
    interfaces = []
    for line in output.splitlines():
        match = re.search(r"^\d+:\s+([^:@\s]+)", line)
        if match and match.group(1) != "lo":
            interfaces.append(match.group(1))
    return interfaces

def get_current_mac(interface):
    output = run_command(f"ip link show {interface}")
    match = re.search(r"link/ether ([0-9a-f:]{17})", output)
    return match.group(1).lower() if match else None

def get_permanent_mac(interface):
    try:
        output = subprocess.run(f"ethtool -P {interface}", shell=True, capture_output=True, text=True)
        if output.returncode == 0:
            match = re.search(r"Permanent address:\s+([0-9a-f:]{17})", output.stdout)
            if match:
                return match.group(1).lower()
    except:
        pass
    return None

def change_mac(interface, new_mac):
    print(f"Changing MAC on {interface} to {new_mac}...")
    run_command(f"ip link set dev {interface} down")
    run_command(f"ip link set dev {interface} address {new_mac}")
    run_command(f"ip link set dev {interface} up")

def generate_random_mac(preserve_vendor=True, current_mac=None):
    if preserve_vendor and current_mac:
        oui = current_mac.split(":")[:3]
        random_nic = [f"{random.randint(0, 255):02x}" for _ in range(3)]
        return ":".join(oui + random_nic).lower()
    else:
        mac = [f"{random.randint(0, 255):02x}" for _ in range(6)]
        mac[0] = f"{int(mac[0], 16) & 0xFE | 0x02:02x}"
        return ":".join(mac).lower()

def main():
    if not is_root():
        print("Error: Must run as root", file=sys.stderr)
        sys.exit(1)

    print("=== Auto MAC Changer (Boot Mode) ===")
    interfaces = get_active_interfaces()
    if not interfaces:
        print("No active interfaces found.")
        sys.exit(0)

    iface = interfaces[0]
    current = get_current_mac(iface)
    permanent = get_permanent_mac(iface)

    print(f"Interface: {iface}")
    print(f"Current MAC: {current}")
    print(f"Permanent MAC: {permanent or 'Unknown'}")

    new_mac = generate_random_mac(preserve_vendor=True, current_mac=current)
    change_mac(iface, new_mac)

    verified = get_current_mac(iface)
    print(f"New MAC: {verified}")
    print("MAC successfully changed!" if verified == new_mac else "Warning: Change failed", file=sys.stderr)

if __name__ == "__main__":
    main()
EOF
```

Make executable:

```bash
sudo chmod +x /usr/local/bin/macchanger.py
```

### 2. Create systemd Service

```bash
sudo tee /etc/systemd/system/macspoof@.service > /dev/null << 'EOF'
[Unit]
Description=Randomize MAC address on %i
After=network-pre.target
Wants=network-pre.target
Before=NetworkManager.service network.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/macchanger.py
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
```

### 3. Enable Service (replace `wlan0` with your interface)

```bash
sudo systemctl daemon-reload
sudo systemctl enable macspoof@wlan0.service
```

### 4. Disable NetworkManager Randomization

```bash
sudo mkdir -p /etc/NetworkManager/conf.d
sudo tee /etc/NetworkManager/conf.d/99-disable-mac-randomization.conf > /dev/null << 'EOF'
[device]
wifi.scan-rand-mac-address=no

[connection]
wifi.cloned-mac-address=preserve
ethernet.cloned-mac-address=preserve
EOF

sudo systemctl restart NetworkManager
```

### 5. Test

Reboot and verify:

```bash
ip link show wlan0 | grep ether
```

Check logs:

```bash
journalctl -u macspoof@wlan0.service -b
```

## Customization

- **Fully random MAC** (no vendor preserve):  
  Change `preserve_vendor=True` to `False` in the script.
- **Multiple interfaces**:  
  Enable for each: `sudo systemctl enable macspoof@eth0.service`

## Disclaimer

Use responsibly. MAC spoofing is legal for privacy but may violate network policies.

Enjoy your privacy! 🛡️
