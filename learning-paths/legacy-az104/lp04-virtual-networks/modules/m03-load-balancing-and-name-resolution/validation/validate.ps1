param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$LoadBalancerName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $lb = Get-AzLoadBalancer -ResourceGroupName $ResourceGroupName -Name $LoadBalancerName -ErrorAction Stop
  Pass "Load balancer exists: $LoadBalancerName"

  if (-not $lb.FrontendIpConfigurations -or $lb.FrontendIpConfigurations.Count -lt 1) { Fail "No frontend IP configuration found" }
  Pass "Frontend IP configuration found"

  if (-not $lb.BackendAddressPools -or $lb.BackendAddressPools.Count -lt 1) { Fail "No backend pool found" }
  Pass "Backend pool found"

  exit 0
}catch{
  Fail $_.Exception.Message
}
