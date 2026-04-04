# Azure CLI Lab - M01 Storage Accounts Foundations

## Variables
```bash
SUB_ID="<subscription-id>"
RG_NAME="rg-az104-storage-dev-eastus2-01"
LOC="eastus2"
SA_NAME="staz104m01$RANDOM$RANDOM"
```

## Task 1 - Resource group
```bash
az account set --subscription "$SUB_ID"

az group create --name "$RG_NAME" --location "$LOC" \
  --tags Owner="student" CostCenter="IT-104" Environment="dev" Workload="storage" DataClass="internal" ExpirationDate="2026-12-31"
```

## Task 2 - Storage account
```bash
az storage account create \
  --name "$SA_NAME" \
  --resource-group "$RG_NAME" \
  --location "$LOC" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --access-tier Hot \
  --https-only true \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false
```

## Task 3 - File share
```bash
az storage share-rm create --resource-group "$RG_NAME" --storage-account "$SA_NAME" --name share-m01
```

## Verify
```bash
az storage account show -g "$RG_NAME" -n "$SA_NAME" --query "{name:name,sku:sku.name,kind:kind,httpsOnly:httpsOnly,minTls:minTlsVersion,publicAccess:allowBlobPublicAccess}" -o yaml
az storage share-rm list -g "$RG_NAME" --storage-account "$SA_NAME" -o table
```
