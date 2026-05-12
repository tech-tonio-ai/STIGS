<#
.SYNOPSIS
    Vulnerability Discussion:
    The SMB protocol is used for many network operations. Enabling SMB packet signing helps prevent man-in-the-middle attacks by ensuring communication integrity between client and server.

    Check:
    Verify the following registry value exists and is set correctly. If missing or not configured as specified, this is a finding.

    Registry Hive: HKEY_LOCAL_MACHINE
    Registry Path: \SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters\
    Value Name: RequireSecuritySignature
    Value Type: REG_DWORD
    Value: 1

    This script checks, remediates, and validates SMB client signing enforcement.

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
    STIG-ID         : WN11-SO-000100
    Documentation   : https://stigaview.com/products/win11/v1r6/WN11-SO-000100/

.TESTED ON
    Date(s) Tested  : 2026-12-05
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
Save and Run as:
    WN11-SO-000100.ps1
#>

# WN11-SO-000100
# Enforce SMB Client Signing

$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$ValueName    = "RequireSecuritySignature"
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
    Write-Host "VALIDATION PASSED - RequireSecuritySignature = 1"
}
else {
    Write-Host "VALIDATION FAILED"
}
