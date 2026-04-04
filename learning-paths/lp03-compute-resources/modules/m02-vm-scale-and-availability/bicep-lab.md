# Bicep Lab - M02 Blob Services and Data Protection

## Goal
Deploy blob service data protection settings for an existing storage account.

## Files
- `code/main.bicep`

## Steps
```bash
az deployment group create \
	--resource-group rg-az104-storage-dev-eastus2-01 \
	--template-file learning-paths/lp03-compute-resources/modules/m02-vm-scale-and-availability/code/main.bicep \
	--parameters storageAccountName=<storage-account-name> location=eastus2 blobDeleteRetentionDays=14
```

## Evidence
- Deployment success output.
- Blob service properties output showing versioning and delete retention enabled.
