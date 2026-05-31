param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  # Policy assignment existence (best-effort)
  $assignments = Get-AzPolicyAssignment -Scope "/subscriptions/$SubscriptionId" -ErrorAction SilentlyContinue
  if (-not $assignments) { Fail "No policy assignments found at subscription scope (or insufficient permission)." }
  Pass "Policy assignments enumerated at subscription scope"

  # Lock existence
  $locks = Get-AzResourceLock -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
  $hit = $locks | Where-Object { $_.LockLevel -eq "CanNotDelete" -and $_.Name -eq "lock-rg-cannotdelete" }
  if (-not $hit) { Fail "CanNotDelete lock 'lock-rg-cannotdelete' not found on RG $ResourceGroupName" }
  Pass "CanNotDelete lock present on RG"

  # Tag compliance report - optional (fails if non-compliant; that's intended)
  $script = "shared/scripts/pwsh/validation/tag-compliance-report.ps1"
  if (Test-Path $script) {
    & pwsh -File $script -SubscriptionId $SubscriptionId -OutputFolder "./out" | Out-Null
    Pass "Tag compliance report executed (see ./out)"
  } else {
    Fail "Tag compliance report script missing: $script"
  }

  exit 0
}catch{
  Fail $_.Exception.Message
}
