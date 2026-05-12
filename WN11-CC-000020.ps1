<#
.SYNOPSIS
    Configuring the system to disable IPv6 source routing helps protect against packet spoofing attacks.
    This PowerShell script checks if the registry value exists and is configured correctly, remediates it if needed, and validates the result.

    Configuring the system to disable IPv6 source routing protects against spoofing.

    Check
    If the following registry value does not exist or is not configured as specified, this is a finding:
    
    Registry Hive: HKEY_LOCAL_MACHINE
    Registry Path: \SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\
    
    Value Name: DisableIpSourceRouting
    
    Value Type: REG_DWORD
    Value: 2

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
    STIG-ID         : WN11-CC-000020
    Documentation   : https://stigaview.com/products/win11/v1r6/WN11-CC-000020/

.TESTED ON
    Date(s) Tested  : 2026-12-05
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
Save and Run it as:
    WN11-CC-000020.ps1
#>

# WN11-CC-000020
# Disable IPv6 Source Routing

$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$ValueName = "DisableIpSourceRouting"
$DesiredValue = 2

Write-Host "Checking compliance..."

# Create path if missing
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Get current value
$currentValue = $null

try {
    $currentValue = (Get-ItemProperty `
        -Path $RegistryPath `
        -Name $ValueName `
        -ErrorAction Stop).$ValueName
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

$validatedValue = (Get-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName).$ValueName

if ($validatedValue -eq $DesiredValue) {
    Write-Host "VALIDATION PASSED - DisableIpSourceRouting = 2"
}
else {
    Write-Host "VALIDATION FAILED"
}
