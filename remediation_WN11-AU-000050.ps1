<#
.SYNOPSIS
    This PowerShell script configures the system to audit Detailed Tracking - Process Creation successes.
.NOTES
    Author          : Symone-Marie Priester
    LinkedIn        : linkedin.com/in/symone-mariepriester
    GitHub          : github.com/Symone-Marie
    Date Created    : 2025-02-08
    Last Modified   : 2025-02-08
    Version         : Microsoft Windows [Version 10.0.26200.7623]
    CVEs            : N/A
    Vuln-ID         : V-253411
    STIG-ID         : WN11-AU-000050
.TESTED ON
    Date(s) Tested  : 2025-02-08
    Tested By       : Symone-Marie Priester
    Systems Tested  : Windows 11 Pro
    PowerShell Ver. : 5.1
    Manual Test     : Yes, remediated via Local Group Policy Editor (gpedit.msc) with screenshot documentation
.USAGE
    Enables auditing for Process Creation success events to track when processes are created on the system.
    Example syntax:
    PS C:\> .\remediation_WN11-AU-000050.ps1 
#>

# Configure audit policy for Process Creation
Write-Host "Configuring audit policy for Detailed Tracking - Process Creation..."

# Use auditpol to set the Process Creation audit policy to Success
auditpol /set /subcategory:"Process Creation" /success:enable

# Verify the configuration
Write-Host "`nVerifying configuration..."
$auditStatus = auditpol /get /subcategory:"Process Creation"

if ($auditStatus -match "Success") {
    Write-Host "SUCCESS: WN11-AU-000050 remediated - Process Creation auditing is now enabled for Success events" -ForegroundColor Green
    Write-Host "`nCurrent audit policy status:"
    auditpol /get /category:"Detailed Tracking"
} else {
    Write-Host "ERROR: Failed to enable Process Creation auditing" -ForegroundColor Red
}
