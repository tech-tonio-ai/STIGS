<#
.SYNOPSIS
    Windows Game Recording and Broadcasting is intended for use with games; however, it could potentially record screen shots of other applications and expose sensitive data. Disabling the feature will prevent this from occurring
    This PowerShell script that checks if the following registry value does not exist or is not configured as specified  creates and validates it:

Registry Hive: HKEY_LOCAL_MACHINE
Registry Path: \SOFTWARE\Policies\Microsoft\Windows\GameDVR\

Value Name: AllowGameDVR

Type: REG_DWORD
Value: 0x00000000 (0)

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
    STIG-ID         :  WN11-CC-000252
    Documentation   : https://stigaview.com/products/win11/v2r2/WN11-CC-000110/

.TESTED ON
    Date(s) Tested  : 2026-12-05
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
Save and Run it as:
     WN11-CC-000252
#>


# ----
# WN11-CC-000252
# Disable Windows Game Recording and Broadcasting

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
$ValueName = "AllowGameDVR"
$DesiredValue = 0

Write-Host "Checking compliance..."

# Create registry path if missing
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
    Write-Host "VALIDATION PASSED - AllowGameDVR = 0"
}
else {
    Write-Host "VALIDATION FAILED"
}
