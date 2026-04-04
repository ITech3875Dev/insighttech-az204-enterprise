# Az CLI Lab - M04 Storage Security and Governance

## Variables
```bash
export SUBSCRIPTION_ID="<subscription-id>"
export RG="rg-az104-storage-dev-eastus2-01"
export STORAGE_ACCOUNT="<storage-account-name>"
export ALLOWED_IP="<your-public-ip>"
```

## Task 1 - Baseline security configuration
```bash
az login
az account set --subscription "$SUBSCRIPTION_ID"

az storage account update \
	--name "$STORAGE_ACCOUNT" \
	--resource-group "$RG" \
	--https-only true \
	--min-tls-version TLS1_2 \
	--allow-blob-public-access false
```

## Task 2 - Restrict network access
```bash
az storage account update \
	--name "$STORAGE_ACCOUNT" \
	--resource-group "$RG" \
	--default-action Deny

az storage account network-rule add \
	--resource-group "$RG" \
	--account-name "$STORAGE_ACCOUNT" \
	--ip-address "$ALLOWED_IP"
```

## Verify
```bash
az storage account show --name "$STORAGE_ACCOUNT" --resource-group "$RG" --query "{httpsOnly:httpsTrafficOnly,minTls:minTlsVersion,publicAccess:allowBlobPublicAccess,networkDefault:networkRuleSet.defaultAction}" -o json
az storage account network-rule list --account-name "$STORAGE_ACCOUNT" --resource-group "$RG" -o table
```
