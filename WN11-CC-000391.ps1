<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Antonio I
    LinkedIn        : 
    GitHub          : https://github.com/tech-tonio-ai
    Date Created    : 2026-11-05
    Last Modified   : 2026-11-05
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000391
    Documentation   : https://stigaview.com/products/win11/v1r5/WN11-CC-000391/

.TESTED ON
    Date(s) Tested  : 2026-11-05
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

#-- code --
# Configure: Disable Internet Explorer 11 as a standalone browser
# Policy State: Enabled
# Option: Never

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"

# Create registry path if it does not exist
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force
}

# Set policy value
New-ItemProperty -Path $RegPath `
    -Name "NotifyDisableIEOptions" `
    -Value 0 `
    -PropertyType DWord `
    -Force

# Refresh Group Policy
gpupdate /force
