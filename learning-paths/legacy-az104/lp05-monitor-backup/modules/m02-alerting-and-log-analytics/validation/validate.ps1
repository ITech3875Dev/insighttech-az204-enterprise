param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$ActionGroupName
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $ag = Get-AzActionGroup -ResourceGroupName $ResourceGroupName -Name $ActionGroupName -ErrorAction Stop
  Pass "Action group exists: $ActionGroupName"

  $rules = Get-AzMetricAlertRuleV2 -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
  if (-not $rules -or $rules.Count -lt 1) { Fail "No metric alert rules found in resource group" }
  Pass "Metric alert rule found"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
