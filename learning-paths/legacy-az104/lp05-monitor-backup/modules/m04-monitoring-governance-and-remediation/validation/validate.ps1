param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$AlertRuleName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $rule = Get-AzMetricAlertRuleV2 -ResourceGroupName $ResourceGroupName -Name $AlertRuleName -ErrorAction Stop
  Pass "Alert rule exists: $AlertRuleName"

  if (-not $rule.Enabled) { Fail "Alert rule is disabled" }
  Pass "Alert rule is enabled"

  if (-not $rule.Severity -and $rule.Severity -ne 0) { Fail "Alert rule severity is not configured" }
  Pass "Alert rule severity configured: $($rule.Severity)"

  exit 0
}catch{
  Fail $_.Exception.Message
}
