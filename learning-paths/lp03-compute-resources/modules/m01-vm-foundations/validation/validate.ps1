param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$VmName
)

$ErrorActionPreference = "Stop"

function Fail($msg) { Write-Host "FAIL: $msg"; exit 1 }
function Pass($msg) { Write-Host "PASS: $msg" }

try {
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $vm = Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -Status -ErrorAction Stop
  Pass "VM exists: $VmName"

  if ($vm.ProvisioningState -ne "Succeeded") { Fail "VM provisioning state is not Succeeded" }
  Pass "VM provisioning state is Succeeded"

  $power = ($vm.Statuses | Where-Object { $_.Code -like "PowerState/*" } | Select-Object -First 1).DisplayStatus
  if (-not $power) { Fail "Unable to determine VM power state" }
  Pass "VM power state: $power"

  if (-not $vm.HardwareProfile.VmSize) { Fail "VM size is not set" }
  Pass "VM size is configured: $($vm.HardwareProfile.VmSize)"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
