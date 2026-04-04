# Bicep Lab - M04 Storage Security and Governance

## Goal
Deploy storage account security baseline configuration as code.

## Files
- `code/main.bicep`

## Deploy
```bash
az deployment group create \
	--resource-group rg-az104-storage-dev-eastus2-01 \
	--template-file learning-paths/lp03-compute-resources/modules/m04-compute-security-and-operations/code/main.bicep \
	--parameters storageAccountName=<storage-account-name> allowBlobPublicAccess=false minTlsVersion=TLS1_2
```

## Verify
```bash
az storage account show \
	--name <storage-account-name> \
	--resource-group rg-az104-storage-dev-eastus2-01 \
	--query "{httpsOnly:httpsTrafficOnly,minTls:minTlsVersion,publicAccess:allowBlobPublicAccess}"
```
