param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$BudgetName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  # Budget validation using Azure CLI (most consistent across environments)
  $budget = az consumption budget show --budget-name $BudgetName -o json 2>$null
  if (-not $budget) { Fail "Budget not found via CLI: $BudgetName (create via Portal if needed, then re-run)" }
  Pass "Budget exists: $BudgetName"

  # Advisor query should run even if empty
  try {
    $recs = Get-AzAdvisorRecommendation -ErrorAction Stop
    Pass "Advisor query executed (recommendations may be empty)"
  } catch {
    Fail "Advisor cmdlet failed. Ensure Az.Advisor module is available."
  }

  exit 0
}catch{
  Fail $_.Exception.Message
}
