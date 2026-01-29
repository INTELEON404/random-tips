# Never Sleep / Suspend on Kali Linux (systemd)

This guide permanently disables **sleep, suspend, hibernate, and hybrid-sleep**
on Kali Linux so the system **never powers down automatically**
unless you explicitly shut it down or reboot.

Ideal for:
- Long-running tasks
- SSH sessions
- Compiling/cracking / lab work
- Servers & unattended machines

---

## System Information

- OS: Kali Linux
- Init system: systemd
- Scope: System-wide (root level)

---

## 1. Disable All Sleep Targets (Hard Block)

This masks systemd sleep targets by redirecting them to `/dev/null`.

```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
````

### Expected Result

```text
Created symlink /etc/systemd/system/sleep.target → /dev/null
Created symlink /etc/systemd/system/suspend.target → /dev/null
Created symlink /etc/systemd/system/hibernate.target → /dev/null
Created symlink /etc/systemd/system/hybrid-sleep.target → /dev/null
```

This ensures **no process, DE, or power manager** can trigger sleep.

---

## 2. Verify Status

```bash
systemctl status sleep.target suspend.target hibernate.target hybrid-sleep.target
```

You should see:

```text
○ sleep.target
     Loaded: masked (Reason: Unit sleep.target is masked.)
     Active: inactive (dead)

○ suspend.target
     Loaded: masked (Reason: Unit suspend.target is masked.)
     Active: inactive (dead)

○ hibernate.target
     Loaded: masked (Reason: Unit hibernate.target is masked.)
     Active: inactive (dead)

○ hybrid-sleep.target
     Loaded: masked (Reason: Unit hybrid-sleep.target is masked.)
     Active: inactive (dead)
```

---

## 3. Ignore Laptop Lid Close (Critical for Laptops)

Edit logind configuration:

```bash
sudo nano /etc/systemd/logind.conf
```

Set or modify these values:

```ini
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

Apply changes:

```bash
sudo systemctl restart systemd-logind
```

---

## 4. Disable Screen Blank & Auto Suspend (Desktop Environment)

### GNOME / XFCE / KDE

* Settings → Power

  * Blank Screen → **Never**
  * Automatic Suspend → **Off**

### XFCE Screensaver (if present)

```bash
xfconf-query -c xfce4-screensaver -p /lock/enabled -s false
xfconf-query -c xfce4-screensaver -p /saver/enabled -s false
```

---

## 5. Prevent DPMS (Monitor Sleep)

Disable Display Power Management:

```bash
xset -dpms
xset s off
```

(Optional: add to `~/.xprofile` or `~/.xinitrc`)

---

## 6. ACPI Power Button Safety (Optional)

Prevent accidental power button shutdown:

```bash
sudo nano /etc/systemd/logind.conf
```

Set:

```ini
HandlePowerKey=ignore
```

Restart:

```bash
sudo systemctl restart systemd-logind
```

---

## 7. Revert Everything (Restore Defaults)

```bash
sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
sudo systemctl restart systemd-logind
```

Re-enable screensaver/DPMS if needed.

---

## Notes & Warnings

* Keep the device **plugged in** to avoid battery drain.
* Monitor temperature during long uptime.
* Manual reboot occasionally is recommended.
* Masking sleep targets is a **hard override**—intended behavior.

---

## Tested

* Kali Linux Rolling
* XFCE / GNOME
* Laptop & Desktop

---

## License

MIT — use freely.

