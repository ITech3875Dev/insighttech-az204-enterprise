param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$AppServicePlanName,

  [Parameter(Mandatory=$true)]
  [string]$WebAppName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $plan = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $AppServicePlanName -ErrorAction Stop
  Pass "App Service plan exists: $AppServicePlanName"

  $app = Get-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName -ErrorAction Stop
  Pass "Web app exists: $WebAppName"

  if (-not $app.DefaultHostName) { Fail "Web app hostname not found" }
  Pass "Web app hostname is configured: $($app.DefaultHostName)"

  $aci = az container list --resource-group $ResourceGroupName -o json | ConvertFrom-Json
  if (-not $aci -or $aci.Count -lt 1) { Fail "No container instances found in resource group" }
  Pass "Container instance found"

  exit 0
}catch{
  Fail $_.Exception.Message
}
