# 🛡️ STIG Remediation Guide – WN11-CC-000315

## 📌 STIG ID
**WN11-CC-000315**

---

## 🔍 Vulnerability Description

Standard user accounts must **not be granted elevated privileges**.  

Enabling the Windows Installer setting **AlwaysInstallElevated** allows MSI packages to run with elevated permissions, which can be exploited by attackers to:
- Gain full system control
- Install malicious software
- Escalate privileges from a standard user account

---

## 🧪 STIG Check Requirement

A finding exists if the following registry value is missing or not configured correctly:

```text
Registry Hive: HKEY_LOCAL_MACHINE
Registry Path: SOFTWARE\Policies\Microsoft\Windows\Installer
Value Name: AlwaysInstallElevated
Value Type: REG_DWORD
Value: 0
```
---
🛠️ Remediation (Group Policy – Recommended Method)

This setting should be configured using Group Policy:

📍 GPO Path
Computer Configuration
- Administrative Templates
- Windows Components
- Windows Installer
- Open:  Always install with elevated privileges
    - Set it to:
              Disabled
    - Click Apply → OK
 
---
Quick local remediation (PowerShell)

Create it manually:

```powershell
$path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"

New-Item -Path $path -Force | Out-Null

New-ItemProperty -Path $path `
  -Name "AlwaysInstallElevated" `
  -PropertyType DWord `
  -Value 0 `
  -Force
```


