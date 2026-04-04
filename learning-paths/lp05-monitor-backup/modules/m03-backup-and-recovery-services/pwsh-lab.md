# PowerShell Lab - M03 Azure Files, Sync, and Data Movement

## Variables
```powershell
$SubscriptionId = "<subscription-id>"
$ResourceGroupName = "rg-az104-storage-dev-eastus2-01"
$StorageAccountName = "<storage-account-name>"
$SyncServiceName = "stsync-az104-eastus2-01"
```

## Task 1 - Context and file shares
```powershell
Select-AzSubscription -SubscriptionId $SubscriptionId
$ctx = (Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName).Context

New-AzStorageShare -Name "profiles" -Context $ctx -QuotaGiB 100
New-AzStorageShare -Name "teamdocs" -Context $ctx -QuotaGiB 200
```

## Task 2 - Upload sample files
```powershell
"profile-one" | Out-File -FilePath .\sample1.txt
"profile-two" | Out-File -FilePath .\sample2.txt

Set-AzStorageFileContent -ShareName "profiles" -Source .\sample1.txt -Path "sample1.txt" -Context $ctx | Out-Null
Set-AzStorageFileContent -ShareName "profiles" -Source .\sample2.txt -Path "sample2.txt" -Context $ctx | Out-Null
```

## Task 3 - Create Storage Sync Service
```powershell
az storagesync create --resource-group $ResourceGroupName --name $SyncServiceName --location eastus2
```

## Verify
```powershell
Get-AzStorageShare -Context $ctx | Select-Object Name, Quota
az storagesync list --resource-group $ResourceGroupName -o table
```
