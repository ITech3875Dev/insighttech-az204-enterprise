# Bicep Lab - M04 Storage Security and Governance

## Goal
Deploy storage account security baseline configuration as code.

## Files
- `code/main.bicep`

## Deploy
```bash
az deployment group create \
	--resource-group rg-az204-storage-dev-eastus2-01 \
	--template-file learning-paths/az204-lp05-connect-consume-azure-services/modules/m04-monitoring-governance-and-remediation/code/main.bicep \
	--parameters storageAccountName=<storage-account-name> allowBlobPublicAccess=false minTlsVersion=TLS1_2
```

## Verify
```bash
az storage account show \
	--name <storage-account-name> \
	--resource-group rg-az204-storage-dev-eastus2-01 \
	--query "{httpsOnly:httpsTrafficOnly,minTls:minTlsVersion,publicAccess:allowBlobPublicAccess}"
```


