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

  $ctx = $sa.Context
  $requiredShares = @("profiles", "teamdocs")
  foreach ($shareName in $requiredShares) {
    $share = Get-AzStorageShare -Context $ctx -Name $shareName -ErrorAction SilentlyContinue
    if (-not $share) { Fail "Share '$shareName' not found" }
    Pass "Share exists: $shareName"
  }

  $files = Get-AzStorageFile -ShareName "teamdocs" -Path "/" -Context $ctx -ErrorAction SilentlyContinue
  if (-not $files) { Fail "No files found in teamdocs share. Verify data movement step." }
  Pass "Destination share contains files"

  exit 0
}catch{
  Fail $_.Exception.Message
}
