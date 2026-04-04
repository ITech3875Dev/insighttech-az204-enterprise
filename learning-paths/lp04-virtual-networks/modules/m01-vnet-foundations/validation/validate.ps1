param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$VnetName
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VnetName -ErrorAction Stop
  Pass "Virtual network exists: $VnetName"

  if (-not $vnet.AddressSpace -or -not $vnet.AddressSpace.AddressPrefixes) { Fail "VNet address space is not configured" }
  Pass "VNet address space configured"

  if (-not $vnet.Subnets -or $vnet.Subnets.Count -lt 2) { Fail "At least two subnets are required" }
  Pass "Subnet count is valid: $($vnet.Subnets.Count)"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
