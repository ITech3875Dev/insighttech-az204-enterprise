# PowerShell Lab - M02 Blob Services and Data Protection

## Variables
```powershell
$SubscriptionId = "<subscription-id>"
$RgName = "rg-az104-storage-dev-eastus2-01"
$StorageAccountName = "<storage-account-name>"
```

## Task 1 - Context
```powershell
Select-AzSubscription -SubscriptionId $SubscriptionId
$ctx = (Get-AzStorageAccount -ResourceGroupName $RgName -Name $StorageAccountName).Context
```

## Task 2 - Containers
```powershell
New-AzStorageContainer -Name "raw" -Context $ctx -Permission Off
New-AzStorageContainer -Name "curated" -Context $ctx -Permission Off
New-AzStorageContainer -Name "archive" -Context $ctx -Permission Off
```

## Task 3 - Protection and lifecycle
```powershell
az storage account blob-service-properties update --account-name $StorageAccountName --resource-group $RgName --enable-versioning true --enable-delete-retention true --delete-retention-days 14
```

## Verify
```powershell
Get-AzStorageContainer -Context $ctx | Select-Object Name, PublicAccess
az storage account blob-service-properties show --account-name $StorageAccountName --resource-group $RgName -o json
```
