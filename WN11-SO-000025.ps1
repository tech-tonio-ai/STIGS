<#
.SYNOPSIS
    The built-in Guest account is a well-known account that could allow unauthorized access if left unchanged.
    This PowerShell script checks if the built-in Guest account is still named "Guest", renames it, and validates the change.

    The built-in guest account is a well-known user account on all Windows systems and, as initially installed, does not require a password.
    This can allow access to system resources by unauthorized users. Renaming this account to an unidentified name improves the protection of this account and the system.

    erify the effective setting in Local Group Policy Editor. Run "gpedit.msc".

    Navigate to Local Computer Policy >> Computer Configuration >> Windows Settings >> Security Settings >> Local Policies >> Security Options.

   If the value for "Accounts: Rename guest account" is set to "Guest", this is a finding.

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
    STIG-ID         : WN11-SO-000025
    Documentation   : https://stigaview.com/products/win11/v1r6/WN11-SO-000025/

.TESTED ON
    Date(s) Tested  : 2026-12-05
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
Save and Run it as:
    WN11-SO-000025.ps1
Restart Device and verify guest account name
#>

# WN11-SO-000025
# Rename built-in Guest account

$CurrentGuestName = "Guest"
$NewGuestName = "DisabledGuest01"

Write-Host "Checking compliance..."

# Find Guest account by SID ending in -501
$GuestAccount = Get-LocalUser | Where-Object {
    $_.SID.Value -match "-501$"
}

if (-not $GuestAccount) {
    Write-Host "Guest account not found."
    exit
}

Write-Host "Current Guest account name: $($GuestAccount.Name)"

# Remediation
if ($GuestAccount.Name -eq $CurrentGuestName) {

    Write-Host "Applying remediation..."

    Rename-LocalUser `
        -Name $CurrentGuestName `
        -NewName $NewGuestName

    Write-Host "Guest account renamed to $NewGuestName"
}
else {
    Write-Host "System already compliant."
}

# Validation
Write-Host "Validating configuration..."

$ValidatedAccount = Get-LocalUser | Where-Object {
    $_.SID.Value -match "-501$"
}

if ($ValidatedAccount.Name -ne "Guest") {
    Write-Host "VALIDATION PASSED - Guest account renamed to $($ValidatedAccount.Name)"
}
else {
    Write-Host "VALIDATION FAILED"
}
