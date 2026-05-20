# Masterclass (SDK): Storage Application Patterns

## Focus
Deep-dive into SDK-driven storage integration patterns for Blob Storage and Cosmos DB in enterprise application scenarios.

## Duration
120 minutes

## Session Outcomes
By the end of this masterclass, participants can:
- Build Blob and Cosmos application workflows using SDKs.
- Diagnose partitioning and storage configuration issues.
- Validate storage security and lifecycle settings with CLI evidence.
- Package storage delivery evidence for instructor or release review.

## Suggested Agenda
1. Secure storage account baseline and Blob SDK workflow (30 min)
2. Cosmos DB data model and partition strategy walk-through (25 min)
3. Query validation and troubleshooting patterns (25 min)
4. Lifecycle policy and security hardening review (20 min)
5. LP02 validation script and evidence packaging (20 min)

## Core Commands Reference

```bash
az storage account create
az storage container create
az storage blob list
az cosmosdb create
az cosmosdb sql database create
az cosmosdb sql container create
az storage account management-policy create
```

## Workshop Deliverables
- SDK workflow output for Blob and Cosmos operations.
- Configuration evidence for lifecycle, public access, and partition settings.
- Final LP02 validation output with passing checks.
