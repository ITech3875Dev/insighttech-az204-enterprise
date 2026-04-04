<#
.SYNOPSIS
    Enhanced Module Validation Script (v2)
    With --debug mode for troubleshooting and automated hints

.DESCRIPTION
    Validates module lab completion.
    Returns exit code 0 for PASS, 1 for FAIL.
    Does NOT require secrets.
    Supports --debug mode for detailed error diagnosis.

.PARAMETER SubscriptionId
    Azure subscription ID to validate against

.PARAMETER Debug
    Switch to enable debug output with hints and remediation steps

.EXAMPLE
    .\validate.ps1 -SubscriptionId "12345678-1234-1234-1234-123456789012"
    .\validate.ps1 -SubscriptionId "12345678-1234-1234-1234-123456789012" -Debug

.NOTES
    Author: InSight Technologies Training
    Version: 2.0 (Enhanced with debug mode)
#>

param(
    [Parameter(Mandatory=$true, HelpMessage="Azure subscription ID (format: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)")]
    [ValidatePattern('^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')]
    [string]$SubscriptionId,

    [switch]$Debug = $false
)

# Configuration
$ErrorActionPreference = "Stop"
$ChecksPassed = 0
$ChecksFailed = 0
$ChecksSkipped = 0
$TotalChecks = 0

# =========================================================================
# Helper Functions
# =========================================================================

function Pass($msg) {
    Write-Host "✅ PASS: $msg" -ForegroundColor Green
    $script:ChecksPassed++
    $script:TotalChecks++
}

function Fail($msg, $hint = "") {
    Write-Host "❌ FAIL: $msg" -ForegroundColor Red
    if ($Debug -and $hint) {
        Write-Host "   💡 HINT: $hint" -ForegroundColor Yellow
    }
    $script:ChecksFailed++
    $script:TotalChecks++
}

function Skip($msg, $reason = "") {
    Write-Host "⏭️  SKIP: $msg" -ForegroundColor Yellow
    if ($Debug -and $reason) {
        Write-Host "   Reason: $reason" -ForegroundColor DarkYellow
    }
    $script:ChecksSkipped++
}

function Debug($msg) {
    if ($Debug) {
        Write-Host "🔍 DEBUG: $msg" -ForegroundColor Cyan
    }
}

function Section($title) {
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
    Write-Host "$title" -ForegroundColor Cyan
    Write-Host "═══════════════════════════════════════════" -ForegroundColor Cyan
}

# =========================================================================
# Pre-Validation: Environment Check
# =========================================================================

Section "PRE-VALIDATION: Environment Setup"

# Check 1: PowerShell version
if ($PSVersionTable.PSVersion.Major -ge 5) {
    Pass "PowerShell version: $($PSVersionTable.PSVersion)"
}
else {
    Fail "PowerShell version too old" "Update to PowerShell 5.0 or later (or PowerShell Core 7+)"
    exit 1
}

# Check 2: Az module installed
try {
    $azModule = Get-Module Az.Accounts -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1
    if ($azModule) {
        Pass "Azure Az module installed: $($azModule.Version)"
        Debug "Az module location: $($azModule.Path)"
    }
    else {
        Fail "Azure Az module not found" `
             "Install: Install-Module -Name Az -Repository PSGallery -Force -AllowClobber"
        exit 1
    }
}
catch {
    Fail "Error checking Az module: $_" "Reinstall Az module: Remove-Module Az; Install-Module Az"
    exit 1
}

# Check 3: Az CLI available (optional but helpful)
if (Get-Command az -ErrorAction SilentlyContinue) {
    $azCliVersion = az version --output json | ConvertFrom-Json
    Pass "Azure CLI installed: $($azCliVersion.'azure-cli')"
}
else {
    Skip "Azure CLI not found" "Optional: Install from https://learn.microsoft.com/cli/azure/install-azure-cli"
}

# =========================================================================
# Authentication & Subscription Check
# =========================================================================

Section "AUTHENTICATION & SUBSCRIPTION"

# Check 4: User is authenticated (or can authenticate)
try {
    $context = Get-AzContext
    if ($context) {
        Pass "Authenticated as: $($context.Account.Id)"
        Debug "Current subscription: $($context.Subscription.Name) ($($context.Subscription.Id))"
    }
    else {
        Fail "Not authenticated to Azure" `
             "Authenticate: Connect-AzAccount -Subscription $SubscriptionId"
        exit 1
    }
}
catch {
    Fail "Could not get Azure context: $_" "Run: Connect-AzAccount"
    exit 1
}

# Check 5: Target subscription accessible
try {
    $subscription = Get-AzSubscription -SubscriptionId $SubscriptionId -ErrorAction Stop
    Pass "Subscription found: $($subscription.Name)"
    Debug "Subscription state: $($subscription.State)"

    Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null
}
catch {
    if ($_ -match "not found") {
        Fail "Subscription not found" `
             "Verify subscription ID: $SubscriptionId. List subscriptions: Get-AzSubscription"
    }
    elseif ($_ -match "permission") {
        Fail "Access denied to subscription" `
             "Verify you have access. Ask your admin or check tenant permissions."
    }
    else {
        Fail "Cannot access subscription: $_" "Check: Get-AzSubscription -SubscriptionId $SubscriptionId"
    }
    exit 1
}

# =========================================================================
# MODULE-SPECIFIC VALIDATION AREA
# =========================================================================
# TODO: Add lab-specific checks below
# Example checks for M01 (Users, Groups, RBAC):

Section "MODULE VALIDATION: [INSERT MODULE NAME]"

<#
Example validation checks (uncomment and customize for your module):

# Check: Role assignment exists
try {
    $roleAssignment = Get-AzRoleAssignment `
        -Scope "/subscriptions/$SubscriptionId" `
        -RoleDefinitionName "Reader" `
        -ErrorAction Stop

    if ($roleAssignment) {
        Pass "Reader role assignment found"
        Debug "Principal: $($roleAssignment.DisplayName), Scope: $($roleAssignment.Scope)"
    }
    else {
        Fail "Reader role assignment not found" `
             "Assign: New-AzRoleAssignment -Scope `/subscriptions/$SubscriptionId` -RoleDefinitionName 'Reader' -ObjectId [GROUP_ID]"
    }
}
catch {
    Fail "Error checking role assignment: $_"
}

# Check: Resource group has required tags
try {
    $rg = Get-AzResourceGroup -Name "rg-your-workload-*" -ErrorAction Stop
    if ($rg) {
        Pass "Resource group found: $($rg.ResourceGroupName)"

        $requiredTags = @('Owner', 'CostCenter', 'Environment', 'Workload')
        $missingTags = @()

        foreach ($tag in $requiredTags) {
            if (-not $rg.Tags[$tag]) {
                $missingTags += $tag
            }
        }

        if ($missingTags.Count -eq 0) {
            Pass "All required tags present: $($requiredTags -join ', ')"
        }
        else {
            Fail "Missing tags: $($missingTags -join ', ')" `
                 "Add tags: Update-AzTag -ResourceId $($rg.ResourceId) -Tag @{Owner='yourname'; CostCenter='123'; ...}"
        }
    }
    else {
        Fail "Resource group not found" `
             "Create: New-AzResourceGroup -Name 'rg-yourworkload-dev-eastus2-01' -Location 'East US 2'"
    }
}
catch {
    Fail "Error checking resource group: $_"
}
#>

# Placeholder if no checks added yet
Write-Host "ℹ️  INFO: Add module-specific validation checks in the MODULE-SPECIFIC VALIDATION AREA" -ForegroundColor Blue
Skip "Module validation (template awaiting lab-specific checks)"

# =========================================================================
# FINAL SUMMARY
# =========================================================================

Section "VALIDATION SUMMARY"

Write-Host ""
Write-Host "Results:" -ForegroundColor Cyan
Write-Host "  ✅ Passed:  $ChecksPassed" -ForegroundColor Green
Write-Host "  ❌ Failed:  $ChecksFailed" -ForegroundColor Red
Write-Host "  ⏭️  Skipped: $ChecksSkipped" -ForegroundColor Yellow
Write-Host "  Total:  $TotalChecks" -ForegroundColor Cyan

Write-Host ""

if ($ChecksFailed -eq 0) {
    Write-Host "✅ VALIDATION PASSED" -ForegroundColor Green -BackgroundColor Black
    Write-Host "All critical checks passed. Lab is complete!" -ForegroundColor Green
    Write-Host ""
    exit 0
}
else {
    Write-Host "❌ VALIDATION FAILED" -ForegroundColor Red -BackgroundColor Black
    Write-Host "Fix the failures above and rerun validation." -ForegroundColor Red
    if ($Debug) {
        Write-Host "💡 Run with --Debug flag again to see hints for each failure." -ForegroundColor Yellow
    }
    else {
        Write-Host "💡 Add -Debug flag for troubleshooting hints: .\validate.ps1 -SubscriptionId $SubscriptionId -Debug" -ForegroundColor Yellow
    }
    Write-Host ""
    exit 1
}
