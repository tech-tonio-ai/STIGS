<#
.SYNOPSIS
    Vulnerability Discussion:
    Some Windows features may communicate with external vendors and download components, potentially exposing sensitive data. Disabling this setting prevents the system from downloading print driver packages over HTTP.

    Check:
    Verify the registry value exists and is configured correctly. If missing or incorrect, this is a finding.

    Registry Hive: HKEY_LOCAL_MACHINE
    Registry Path: \SOFTWARE\Policies\Microsoft\Windows NT\Printers\
    Value Name: DisableWebPnPDownload
    Value Type: REG_DWORD
    Value: 1

    This script checks, remediates, and validates disabling HTTP-based print driver downloads.

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
    STIG-ID         : WN11-CC-000100
    Documentation   : https://stigaview.com/products/win11/v2r1/WN11-CC-000100/

.TESTED ON
    Date(s) Tested  : 2026-12-05
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
Save and Run as:
    WN11-CC-000100.ps1
#>

# WN11-CC-000100
# Disable Web-based Print Driver Downloads

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$ValueName    = "DisableWebPnPDownload"
$DesiredValue = 1

Write-Host "Checking compliance..."

# Ensure registry path exists
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Get current value
$currentValue = $null
try {
    $currentValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction Stop).$ValueName
}
catch {
    Write-Host "Registry value missing."
}

# Remediation
if ($currentValue -ne $DesiredValue) {

    Write-Host "Applying remediation..."

    New-ItemProperty `
        -Path $RegistryPath `
        -Name $ValueName `
        -Value $DesiredValue `
        -PropertyType DWORD `
        -Force | Out-Null

    Write-Host "Remediation applied."
}
else {
    Write-Host "System already compliant."
}

# Validation
Write-Host "Validating configuration..."

$validatedValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName).$ValueName

if ($validatedValue -eq $DesiredValue) {
    Write-Host "VALIDATION PASSED - DisableWebPnPDownload = 1"
}
else {
    Write-Host "VALIDATION FAILED"
}
