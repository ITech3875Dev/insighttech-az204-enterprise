param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$StorageAccountName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $sa = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -ErrorAction Stop
  Pass "Storage account exists: $StorageAccountName"

  if (-not $sa.EnableHttpsTrafficOnly) { Fail "Secure transfer (HTTPS only) is not enabled" }
  Pass "Secure transfer is enabled"

  if ($sa.MinimumTlsVersion -ne "TLS1_2") { Fail "Minimum TLS version is not TLS1_2" }
  Pass "Minimum TLS version is TLS1_2"

  if ($sa.AllowBlobPublicAccess) { Fail "Blob public access is enabled" }
  Pass "Blob public access is disabled"

  if ($sa.NetworkRuleSet.DefaultAction -ne "Deny") { Fail "Network default action is not Deny" }
  Pass "Network access default action is Deny"

  exit 0
}catch{
  Fail $_.Exception.Message
}
