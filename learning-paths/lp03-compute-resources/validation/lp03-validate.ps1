param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName = "rg-az104-compute-dev-eastus2-01",

  [Parameter(Mandatory=$true)]
  [string]$VmName,

  [Parameter(Mandatory=$true)]
  [string]$VmssName,

  [Parameter(Mandatory=$true)]
  [string]$AppServicePlanName,

  [Parameter(Mandatory=$true)]
  [string]$WebAppName
)

$ErrorActionPreference="Stop"
function Run($path,$args){
  Write-Host "Running: $path"
  & pwsh -File $path @args
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Run "learning-paths/lp03-compute-resources/modules/m01-vm-foundations/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; VmName=$VmName
}

Run "learning-paths/lp03-compute-resources/modules/m02-vm-scale-and-availability/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; VmssName=$VmssName
}

Run "learning-paths/lp03-compute-resources/modules/m03-app-service-and-container-services/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; AppServicePlanName=$AppServicePlanName; WebAppName=$WebAppName
}

Run "learning-paths/lp03-compute-resources/modules/m04-compute-security-and-operations/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; VmName=$VmName
}

Write-Host "PASS: LP03 validation complete."
exit 0
