# Az CLI Lab - M03 Azure Files, Sync, and Data Movement

## Variables
```bash
export SUBSCRIPTION_ID="<subscription-id>"
export RG="rg-az104-storage-dev-eastus2-01"
export STORAGE_ACCOUNT="<storage-account-name>"
export SRC_SHARE="profiles"
export DST_SHARE="teamdocs"
```

## Task 1 - Create file shares
```bash
az login
az account set --subscription "$SUBSCRIPTION_ID"

az storage share-rm create --resource-group "$RG" --storage-account "$STORAGE_ACCOUNT" --name "$SRC_SHARE" --quota 100
az storage share-rm create --resource-group "$RG" --storage-account "$STORAGE_ACCOUNT" --name "$DST_SHARE" --quota 200
```

## Task 2 - Upload sample files
```bash
echo "profile-one" > sample1.txt
echo "profile-two" > sample2.txt

az storage file upload --account-name "$STORAGE_ACCOUNT" --share-name "$SRC_SHARE" --source sample1.txt --path sample1.txt --auth-mode login
az storage file upload --account-name "$STORAGE_ACCOUNT" --share-name "$SRC_SHARE" --source sample2.txt --path sample2.txt --auth-mode login
```

## Task 3 - Copy files with AzCopy
```bash
SRC_SAS=$(az storage share generate-sas --account-name "$STORAGE_ACCOUNT" --name "$SRC_SHARE" --permissions rl --expiry 2030-01-01T00:00Z --https-only --auth-mode login -o tsv)
DST_SAS=$(az storage share generate-sas --account-name "$STORAGE_ACCOUNT" --name "$DST_SHARE" --permissions rwdlc --expiry 2030-01-01T00:00Z --https-only --auth-mode login -o tsv)

azcopy copy "https://${STORAGE_ACCOUNT}.file.core.windows.net/${SRC_SHARE}?${SRC_SAS}" "https://${STORAGE_ACCOUNT}.file.core.windows.net/${DST_SHARE}?${DST_SAS}" --recursive=true
```

## Verify
```bash
az storage file list --account-name "$STORAGE_ACCOUNT" --share-name "$SRC_SHARE" --auth-mode login -o table
az storage file list --account-name "$STORAGE_ACCOUNT" --share-name "$DST_SHARE" --auth-mode login -o table
```
