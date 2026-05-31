param(
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [string]$ResourceGroupName,
    [string]$StorageAccountName,
    [string]$BlobContainerName,
    [string]$CosmosAccountName,
    [string]$CosmosDatabaseName,
    [string]$CosmosContainerName
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

if (-not $StorageAccountName) {
    Add-Error "StorageAccountName is required."
}

if (-not $BlobContainerName) {
    Add-Error "BlobContainerName is required."
}

if (-not $CosmosAccountName) {
    Add-Error "CosmosAccountName is required."
}

if (-not $CosmosDatabaseName) {
    Add-Error "CosmosDatabaseName is required."
}

if (-not $CosmosContainerName) {
    Add-Error "CosmosContainerName is required."
}

Assert-Command -CommandName "az"

if ($errors.Count -gt 0) {
    exit 1
}

Write-Host "[INFO] AZ-204 LP02 validation started." -ForegroundColor Cyan
Write-Host "[INFO] Subscription: $SubscriptionId"
Write-Host "[INFO] Resource Group: $ResourceGroupName"
Write-Host "[INFO] Storage Account: $StorageAccountName"
Write-Host "[INFO] Blob Container: $BlobContainerName"
Write-Host "[INFO] Cosmos DB Account: $CosmosAccountName"
Write-Host "[INFO] Cosmos Database: $CosmosDatabaseName"
Write-Host "[INFO] Cosmos Container: $CosmosContainerName"

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
    $storage = az storage account show --resource-group $ResourceGroupName --name $StorageAccountName -o json | ConvertFrom-Json
    Add-Pass "Storage account exists: $StorageAccountName"

    if ($storage.allowBlobPublicAccess -eq $false) {
        Add-Pass "Storage account blocks public blob access"
    }
    else {
        Add-Error "Storage account allows public blob access"
    }

    if ($storage.minimumTlsVersion -eq "TLS1_2") {
        Add-Pass "Storage account minimum TLS is TLS1_2"
    }
    else {
        Add-Error "Storage account minimum TLS is '$($storage.minimumTlsVersion)', expected TLS1_2"
    }
}
catch {
    Add-Error "Unable to validate storage account '$StorageAccountName'. $($_.Exception.Message)"
}

try {
    $accountKey = az storage account keys list --resource-group $ResourceGroupName --account-name $StorageAccountName --query "[0].value" -o tsv
    $container = az storage container show --name $BlobContainerName --account-name $StorageAccountName --account-key $accountKey -o json | ConvertFrom-Json
    if ($container.name -eq $BlobContainerName) {
        Add-Pass "Blob container exists: $BlobContainerName"
    }
}
catch {
    Add-Error "Unable to validate blob container '$BlobContainerName'. $($_.Exception.Message)"
}

try {
    $cosmos = az cosmosdb show --resource-group $ResourceGroupName --name $CosmosAccountName -o json | ConvertFrom-Json
    Add-Pass "Cosmos DB account exists: $CosmosAccountName"

    if ($cosmos.consistencyPolicy.defaultConsistencyLevel -eq "Session") {
        Add-Pass "Cosmos DB default consistency is Session"
    }
    else {
        Add-Error "Cosmos DB consistency level is '$($cosmos.consistencyPolicy.defaultConsistencyLevel)', expected Session"
    }
}
catch {
    Add-Error "Unable to validate Cosmos DB account '$CosmosAccountName'. $($_.Exception.Message)"
}

try {
    $database = az cosmosdb sql database show --account-name $CosmosAccountName --resource-group $ResourceGroupName --name $CosmosDatabaseName -o json | ConvertFrom-Json
    if ($database.name -eq $CosmosDatabaseName) {
        Add-Pass "Cosmos DB database exists: $CosmosDatabaseName"
    }
}
catch {
    Add-Error "Unable to validate Cosmos DB database '$CosmosDatabaseName'. $($_.Exception.Message)"
}

try {
    $cosmosContainer = az cosmosdb sql container show --account-name $CosmosAccountName --resource-group $ResourceGroupName --database-name $CosmosDatabaseName --name $CosmosContainerName -o json | ConvertFrom-Json
    if ($cosmosContainer.name -eq $CosmosContainerName) {
        Add-Pass "Cosmos DB container exists: $CosmosContainerName"
    }

    if ($cosmosContainer.resource.partitionKey.paths[0] -eq "/customerId") {
        Add-Pass "Cosmos DB partition key path matches expected '/customerId'"
    }
    else {
        Add-Error "Cosmos DB partition key path is '$($cosmosContainer.resource.partitionKey.paths[0])', expected '/customerId'"
    }
}
catch {
    Add-Error "Unable to validate Cosmos DB container '$CosmosContainerName'. $($_.Exception.Message)"
}

Write-Host "[INFO] Validation summary: $($passes.Count) passed, $($errors.Count) failed." -ForegroundColor Cyan

if ($errors.Count -gt 0) {
    Write-Host "[RESULT] FAIL" -ForegroundColor Red
    exit 1
}

Write-Host "[RESULT] PASS" -ForegroundColor Green
exit 0
