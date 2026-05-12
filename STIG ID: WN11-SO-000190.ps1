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
