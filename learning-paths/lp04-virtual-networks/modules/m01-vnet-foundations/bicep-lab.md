# Bicep Lab - M01 Storage Accounts Foundations

## Deploy
```bash
az deployment group create \
	--resource-group rg-az204-storage-dev-eastus2-01 \
	--name m01-storage-baseline \
	--template-file learning-paths/az204-lp04-monitor-troubleshoot-optimize/modules/m01-vnet-foundations/code/bicep/rg-and-rbac.bicep \
	--parameters storageAccountName="staz204m01<unique>" location="eastus2"
```

## Verify
```bash
az deployment group show -g rg-az204-storage-dev-eastus2-01 -n m01-storage-baseline -o jsonc
```


