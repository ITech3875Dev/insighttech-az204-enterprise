param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$GroupObjectId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName = "rg-az104-idgov-dev-eastus2-01",

  [Parameter(Mandatory=$true)]
  [string]$WorkloadsManagementGroupName = "mg-az104-workloads",

  [Parameter(Mandatory=$true)]
  [string]$BudgetName = "az104-lab-budget"
)

$ErrorActionPreference="Stop"
function Run($path,$args){
  Write-Host "Running: $path"
  & pwsh -File $path @args
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Run "learning-paths/lp01-identity-governance/modules/m01-users-groups-rbac/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; GroupObjectId=$GroupObjectId
}

Run "learning-paths/lp01-identity-governance/modules/m02-management-groups-subs/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; WorkloadsManagementGroupName=$WorkloadsManagementGroupName; GroupObjectId=$GroupObjectId
}

Run "learning-paths/lp01-identity-governance/modules/m03-policy-locks-tags/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName
}

Run "learning-paths/lp01-identity-governance/modules/m04-cost-advisor-governance/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; BudgetName=$BudgetName
}

Write-Host "PASS: LP01 validation complete."
exit 0
