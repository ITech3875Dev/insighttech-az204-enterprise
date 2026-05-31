# Lab 01 (Advanced): Storage Security and Lifecycle Hardening

## Scenario
You are hardening an application storage estate for production. Apply lifecycle rules, enforce secure storage defaults, and validate that Blob Storage and Cosmos DB settings align to enterprise expectations.

## Prerequisites
- Azure CLI installed.
- Contributor access to subscription.
- Existing LP02 resource group or create a new one.

## Variables

```bash
SUBSCRIPTION_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az204-storage-dev-eastus2-01"
STORAGE_ACCOUNT="staz204blobdev01"
COSMOS_ACCOUNT="cosmos-az204-dev-01"
DATABASE_NAME="OrdersDb"
CONTAINER_NAME="Orders"
BLOB_CONTAINER="appdata"
```

## Task 1: Confirm baseline storage resources

```bash
az account set --subscription "$SUBSCRIPTION_ID"
az storage account show -g "$RG_NAME" -n "$STORAGE_ACCOUNT" -o table
az cosmosdb show -g "$RG_NAME" -n "$COSMOS_ACCOUNT" -o table
```

## Task 2: Apply lifecycle management policy

Create `lifecycle-policy.json`:

```json
{
  "rules": [
    {
      "enabled": true,
      "name": "move-old-blobs-to-cool",
      "type": "Lifecycle",
      "definition": {
        "filters": {
          "blobTypes": ["blockBlob"],
          "prefixMatch": ["appdata/"]
        },
        "actions": {
          "baseBlob": {
            "tierToCool": {
              "daysAfterModificationGreaterThan": 30
            }
          }
        }
      }
    }
  ]
}
```

Apply policy:

```bash
az storage account management-policy create \
  --account-name "$STORAGE_ACCOUNT" \
  --resource-group "$RG_NAME" \
  --policy @lifecycle-policy.json
```

## Task 3: Verify secure storage posture

```bash
az storage account show \
  --resource-group "$RG_NAME" \
  --name "$STORAGE_ACCOUNT" \
  --query "{allowBlobPublicAccess:allowBlobPublicAccess, minimumTlsVersion:minimumTlsVersion}" \
  -o table
```

Expected values:
- `allowBlobPublicAccess = false`
- `minimumTlsVersion = TLS1_2`

## Task 4: Review Cosmos DB configuration

```bash
az cosmosdb show \
  --resource-group "$RG_NAME" \
  --name "$COSMOS_ACCOUNT" \
  --query "{consistency:consistencyPolicy.defaultConsistencyLevel, endpoint:documentEndpoint}" \
  -o table

az cosmosdb sql container show \
  --account-name "$COSMOS_ACCOUNT" \
  --resource-group "$RG_NAME" \
  --database-name "$DATABASE_NAME" \
  --name "$CONTAINER_NAME" \
  --query "{partitionKey:resource.partitionKey.paths[0]}" \
  -o table
```

## Task 5: Capture evidence and remediation notes

Record:
- Lifecycle policy creation output
- Storage security configuration output
- Cosmos DB consistency and partition key output
- One short remediation note explaining what would fail LP02 validation if public access were enabled or partition key path drifted

## Validation Checks
- Lifecycle policy exists on the storage account.
- Public blob access remains disabled.
- Minimum TLS is TLS1_2.
- Cosmos DB consistency is Session.
- Cosmos container partition key path remains `/customerId`.

## Cleanup
Keep resources for capstone unless instructed otherwise. If needed:

```bash
az group delete --name "$RG_NAME" --yes --no-wait
```
