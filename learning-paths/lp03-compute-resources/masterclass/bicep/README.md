# Bicep Masterclass — LP03 (Deploy and manage Azure compute resources)

## Purpose
Build repeatable governance deployments with Bicep for LP03 objectives. This masterclass focuses on scope-safe deployments, deterministic role assignments, policy-as-code, and validation evidence.

## Time Estimate
- 2 to 3 hours

## Prerequisites
- Azure CLI and Bicep installed
- Access to non-production subscription
- Ability to assign RBAC and policy at RG or subscription scope

## Learning Outcomes
1. Deploy resource groups with required tags from parameterized Bicep
2. Deploy RBAC assignments with deterministic names
3. Deploy policy definitions and assignments safely
4. Add and validate resource locks
5. Produce reproducible evidence artifacts

## Workspace Context
Use shared modules in:
- `shared/bicep/main.bicep`
- `shared/bicep/modules/identity/`
- `shared/bicep/modules/policy/`
- `shared/bicep/modules/rg/`
- `shared/bicep/modules/tagging/`

## Setup

```bash
SUB_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az104-bicep-dev-eastus2-01"

az account set --subscription "$SUB_ID"
az bicep version
```

## Exercise 1 - Resource Group and Tags via Bicep

1. Create `main-rg.bicep` with:
	 - `targetScope = 'subscription'`
	 - parameterized RG name and location
	 - required tags object
2. Build and deploy.

```bash
az bicep build --file main-rg.bicep

az deployment sub create \
	--name "dep-rg-baseline" \
	--location "$LOCATION" \
	--template-file main-rg.bicep \
	--parameters rgName="$RG_NAME" location="$LOCATION"
```

## Exercise 2 - RBAC Assignment with Deterministic Naming

Design goals:
- no random role-assignment names
- same deployment can be run repeatedly without duplicate failures

Implementation pattern:
- Use `guid(scope, principalId, roleDefinitionId)` for assignment name

Validation commands:

```bash
RG_SCOPE=$(az group show --name "$RG_NAME" --query id -o tsv)
az role assignment list --scope "$RG_SCOPE" -o table
```

## Exercise 3 - Policy Definition and Assignment

1. Deploy policy definition from Bicep
2. Assign policy at chosen scope
3. Parameterize effect (`Audit` or `Deny`) and required tag names

```bash
az bicep build --file main-policy.bicep

az deployment sub create \
	--name "dep-policy-baseline" \
	--location "$LOCATION" \
	--template-file main-policy.bicep \
	--parameters targetRgName="$RG_NAME" effect="Audit"
```

## Exercise 4 - Lock Deployment

Deploy lock at RG scope (`CanNotDelete`) and verify behavior.

```bash
az lock list --resource-group "$RG_NAME" -o table
```

## Exercise 5 - Idempotency and Safe Re-runs

1. Re-run all deployments unchanged
2. Confirm no destructive drift
3. Confirm outputs remain stable

```bash
az deployment sub what-if \
	--name "dep-policy-baseline-whatif" \
	--location "$LOCATION" \
	--template-file main-policy.bicep \
	--parameters targetRgName="$RG_NAME" effect="Audit"
```

## Required Deliverables
- `evidence/dep-rg-output.json`
- `evidence/dep-rbac-output.json`
- `evidence/dep-policy-output.json`
- `evidence/dep-lock-output.json`
- `evidence/whatif-output.txt`
- `design-notes.md` (scope choices, blast radius, idempotency notes)

## Acceptance Criteria
- Templates compile successfully
- Deployments succeed without manual portal steps
- Deterministic naming used for RBAC assignments
- Policy assignment visible at intended scope
- Lock exists and behavior is verified
- What-if output reviewed and captured

## Troubleshooting
- Compile errors: run `az bicep build --file <file>.bicep` first and fix line-level issues
- Authorization failures: verify role assignment rights at target scope
- Role assignment conflicts: ensure deterministic `guid()` naming inputs are stable
- Policy assignment not visible: confirm target scope and active subscription context
