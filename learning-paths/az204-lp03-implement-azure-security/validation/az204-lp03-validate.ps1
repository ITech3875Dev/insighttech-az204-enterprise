#Requires -Version 7.0
<#
.SYNOPSIS
    LP03 validation script — Implement Azure Security.
.DESCRIPTION
    Verifies Azure resources and security configuration for the AZ-204 LP03 lab environment.
    Checks: subscription context, resource group, Key Vault (RBAC + soft-delete + purge-protection),
    target secret existence, and App Configuration store.
.PARAMETER SubscriptionId
    Azure subscription ID (mandatory).
.PARAMETER ResourceGroupName
    Resource group containing LP03 resources. Default: rg-az204-lp03
.PARAMETER KeyVaultName
    Name of the Key Vault to validate.
.PARAMETER SecretName
    Name of the secret that must exist in the vault. Default: db-connection-string
.PARAMETER AppConfigName
    Name of the App Configuration store to validate.
.EXAMPLE
    .\az204-lp03-validate.ps1 -SubscriptionId "00000000-0000-0000-0000-000000000000" `
        -KeyVaultName "kv-az204-lp03" -AppConfigName "appconfig-az204-lp03"
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [string]$ResourceGroupName = "rg-az204-lp03",

    [Parameter(Mandatory = $true)]
    [string]$KeyVaultName,

    [string]$SecretName = "db-connection-string",

    [Parameter(Mandatory = $true)]
    [string]$AppConfigName
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$script:passes = [System.Collections.Generic.List[string]]::new()
$script:errors = [System.Collections.Generic.List[string]]::new()

function Add-Pass([string]$msg) {
    $script:passes.Add($msg)
    Write-Host "[PASS] $msg" -ForegroundColor Green
}

function Add-Error([string]$msg) {
    $script:errors.Add($msg)
    Write-Host "[FAIL] $msg" -ForegroundColor Red
}

function Assert-Command([string]$tool) {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
        Add-Error "Required tool '$tool' not found in PATH."
        Write-Host "`n[RESULT] FAIL — prerequisite check failed." -ForegroundColor Red
        exit 1
    }
}

# ── Prerequisites ────────────────────────────────────────────────────────────

Assert-Command "az"

if ([string]::IsNullOrWhiteSpace($SubscriptionId)) { Add-Error "SubscriptionId is required." }
if ([string]::IsNullOrWhiteSpace($KeyVaultName)) { Add-Error "KeyVaultName is required." }
if ([string]::IsNullOrWhiteSpace($AppConfigName)) { Add-Error "AppConfigName is required." }

if ($script:errors.Count -gt 0) {
    Write-Host "`n[RESULT] FAIL — parameter validation failed." -ForegroundColor Red
    exit 1
}

# ── Subscription Context ─────────────────────────────────────────────────────

Write-Host "`n--- Subscription Context ---"
try {
    az account set --subscription $SubscriptionId 2>&1 | Out-Null
    $acctName = (az account show --query name -o tsv 2>&1).Trim()
    Add-Pass "Subscription set: $acctName ($SubscriptionId)"
}
catch {
    Add-Error "Failed to set subscription '$SubscriptionId'. Verify the ID and that you are logged in."
}

# ── Resource Group ───────────────────────────────────────────────────────────

Write-Host "`n--- Resource Group ---"
try {
    az group show --name $ResourceGroupName --query name -o tsv 2>&1 | Out-Null
    Add-Pass "Resource group '$ResourceGroupName' exists."
}
catch {
    Add-Error "Resource group '$ResourceGroupName' not found."
}

# ── Key Vault ────────────────────────────────────────────────────────────────

Write-Host "`n--- Key Vault ---"
try {
    $vault = az keyvault show --name $KeyVaultName --resource-group $ResourceGroupName -o json 2>&1 | ConvertFrom-Json
    Add-Pass "Key Vault '$KeyVaultName' exists."

    $rbacEnabled = $vault.properties.enableRbacAuthorization
    if ($rbacEnabled -eq $true) {
        Add-Pass "Key Vault uses RBAC authorization (enableRbacAuthorization = true)."
    }
    else {
        Add-Error "Key Vault is not using RBAC authorization. Set --enable-rbac-authorization true."
    }

    $softDelete = $vault.properties.enableSoftDelete
    if ($softDelete -eq $true) {
        Add-Pass "Key Vault soft-delete is enabled."
    }
    else {
        Add-Error "Key Vault soft-delete is not enabled."
    }

    $purgeProtect = $vault.properties.enablePurgeProtection
    if ($purgeProtect -eq $true) {
        Add-Pass "Key Vault purge protection is enabled."
    }
    else {
        Add-Error "Key Vault purge protection is not enabled. Run: az keyvault update --name $KeyVaultName --enable-purge-protection true"
    }
}
catch {
    Add-Error "Key Vault '$KeyVaultName' not found or inaccessible."
}

# ── Secret Existence ─────────────────────────────────────────────────────────

Write-Host "`n--- Secret ---"
try {
    $secretResult = az keyvault secret show `
        --vault-name $KeyVaultName `
        --name $SecretName `
        --query "name" -o tsv 2>&1

    if ($secretResult -match $SecretName) {
        Add-Pass "Secret '$SecretName' exists in vault '$KeyVaultName'."
    }
    else {
        Add-Error "Secret '$SecretName' not found in vault '$KeyVaultName'."
    }
}
catch {
    Add-Error "Could not retrieve secret '$SecretName'. Check RBAC permissions."
}

# ── App Configuration ────────────────────────────────────────────────────────

Write-Host "`n--- App Configuration ---"
try {
    $appConfig = az appconfig show --name $AppConfigName --resource-group $ResourceGroupName -o json 2>&1 | ConvertFrom-Json
    Add-Pass "App Configuration store '$AppConfigName' exists."

    $sku = $appConfig.sku.name
    Add-Pass "App Configuration SKU: $sku."
}
catch {
    Add-Error "App Configuration store '$AppConfigName' not found in resource group '$ResourceGroupName'."
}

# ── App Configuration Key Vault Reference ────────────────────────────────────

Write-Host "`n--- App Configuration Key Vault Reference ---"
try {
    $kvRefKey = "ConnectionStrings:Database"
    $kvRef = az appconfig kv show `
        --name $AppConfigName `
        --key $kvRefKey `
        -o json 2>&1 | ConvertFrom-Json

    if ($kvRef.contentType -like "*keyvaultref*") {
        Add-Pass "App Configuration key '$kvRefKey' is a Key Vault reference."
    }
    else {
        Add-Error "App Configuration key '$kvRefKey' does not appear to be a Key Vault reference (contentType: $($kvRef.contentType))."
    }
}
catch {
    Add-Error "App Configuration key 'ConnectionStrings:Database' not found. Ensure you created the Key Vault reference."
}

# ── Summary ───────────────────────────────────────────────────────────────────

Write-Host "`n═══════════════════════════════════════════════"
Write-Host "  LP03 Validation Summary"
Write-Host "═══════════════════════════════════════════════"
Write-Host "  Passed : $($script:passes.Count)"
Write-Host "  Failed : $($script:errors.Count)"
Write-Host "═══════════════════════════════════════════════"

if ($script:errors.Count -eq 0) {
    Write-Host "`n[RESULT] PASS — All LP03 checks passed." -ForegroundColor Green
    exit 0
}
else {
    Write-Host "`n[RESULT] FAIL — $($script:errors.Count) check(s) failed. Review output above." -ForegroundColor Red
    exit 1
}
