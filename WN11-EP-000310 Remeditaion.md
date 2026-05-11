# Kernel DMA Protection (STIG) – Configuration & Validation

## 📌 Overview

Kernel DMA Protection helps prevent **Direct Memory Access (DMA) attacks**, especially through high-speed external interfaces like Thunderbolt. These attacks can allow bypassing the lock screen or reading system memory directly from hardware devices.

In enterprise environments, this control is typically enforced via **Group Policy (GPO)**, and validated through the corresponding registry key.

---

## 🧭 Implementation Method

### ✅ Authoritative Method (Recommended)
This setting should be configured using **Group Policy (GPO)**:
Computer Configuration
 - Administrative Templates
 - System
 - Kernel DMA Protection
 - Enumeration policy for external devices incompatible with Kernel DMA Protection


Set to:
- **Enabled**
- Enumeration Policy: **Block All**

---

## ⚙️ Registry Mapping (STIG Validation)

GPO enforcement results in the following registry value:
Path:
HKLM\Software\Policies\Microsoft\Windows\Kernel DMA Protection

Value:
DeviceEnumerationPolicy (DWORD) = 0

---
```powershell
$path = "HKLM:\Software\Policies\Microsoft\Windows\Kernel DMA Protection"

New-Item -Path $path -Force | Out-Null

New-ItemProperty -Path $path `
  -Name "DeviceEnumerationPolicy" `
  -PropertyType DWord `
  -Value 0 `
  -Force
```
---

