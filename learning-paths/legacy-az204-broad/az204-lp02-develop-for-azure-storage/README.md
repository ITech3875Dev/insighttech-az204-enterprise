# AZ-204 LP02: Develop for Azure Storage

## Overview
This learning path delivers production-oriented Azure storage implementation skills for AZ-204, with hands-on workflows for Blob Storage, Cosmos DB, SDK usage, lifecycle governance, secure access, and validation-driven delivery.

## Audience
- Developers preparing for AZ-204 storage outcomes.
- Engineers building cloud-native application data layers on Azure.
- Instructors delivering repeatable enterprise storage labs with validation evidence.

## Learning Outcomes
By the end of LP02, learners can:
- Build and validate Blob Storage read/write workflows.
- Implement Cosmos DB data models, partitioning, and query patterns.
- Apply secure access and lifecycle controls for application storage.
- Validate storage resources and configuration with script-based checks.

## Delivery Model
- Beginner labs: guided storage workflow implementation.
- Intermediate labs: partition-aware data operations and query validation.
- Advanced labs: security, lifecycle, and governance hardening.
- Capstone: integrate Blob and Cosmos patterns with production readiness evidence.

## Modules
- `m01-blob-storage-application-workflows`
- `m02-cosmos-db-data-access-patterns`

## Lab Sequence
- Beginner: `labs/beginner/lab-01-blob-sdk-workflows`
- Intermediate: `labs/intermediate/lab-01-cosmos-db-query-patterns`
- Advanced: `labs/advanced/lab-01-storage-security-and-lifecycle-hardening`
- Capstone: `labs/capstone/lab-01-storage-solutions-production-readiness`

## Masterclass
- `masterclass/sdk/README.md`: SDK-first storage integration, performance review, and troubleshooting workflow.

## Assessments
- `exams/practice-50q.md`: 50-question LP02 practice set.
- `exams/answer-key.md`: answer key and objective mapping.

## Validation
Run LP-level validation after completing labs:

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

## Definition of Done
- All four lab levels completed with evidence.
- Practice set attempted and reviewed against answer key.
- Validation script returns successful checks for resource state, storage security, and Cosmos configuration.
- Learner can defend storage design decisions for access, lifecycle, and partitioning.
