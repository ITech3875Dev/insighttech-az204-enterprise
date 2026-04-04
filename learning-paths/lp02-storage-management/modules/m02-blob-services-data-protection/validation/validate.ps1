param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$StorageAccountName
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $sa = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -ErrorAction Stop
  Pass "Storage account exists: $StorageAccountName"

  $ctx = $sa.Context
  $requiredContainers = @("raw", "curated", "archive")
  foreach ($containerName in $requiredContainers) {
    $container = Get-AzStorageContainer -Context $ctx -Name $containerName -ErrorAction SilentlyContinue
    if (-not $container) { Fail "Container '$containerName' not found" }
    Pass "Container exists: $containerName"
  }

  $blobProps = az storage account blob-service-properties show --account-name $StorageAccountName --resource-group $ResourceGroupName --only-show-errors | ConvertFrom-Json
  if (-not $blobProps.isVersioningEnabled) { Fail "Blob versioning is not enabled" }
  if (-not $blobProps.deleteRetentionPolicy.enabled) { Fail "Blob soft delete is not enabled" }
  if ($blobProps.deleteRetentionPolicy.days -lt 7) { Fail "Blob delete retention is less than 7 days" }
  Pass "Blob data protection settings are configured"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
