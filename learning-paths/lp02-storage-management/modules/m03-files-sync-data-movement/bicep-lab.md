# Bicep Lab - M03 Azure Files, Sync, and Data Movement

## Goal
Deploy Azure file shares for data movement and sync preparation.

## Files
- `code/main.bicep`

## Deploy
```bash
az deployment group create \
	--resource-group rg-az104-storage-dev-eastus2-01 \
	--template-file learning-paths/lp02-storage-management/modules/m03-files-sync-data-movement/code/main.bicep \
	--parameters storageAccountName=<storage-account-name>
```
