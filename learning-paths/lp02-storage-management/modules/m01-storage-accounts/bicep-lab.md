# Bicep Lab - M01 Storage Accounts Foundations

## Deploy
```bash
az deployment group create \
	--resource-group rg-az104-storage-dev-eastus2-01 \
	--name m01-storage-baseline \
	--template-file learning-paths/lp02-storage-management/modules/m01-storage-accounts/code/bicep/rg-and-rbac.bicep \
	--parameters storageAccountName="staz104m01<unique>" location="eastus2"
```

## Verify
```bash
az deployment group show -g rg-az104-storage-dev-eastus2-01 -n m01-storage-baseline -o jsonc
```
