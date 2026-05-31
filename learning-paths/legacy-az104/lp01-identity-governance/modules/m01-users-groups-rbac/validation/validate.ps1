param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$GroupObjectId
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $rg = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
  if (-not $rg) { Fail "Resource group not found: $ResourceGroupName" }
  Pass "Resource group exists: $ResourceGroupName"

  $requiredTags = @("Owner","CostCenter","Environment","Workload","DataClass","ExpirationDate")
  foreach ($t in $requiredTags) {
    if (-not $rg.Tags.ContainsKey($t)) { Fail "Missing required tag: $t" }
  }
  Pass "Required tags present on RG"

  $scope = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName"
  $assignments = Get-AzRoleAssignment -Scope $scope -ErrorAction SilentlyContinue
  $hit = $assignments | Where-Object { $_.ObjectId -eq $GroupObjectId -and $_.RoleDefinitionName -eq "Reader" }
  if (-not $hit) { Fail "Reader role assignment not found for group $GroupObjectId at scope $scope" }

  Pass "Reader role assignment present for group at RG scope"
  exit 0
}
catch {
  Fail $_.Exception.Message
}
