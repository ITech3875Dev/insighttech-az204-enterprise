param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$StorageAccountName
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

  $sa = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -ErrorAction SilentlyContinue
  if (-not $sa) { Fail "Storage account not found: $StorageAccountName" }
  Pass "Storage account exists"

  if (-not $sa.EnableHttpsTrafficOnly) { Fail "HTTPS-only must be enabled" }
  Pass "HTTPS-only enabled"

  if ($sa.MinimumTlsVersion -ne "TLS1_2") { Fail "Minimum TLS must be TLS1_2" }
  Pass "Minimum TLS is TLS1_2"

  if ($sa.AllowBlobPublicAccess) { Fail "Blob public access should be disabled" }
  Pass "Blob public access is disabled"

  exit 0
}
catch {
  Fail $_.Exception.Message
}
