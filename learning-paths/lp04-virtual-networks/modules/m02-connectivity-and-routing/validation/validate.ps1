param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$RouteTableName
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $rt = Get-AzRouteTable -ResourceGroupName $ResourceGroupName -Name $RouteTableName -ErrorAction Stop
  Pass "Route table exists: $RouteTableName"

  if (-not $rt.Routes -or $rt.Routes.Count -lt 1) { Fail "No routes found in route table" }
  Pass "Route count is valid: $($rt.Routes.Count)"

  $customRoute = $rt.Routes | Where-Object { $_.Name -ne "default" } | Select-Object -First 1
  if (-not $customRoute) { Fail "No custom route detected" }
  Pass "Custom route detected: $($customRoute.Name)"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
