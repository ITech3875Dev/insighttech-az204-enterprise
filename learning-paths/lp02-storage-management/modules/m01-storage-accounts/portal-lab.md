# Portal Lab - M01 Storage Accounts Foundations

## Goal
Deploy a storage account baseline with secure defaults and governance-ready configuration.

## Task 1 - Set subscription and create resource group
1. Switch to your assigned subscription.
2. Create `rg-az104-storage-dev-eastus2-01` in East US 2.
3. Apply required tags: Owner, CostCenter, Environment, Workload, DataClass, ExpirationDate.

## Task 2 - Create storage account
1. Create storage account `staz104m01<unique>`.
2. Performance: Standard.
3. Redundancy: Standard_LRS.
4. Secure transfer required: Enabled.
5. Minimum TLS version: 1.2.
6. Blob public access: Disabled.

## Task 3 - Create baseline file share
1. Open File shares.
2. Create share `share-m01`.
3. Capture evidence screenshot with share and account settings.

## Verify
- Storage account is in the correct region and SKU.
- Security settings are applied.
- File share exists.

## Troubleshooting
- Storage name unavailable: choose a globally unique value.
- Missing setting in portal: confirm account kind is StorageV2.
- Authorization errors: verify RBAC role on RG scope.
