# Bicep Lab - M03 Azure Files, Sync, and Data Movement

## Goal
Deploy Azure file shares for data movement and sync preparation.

## Files
- `code/main.bicep`

## Deploy
```bash
az deployment group create \
	--resource-group rg-az204-storage-dev-eastus2-01 \
	--template-file learning-paths/az204-lp05-connect-consume-azure-services/modules/m03-backup-and-recovery-services/code/main.bicep \
	--parameters storageAccountName=<storage-account-name>
```


