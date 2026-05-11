# STIG Remediation Guide – WN11-CC-000391

## Overview
This STIG requires configuring Internet Explorer 11 behavior in Windows 11:

> **Disable Internet Explorer 11 as a standalone browser = Enabled (Never)**

This ensures IE11 cannot run as a standalone browser.

---

## ✔ Recommended Remediation (Group Policy)

This setting must be configured using **Group Policy**, not registry edits.

### Steps:
1. Open `gpedit.msc`
2. Navigate to:
   Computer Configuration
    → Administrative Templates
    → Windows Components
    → Internet Explorer
3. Open:
**Disable Internet Explorer 11 as a standalone browser**
4. Set to:
- **Enabled**
5. Set option to:
- **Never**
6. Apply changes
7. Run:
```powershell
gpupdate /force

✔ PowerShell Verification Script

Use this script to check compliance status:
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
$ValueName = "NotifyDisableIEOptions"

try {
    $val = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction Stop).$ValueName

    if ($val -eq 0) {
        Write-Output "Compliant (Enabled)"
    }
    else {
        Write-Output "Non-Compliant (Disabled)"
    }
}
catch {
    Write-Output "Non-Compliant (Not Configured)"
}
