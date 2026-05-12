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
    STIG-ID         : WN11-CC-000110
    Documentation   : https://stigaview.com/products/win11/v2r2/WN11-CC-000110/

.TESTED ON
    Date(s) Tested  : 2026-12-05
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
Save and Run it as:
    WN11-CC-000110
#>

# WN11-CC-000110
# Turn off printing over HTTP

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$ValueName = "DisableHTTPPrinting"
$DesiredValue = 1

Write-Host "Checking compliance..."

# Create path if missing
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

# Remediate if needed
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
    Write-Host "VALIDATION PASSED - DisableHTTPPrinting = 1"
}
else {
    Write-Host "VALIDATION FAILED"
}
