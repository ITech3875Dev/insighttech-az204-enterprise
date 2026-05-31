param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$LogAnalyticsWorkspaceName
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $law = Get-AzOperationalInsightsWorkspace -ResourceGroupName $ResourceGroupName -Name $LogAnalyticsWorkspaceName -ErrorAction Stop
  Pass "Log Analytics workspace exists: $LogAnalyticsWorkspaceName"

  if (-not $law.RetentionInDays -or $law.RetentionInDays -lt 30) { Fail "Workspace retention is less than 30 days" }
  Pass "Workspace retention is configured: $($law.RetentionInDays) days"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
