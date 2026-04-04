param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$NsgName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name $NsgName -ErrorAction Stop
  Pass "NSG exists: $NsgName"

  if (-not $nsg.SecurityRules -or $nsg.SecurityRules.Count -lt 1) { Fail "No custom NSG rules found" }
  Pass "Custom NSG rules found: $($nsg.SecurityRules.Count)"

  $denyInbound = $nsg.SecurityRules | Where-Object { $_.Access -eq "Deny" -and $_.Direction -eq "Inbound" } | Select-Object -First 1
  if (-not $denyInbound) { Fail "No inbound deny rule found in NSG" }
  Pass "Inbound deny rule present: $($denyInbound.Name)"

  exit 0
}catch{
  Fail $_.Exception.Message
}
