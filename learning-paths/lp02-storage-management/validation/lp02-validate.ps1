param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$StorageOperatorsGroupObjectId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName = "rg-az104-storage-dev-eastus2-01",

  [Parameter(Mandatory=$true)]
  [string]$StorageAccountName,
)

$ErrorActionPreference="Stop"
function Run($path,$args){
  Write-Host "Running: $path"
  & pwsh -File $path @args
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Run "learning-paths/lp02-storage-management/modules/m01-storage-accounts/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; GroupObjectId=$StorageOperatorsGroupObjectId
}

Run "learning-paths/lp02-storage-management/modules/m02-blob-services-data-protection/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; StorageAccountName=$StorageAccountName
}

Run "learning-paths/lp02-storage-management/modules/m03-files-sync-data-movement/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; StorageAccountName=$StorageAccountName
}

Run "learning-paths/lp02-storage-management/modules/m04-storage-security-governance/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; StorageAccountName=$StorageAccountName
}

Write-Host "PASS: LP02 validation complete."
exit 0
