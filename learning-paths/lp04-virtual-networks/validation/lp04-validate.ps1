param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName = "rg-az104-network-dev-eastus2-01",

  [Parameter(Mandatory=$true)]
  [string]$VnetName,

  [Parameter(Mandatory=$true)]
  [string]$RouteTableName,

  [Parameter(Mandatory=$true)]
  [string]$LoadBalancerName,

  [Parameter(Mandatory=$true)]
  [string]$NsgName
)

$ErrorActionPreference="Stop"
function Run($path,$args){
  Write-Host "Running: $path"
  & pwsh -File $path @args
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Run "learning-paths/lp04-virtual-networks/modules/m01-vnet-foundations/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; VnetName=$VnetName
}

Run "learning-paths/lp04-virtual-networks/modules/m02-connectivity-and-routing/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; RouteTableName=$RouteTableName
}

Run "learning-paths/lp04-virtual-networks/modules/m03-load-balancing-and-name-resolution/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; LoadBalancerName=$LoadBalancerName
}

Run "learning-paths/lp04-virtual-networks/modules/m04-network-security-and-troubleshooting/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; NsgName=$NsgName
}

Write-Host "PASS: LP04 validation complete."
exit 0
