<#
.SYNOPSIS
    This PowerShell script that checks if the following registry value does not exist or is not configured as specified  creates and validates it:

Registry Hive: HKEY_LOCAL_MACHINE
Registry Path: \SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters\

Value Name: SupportedEncryptionTypes

Value Type: REG_DWORD
Value: 0x7ffffff8 (2147483640)

#-------
.NOTES
    Author          : Antonio Isaacs
    LinkedIn        : 
    GitHub          : github.com/tech-tonio-ai
    Date Created    : 2026-12-05
    Last Modified   : 2026-12-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000190
    Documentation   : https://stigaview.com/products/win11/v2r3/WN11-SO-000190/

.TESTED ON
    Date(s) Tested  : 2026-12-05
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
Save and Run it as:
    WN11-SO-000190.ps1 
#>

# WN11-SO-000190 Remediation
# Configure secure Kerberos encryption types

$RegistryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$ValueName = "SupportedEncryptionTypes"
$DesiredValue = 2147483640

# Create registry path if missing
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Set registry value
New-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName `
    -Value $DesiredValue `
    -PropertyType DWORD `
    -Force | Out-Null

Write-Host "WN11-SO-000190 remediated successfully."

Write-Host "VALIDATION:"

Get-ItemProperty `
-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters" `
-Name "SupportedEncryptionTypes"
