# Portal Lab - M03 Azure Files, Sync, and Data Movement

## Variables
- Subscription: your lab subscription.
- Target RG: `rg-az104-storage-dev-eastus2-01`.
- Storage account: `<storage-account-name>`.

## Task 1 - Create Azure file shares
1. Open the storage account.
2. Go to **Data storage > File shares**.
3. Create share `profiles` with provisioned quota 100 GiB.
4. Create share `teamdocs` with provisioned quota 200 GiB.

## Task 2 - Configure share settings
1. Open share `teamdocs`.
2. Review snapshot options and quotas.
3. Document SMB access path and connection details.

## Task 3 - Data movement with Storage browser
1. In the storage account, open **Storage browser**.
2. Upload sample files to `profiles` and `teamdocs`.
3. Copy one folder from `profiles` to `teamdocs`.

## Task 4 - File Sync planning
1. In Azure Portal, open **Storage Sync Services**.
2. Create sync service `stsync-az104-eastus2-01` in the same RG.
3. Create a sync group named `sync-teamdocs` and select cloud endpoint `teamdocs`.
4. Record required on-prem agent and server endpoint prerequisites for later implementation.

## Verify
- `profiles` and `teamdocs` exist and are accessible.
- Sample files are present in target share after copy.
- Sync service and sync group exist with cloud endpoint configured.
