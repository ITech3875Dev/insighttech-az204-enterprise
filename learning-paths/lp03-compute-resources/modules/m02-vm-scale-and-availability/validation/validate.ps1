param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$VmssName
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $vmss = Get-AzVmss -ResourceGroupName $ResourceGroupName -VMScaleSetName $VmssName -ErrorAction Stop
  Pass "VMSS exists: $VmssName"

  if (-not $vmss.Sku -or $vmss.Sku.Capacity -lt 1) { Fail "VMSS capacity is invalid" }
  Pass "VMSS capacity configured: $($vmss.Sku.Capacity)"

  $autoscale = az monitor autoscale list --resource-group $ResourceGroupName --query "[?targetResourceUri!=null]" -o json | ConvertFrom-Json
  if (-not $autoscale -or $autoscale.Count -lt 1) { Fail "No autoscale settings found in resource group" }
  Pass "Autoscale settings found"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
