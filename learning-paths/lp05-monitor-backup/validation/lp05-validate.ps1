param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName = "rg-az104-monitor-dev-eastus2-01",

  [Parameter(Mandatory=$true)]
  [string]$LogAnalyticsWorkspaceName,

  [Parameter(Mandatory=$true)]
  [string]$ActionGroupName,

  [Parameter(Mandatory=$true)]
  [string]$RecoveryVaultName,

  [Parameter(Mandatory=$true)]
  [string]$AlertRuleName
)

$ErrorActionPreference="Stop"
function Run($path,$args){
  Write-Host "Running: $path"
  & pwsh -File $path @args
  if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Run "learning-paths/lp05-monitor-backup/modules/m01-monitor-foundations/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; LogAnalyticsWorkspaceName=$LogAnalyticsWorkspaceName
}

Run "learning-paths/lp05-monitor-backup/modules/m02-alerting-and-log-analytics/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; ActionGroupName=$ActionGroupName
}

Run "learning-paths/lp05-monitor-backup/modules/m03-backup-and-recovery-services/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; RecoveryVaultName=$RecoveryVaultName
}

Run "learning-paths/lp05-monitor-backup/modules/m04-monitoring-governance-and-remediation/validation/validate.ps1" @{
  SubscriptionId=$SubscriptionId; ResourceGroupName=$ResourceGroupName; AlertRuleName=$AlertRuleName
}

Write-Host "PASS: LP05 validation complete."
exit 0
