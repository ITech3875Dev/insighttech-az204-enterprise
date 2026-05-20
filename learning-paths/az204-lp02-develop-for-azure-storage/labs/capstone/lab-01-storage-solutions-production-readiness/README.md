# Capstone Lab 01: Storage Solutions Production Readiness

## Scenario
Build and validate a complete storage delivery path combining Blob Storage workflows, Cosmos DB metadata/query patterns, lifecycle governance, and script-based quality gates.

## Outcome
At completion, your environment should satisfy all LP02 validation checks and provide evidence suitable for instructor sign-off.

## Scope
- Blob upload, listing, and retrieval workflow.
- Cosmos DB item insert, point read, and query workflow.
- Storage security and lifecycle hardening.
- LP02 validation script execution.

## Required Inputs
- Subscription ID
- Resource group name
- Storage account name
- Blob container name
- Cosmos DB account name
- Cosmos SQL database name
- Cosmos SQL container name

## Execution Plan
1. Run beginner lab and verify Blob SDK workflow output.
2. Run intermediate lab and verify Cosmos DB write/read/query output.
3. Run advanced lab and verify security and lifecycle configuration.
4. Execute LP02 validation script and resolve all failures.
5. Package evidence and summarize data design decisions.

## Validation Command

```powershell
pwsh learning-paths/az204-lp02-develop-for-azure-storage/validation/az204-lp02-validate.ps1 `
  -SubscriptionId <subscription-id> `
  -ResourceGroupName <rg-name> `
  -StorageAccountName <storage-account-name> `
  -BlobContainerName <blob-container-name> `
  -CosmosAccountName <cosmos-account-name> `
  -CosmosDatabaseName <database-name> `
  -CosmosContainerName <container-name>
```

## Pass Criteria
- Validation script returns `[RESULT] PASS`.
- Blob and Cosmos resources exist and match expected security/configuration baselines.
- Lifecycle policy is applied to the storage account.
- Cosmos DB partition key path matches the intended data access pattern.

## Evidence Package
- Blob workflow command/script output.
- Cosmos DB workflow command/script output.
- Lifecycle and security configuration output.
- Final validation output.
- One-page storage design summary:
  - Why Blob Storage is used
  - Why Cosmos DB is used
  - Why `/customerId` was chosen as the partition key
  - How lifecycle and security risk were controlled

## Cleanup
Delete lab resources only after evidence is archived and reviewed.
