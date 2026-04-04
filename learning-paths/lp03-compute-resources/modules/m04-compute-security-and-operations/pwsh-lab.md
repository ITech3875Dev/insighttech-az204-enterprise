# PowerShell Lab - M04 Storage Security and Governance

## Variables
```powershell
$SubscriptionId = "<subscription-id>"
$ResourceGroupName = "rg-az104-storage-dev-eastus2-01"
$StorageAccountName = "<storage-account-name>"
```

## Task 1 - Security baseline
```powershell
Select-AzSubscription -SubscriptionId $SubscriptionId

Update-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -EnableHttpsTrafficOnly $true -MinimumTlsVersion TLS1_2 -AllowBlobPublicAccess $false | Out-Null
```

## Task 2 - Network restrictions and verification
```powershell
$account = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
$account.NetworkRuleSet.DefaultAction

az storage account update --name $StorageAccountName --resource-group $ResourceGroupName --default-action Deny
az storage account network-rule list --account-name $StorageAccountName --resource-group $ResourceGroupName -o table
```

## Verify
```powershell
Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName | Select-Object StorageAccountName, EnableHttpsTrafficOnly, MinimumTlsVersion, AllowBlobPublicAccess
```
