param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$VmName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -ErrorAction Stop
  Pass "VM exists: $VmName"

  $diag = Get-AzVMBootDiagnosticData -ResourceGroupName $ResourceGroupName -Name $VmName -ErrorAction SilentlyContinue
  if (-not $diag) { Fail "Boot diagnostics data not available for VM" }
  Pass "Boot diagnostics is available"

  $alerts = az monitor metrics alert list --resource-group $ResourceGroupName -o json | ConvertFrom-Json
  if (-not $alerts -or $alerts.Count -lt 1) { Fail "No metric alerts found in resource group" }
  Pass "Metric alert configuration found"

  exit 0
}catch{
  Fail $_.Exception.Message
}
