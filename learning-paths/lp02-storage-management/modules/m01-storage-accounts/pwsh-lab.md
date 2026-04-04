# PowerShell Lab - M01 Storage Accounts Foundations

## Variables
```powershell
$SubscriptionId = "<subscription-id>"
$RgName = "rg-az104-storage-dev-eastus2-01"
$Location = "eastus2"
$StorageAccountName = "staz104m01$((Get-Random -Maximum 99999))"
```

## Task 1 - Context and resource group
```powershell
Select-AzSubscription -SubscriptionId $SubscriptionId
New-AzResourceGroup -Name $RgName -Location $Location -Tag @{
  Owner="student"; CostCenter="IT-104"; Environment="dev"; Workload="storage"; DataClass="internal"; ExpirationDate="2026-12-31"
}
```

## Task 2 - Storage account
```powershell
New-AzStorageAccount \
  -ResourceGroupName $RgName \
  -Name $StorageAccountName \
  -Location $Location \
  -SkuName Standard_LRS \
  -Kind StorageV2 \
  -AccessTier Hot \
  -MinimumTlsVersion TLS1_2 \
  -EnableHttpsTrafficOnly $true \
  -AllowBlobPublicAccess $false

$ctx = (Get-AzStorageAccount -ResourceGroupName $RgName -Name $StorageAccountName).Context
New-AzStorageShare -Name "share-m01" -Context $ctx
```

## Verify
```powershell
Get-AzStorageAccount -ResourceGroupName $RgName -Name $StorageAccountName | Select-Object StorageAccountName, Kind, SkuName, EnableHttpsTrafficOnly, MinimumTlsVersion
Get-AzStorageShare -Context $ctx | Select-Object Name
```
