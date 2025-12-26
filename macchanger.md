# Auto MAC Changer

A lightweight **Bash script** that automatically randomizes your network interface's MAC address **on every boot**, preserving the vendor (OUI) for stealth and compatibility.

Perfect for privacy enthusiasts on **Kali Linux**, Ubuntu, or any systemd-based distribution.

![Bash](https://img.shields.io/badge/Bash-Script-green) ![Linux](https://img.shields.io/badge/Linux-only-blue) ![Privacy](https://img.shields.io/badge/Privacy-Enhanced-brightgreen)

## Features

- Pure Bash — no Python or external tools needed
- Auto-detects and targets specified interface
- Vendor-preserving random MAC (`-e` style like macchanger)
- Silent operation via systemd
- Full logging to journal
- Safe: checks root, interface state, and verifies change

## Requirements

- Linux with `iproute2` (`ip` command)
- systemd
- Root privileges (via service)

## Installation

### 1. Save the Script

```bash
sudo tee /usr/local/bin/macspoof.sh > /dev/null << 'EOF'
#!/bin/bash

# Auto MAC Changer (Bash) - Vendor-preserving random MAC on boot

INTERFACE="${1:-wlan0}"  # Default to wlan0 if no arg

# Must be root
[[ $EUID -ne 0 ]] && { echo "Error: Run as root" >&2; exit 1; }

# Check if interface is active
ip link show "$INTERFACE" up &>/dev/null || { echo "Interface $INTERFACE not active. Skipping."; exit 0; }

echo "=== Auto MAC Changer (Bash) ==="
echo "Target Interface: $INTERFACE"

# Get current MAC
CURRENT_MAC=$(ip link show "$INTERFACE" | grep -oE 'link/ether [0-9a-f:]{17}' | awk '{print $2}')
[[ -z "$CURRENT_MAC" ]] && { echo "Failed to read current MAC"; exit 1; }

echo "Current MAC: $CURRENT_MAC"

# Preserve vendor (first 3 octets)
OUI=$(echo "$CURRENT_MAC" | cut -d: -f1-3)

# Random last 3 octets
RANDOM_NIC=$(printf "%02x:%02x:%02x" $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))

NEW_MAC="${OUI}:${RANDOM_NIC}"
NEW_MAC=$(echo "$NEW_MAC" | tr '[:upper:]' '[:lower:]')

echo "New MAC    : $NEW_MAC"

# Apply change
ip link set dev "$INTERFACE" down
ip link set dev "$INTERFACE" address "$NEW_MAC"
ip link set dev "$INTERFACE" up

# Verify
VERIFIED=$(ip link show "$INTERFACE" | grep -oE 'link/ether [0-9a-f:]{17}' | awk '{print $2}')
if [[ "$VERIFIED" == "$NEW_MAC" ]]; then
    echo "MAC successfully changed!"
else
    echo "Warning: Change failed (current: $VERIFIED)" >&2
fi
EOF
```

Make it executable:

```bash
sudo chmod +x /usr/local/bin/macspoof.sh
```

### 2. Create systemd Service (Templated)

```bash
sudo tee /etc/systemd/system/macspoof@.service > /dev/null << 'EOF'
[Unit]
Description=Randomize MAC address on %i (vendor-preserving)
After=network-pre.target
Wants=network-pre.target
Before=NetworkManager.service network.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/macspoof.sh %i
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
```

### 3. Enable the Service

Replace `wlan0` with your interface (e.g., `eth0`, `wlan0`):

```bash
sudo systemctl daemon-reload
sudo systemctl enable macspoof@wlan0.service
```

### 4. Disable NetworkManager MAC Randomization (Recommended)

Prevents overrides:

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

### 5. Test & Verify

Reboot, then check:

```bash
ip link show wlan0 | grep ether
```

View logs:

```bash
journalctl -u macspoof@wlan0.service -b
```

## Customization

- **Multiple interfaces**:  
  ```bash
  sudo systemctl enable macspoof@eth0.service
  sudo systemctl enable macspoof@wlan0.service
  ```

- **Fully random MAC** (no vendor preserve):  
  Edit the script and replace the OUI + random part with a full random generator.

## Disclaimer

MAC spoofing is legal for personal privacy in most jurisdictions but may violate network policies (e.g., school/work). Use responsibly.

Enjoy your rotating anonymity! 🛡️

**No more `macchanger -e` spam — clean, fast, and automatic.**
```
