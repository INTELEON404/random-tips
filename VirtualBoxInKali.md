# VirtualBox Installation on Kali Linux

This guide explains how to install **Oracle VirtualBox** on **Kali Linux (rolling release)** using the official Kali repositories.

---

## 1. Update the System

Always update your system before installing new software.

```bash
sudo apt update && sudo apt full-upgrade -y
````

Reboot if the kernel is upgraded.

---

## 2. Install Required Dependencies

VirtualBox requires kernel headers and build tools.

```bash
sudo apt install -y build-essential dkms linux-headers-$(uname -r)
```

If headers for the running kernel are unavailable:

```bash
sudo apt install -y linux-headers-amd64
```

---

## 3. Install VirtualBox

Install VirtualBox from the Kali Linux repository.

```bash
sudo apt install -y virtualbox
```

This installs VirtualBox along with DKMS-managed kernel modules.

---

## 4. Add User to `vboxusers` Group

Required for USB device access.

```bash
sudo usermod -aG vboxusers $USER
```

Log out and log back in (or reboot) to apply the change.

---

## 5. Verify Kernel Modules

Check that VirtualBox modules are loaded.

```bash
lsmod | grep vbox
```

Expected modules include:

* `vboxdrv`
* `vboxnetflt`
* `vboxnetadp`

If modules are missing, rebuild them:

```bash
sudo /sbin/vboxconfig
```

---

## 6. Launch VirtualBox

From the terminal:

```bash
virtualbox
```

Or via the menu:

```
Applications → System → VirtualBox
```

---

## 7. (Optional) Install VirtualBox Extension Pack

The Extension Pack enables:

* USB 2.0 / 3.0 support
* RDP
* Disk encryption

### Check VirtualBox version:

```bash
vboxmanage --version
```

Download the **matching version** of the Extension Pack from the official Oracle VirtualBox website and install it:

```bash
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-<version>.vbox-extpack
```

Accept the license agreement when prompted.

---

## Troubleshooting

### Kernel Module Build Errors

```bash
sudo apt install --reinstall dkms virtualbox
sudo /sbin/vboxconfig
```

### Secure Boot Enabled

VirtualBox kernel modules will not load if Secure Boot is enabled.

**Solutions:**

* Disable Secure Boot in BIOS/UEFI
* Or manually sign the kernel modules (advanced)

---

## Recommendation

If you want to run **Kali Linux inside VirtualBox**, use the **official prebuilt Kali VirtualBox image** instead of installing Kali manually in a VM.

---

## References

* Kali Linux Documentation
* Oracle VirtualBox Official Documentation

