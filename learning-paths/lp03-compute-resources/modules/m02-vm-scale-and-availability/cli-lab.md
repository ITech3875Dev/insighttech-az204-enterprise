# Azure CLI Lab - M02 Blob Services and Data Protection

## Variables
```bash
SUB_ID="<subscription-id>"
RG_NAME="rg-az104-storage-dev-eastus2-01"
SA_NAME="<storage-account-name>"
```

## Task 1 - Create containers
```bash
az account set --subscription "$SUB_ID"
az storage container create --account-name "$SA_NAME" --name raw --auth-mode login
az storage container create --account-name "$SA_NAME" --name curated --auth-mode login
az storage container create --account-name "$SA_NAME" --name archive --auth-mode login
```

## Task 2 - Enable protection settings
```bash
az storage account blob-service-properties update \
	--account-name "$SA_NAME" \
	--resource-group "$RG_NAME" \
	--enable-versioning true \
	--enable-delete-retention true \
	--delete-retention-days 14
```

## Task 3 - Lifecycle policy
```bash
cat > lifecycle.json <<'JSON'
{
	"rules": [
		{
			"enabled": true,
			"name": "move-to-cool-then-archive",
			"type": "Lifecycle",
			"definition": {
				"actions": {
					"baseBlob": {
						"tierToCool": {"daysAfterModificationGreaterThan": 30},
						"tierToArchive": {"daysAfterModificationGreaterThan": 90}
					}
				},
				"filters": {"blobTypes": ["blockBlob"], "prefixMatch": [""]}
			}
		}
	]
}
JSON

az storage account management-policy create -g "$RG_NAME" --account-name "$SA_NAME" --policy @lifecycle.json
```

## Verify
```bash
az storage container list --account-name "$SA_NAME" --auth-mode login -o table
az storage account blob-service-properties show --account-name "$SA_NAME" --resource-group "$RG_NAME" -o jsonc
az storage account management-policy show -g "$RG_NAME" --account-name "$SA_NAME" -o jsonc
```
