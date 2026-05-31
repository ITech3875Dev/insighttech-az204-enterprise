param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$WorkloadsManagementGroupName,

  [Parameter(Mandatory=$true)]
  [string]$GroupObjectId
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  # Validate subscription placement in MG (best-effort; MG cmdlets may require permissions)
  try {
    $mg = Get-AzManagementGroup -GroupName $WorkloadsManagementGroupName -Expand -Recurse -ErrorAction Stop
    Pass "Management group exists: $WorkloadsManagementGroupName"
  } catch {
    Fail "Unable to read management group '$WorkloadsManagementGroupName'. Ensure you have MG permissions or use instructor validation mode."
  }

  $mgScope = "/providers/Microsoft.Management/managementGroups/$WorkloadsManagementGroupName"
  $ra = Get-AzRoleAssignment -Scope $mgScope -ErrorAction SilentlyContinue | Where-Object {
    $_.ObjectId -eq $GroupObjectId -and $_.RoleDefinitionName -eq "Reader"
  }
  if (-not $ra) { Fail "Reader role assignment for group $GroupObjectId not found at MG scope $mgScope" }
  Pass "Reader role assignment exists at MG scope"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
