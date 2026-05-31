param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$true)]
  [string]$ResourceGroupName,

  [Parameter(Mandatory=$true)]
  [string]$RecoveryVaultName
)

$ErrorActionPreference="Stop"
function Fail($m){Write-Host "FAIL: $m"; exit 1}
function Pass($m){Write-Host "PASS: $m"}

try{
  Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

  $vault = Get-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $RecoveryVaultName -ErrorAction Stop
  Pass "Recovery Services vault exists: $RecoveryVaultName"

  Set-AzRecoveryServicesVaultContext -Vault $vault | Out-Null
  $policies = Get-AzRecoveryServicesBackupProtectionPolicy -ErrorAction SilentlyContinue
  if (-not $policies -or $policies.Count -lt 1) { Fail "No backup policies found in vault" }
  Pass "Backup policy exists"

  exit 0
}catch{
  Fail $_.Exception.Message
}
