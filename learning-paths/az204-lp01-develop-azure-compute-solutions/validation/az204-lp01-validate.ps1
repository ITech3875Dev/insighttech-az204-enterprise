param(
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [string]$ResourceGroupName,
    [string]$FunctionAppName,
    [string]$WebAppName,
    [string]$AppServicePlanName,
    [string]$StagingSlotName = "staging",
    [string]$ExpectedFunctionRuntimePattern = "PowerShell\\|7\\.4",
    [string]$ExpectedWebRuntimePattern = "PYTHON\\|3\\.11|DOCKER\\|"
)

$errors = @()
$passes = @()

function Add-Pass {
    param([string]$Message)
    $passes += $Message
    Write-Host "[PASS] $Message" -ForegroundColor Green
}

function Add-Error {
    param([string]$Message)
    $script:errors += $Message
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Assert-Command {
    param([string]$CommandName)
    if (-not (Get-Command $CommandName -ErrorAction SilentlyContinue)) {
        Add-Error "Required command not found: $CommandName"
    }
}

if (-not $ResourceGroupName) {
    Add-Error "ResourceGroupName is required."
}

if (-not $FunctionAppName) {
    Add-Error "FunctionAppName is required."
}

if (-not $WebAppName) {
    Add-Error "WebAppName is required."
}

if (-not $AppServicePlanName) {
    Add-Error "AppServicePlanName is required."
}

Assert-Command -CommandName "az"

if ($errors.Count -gt 0) {
    exit 1
}

Write-Host "[INFO] AZ-204 LP01 validation started." -ForegroundColor Cyan
Write-Host "[INFO] Subscription: $SubscriptionId"
Write-Host "[INFO] Resource Group: $ResourceGroupName"
Write-Host "[INFO] Function App: $FunctionAppName"
Write-Host "[INFO] Web App: $WebAppName"
Write-Host "[INFO] App Service Plan: $AppServicePlanName"

try {
    az account set --subscription $SubscriptionId | Out-Null
    $account = az account show -o json | ConvertFrom-Json
    Add-Pass "Subscription context set to $($account.id)"
}
catch {
    Add-Error "Unable to set or read Azure subscription context. $($_.Exception.Message)"
}

try {
    $rg = az group show --name $ResourceGroupName -o json | ConvertFrom-Json
    if ($rg.name -eq $ResourceGroupName) {
        Add-Pass "Resource group exists: $ResourceGroupName"
    }
}
catch {
    Add-Error "Resource group not found: $ResourceGroupName"
}

try {
    $func = az functionapp show --resource-group $ResourceGroupName --name $FunctionAppName -o json | ConvertFrom-Json
    Add-Pass "Function App exists: $FunctionAppName"

    if ($func.state -eq "Running") {
        Add-Pass "Function App is running"
    }
    else {
        Add-Error "Function App state is $($func.state), expected Running"
    }

}
catch {
    Add-Error "Unable to validate Function App '$FunctionAppName'. $($_.Exception.Message)"
}

try {
    $funcConfig = az functionapp config show --resource-group $ResourceGroupName --name $FunctionAppName -o json | ConvertFrom-Json
    if ($funcConfig.linuxFxVersion -match $ExpectedFunctionRuntimePattern) {
        Add-Pass "Function runtime matches expected pattern: $ExpectedFunctionRuntimePattern"
    }
    else {
        Add-Error "Function linuxFxVersion '$($funcConfig.linuxFxVersion)' does not match '$ExpectedFunctionRuntimePattern'"
    }
}
catch {
    Add-Error "Unable to validate Function App runtime configuration. $($_.Exception.Message)"
}

try {
    $funcIdentity = az functionapp identity show --resource-group $ResourceGroupName --name $FunctionAppName -o json | ConvertFrom-Json
    if ($funcIdentity.principalId) {
        Add-Pass "Function App managed identity is enabled"
    }
    else {
        Add-Error "Function App managed identity is not enabled"
    }
}
catch {
    Add-Error "Unable to read Function App identity. $($_.Exception.Message)"
}

try {
    $app = az webapp show --resource-group $ResourceGroupName --name $WebAppName -o json | ConvertFrom-Json
    Add-Pass "Web App exists: $WebAppName"

    if ($app.state -eq "Running") {
        Add-Pass "Web App is running"
    }
    else {
        Add-Error "Web App state is $($app.state), expected Running"
    }
}
catch {
    Add-Error "Unable to validate Web App '$WebAppName'. $($_.Exception.Message)"
}

try {
    $plan = az appservice plan show --resource-group $ResourceGroupName --name $AppServicePlanName -o json | ConvertFrom-Json
    Add-Pass "App Service plan exists: $AppServicePlanName"

    if ($plan.sku.tier -in @("Basic", "Standard", "PremiumV2", "PremiumV3", "PremiumV4")) {
        Add-Pass "App Service plan tier is acceptable: $($plan.sku.tier)"
    }
    else {
        Add-Error "App Service plan tier '$($plan.sku.tier)' is below expected production baseline"
    }
}
catch {
    Add-Error "Unable to validate App Service plan '$AppServicePlanName'. $($_.Exception.Message)"
}

try {
    $slots = az webapp deployment slot list --resource-group $ResourceGroupName --name $WebAppName -o json | ConvertFrom-Json
    if ($slots.name -contains $StagingSlotName) {
        Add-Pass "Deployment slot exists: $StagingSlotName"
    }
    else {
        Add-Error "Deployment slot '$StagingSlotName' not found"
    }
}
catch {
    Add-Error "Unable to list deployment slots. $($_.Exception.Message)"
}

try {
    $webConfig = az webapp config show --resource-group $ResourceGroupName --name $WebAppName -o json | ConvertFrom-Json
    if ($webConfig.linuxFxVersion -match $ExpectedWebRuntimePattern) {
        Add-Pass "Web App runtime matches expected pattern: $ExpectedWebRuntimePattern"
    }
    else {
        Add-Error "Web App linuxFxVersion '$($webConfig.linuxFxVersion)' does not match '$ExpectedWebRuntimePattern'"
    }
}
catch {
    Add-Error "Unable to validate web app runtime configuration. $($_.Exception.Message)"
}

Write-Host "[INFO] Validation summary: $($passes.Count) passed, $($errors.Count) failed." -ForegroundColor Cyan

if ($errors.Count -gt 0) {
    Write-Host "[RESULT] FAIL" -ForegroundColor Red
    exit 1
}

Write-Host "[RESULT] PASS" -ForegroundColor Green
exit 0
