# CLI Masterclass — LP01 (Identity & Governance)

## Purpose
Run governance operations from CLI with reproducible output and audit-ready evidence.

## Time Estimate
- 90 to 120 minutes

## Prerequisites
- Azure CLI installed and logged in
- Access to one non-production subscription
- Write access to local `out/` folder

## Learning Outcomes
1. Export RBAC and policy state at multiple scopes
2. Trace principal permissions quickly
3. Validate governance guardrails using CLI-only workflows
4. Capture evidence artifacts for PR review

## Setup

```bash
mkdir -p out
SUB="<subId>"
RG="rg-az104-cliops-dev-eastus2-01"

az account set --subscription "$SUB"
az account show -o table
```

## Drill 1 - RBAC Inventory and Scope Analysis

```bash
az role assignment list --scope "/subscriptions/$SUB" -o json > out/rbac-assignments-subscription.json
az role assignment list --scope "/subscriptions/$SUB/resourceGroups/$RG" -o json > out/rbac-assignments-rg.json
```

Convert to reviewer-friendly table:

```bash
az role assignment list --scope "/subscriptions/$SUB" \
	--query "[].{principal:principalName,role:roleDefinitionName,scope:scope}" -o table > out/rbac-table.txt
```

## Drill 2 - Principal-Centric Permission Trace

```bash
PRINCIPAL="<objectId>"
az role assignment list --assignee-object-id "$PRINCIPAL" -o json > out/rbac-principal.json
az role assignment list --assignee-object-id "$PRINCIPAL" -o table > out/rbac-principal.txt
```

## Drill 3 - Management Group and Subscription Context

```bash
az account management-group list -o table > out/mg-list.txt
az account management-group show --name "<mgId>" -o json > out/mg-detail.json
```

## Drill 4 - Policy Assignment and Compliance View

```bash
az policy assignment list --scope "/subscriptions/$SUB" -o json > out/policy-assignments.json
az policy state summarize --subscription "$SUB" -o json > out/policy-state-summary.json
az policy exemption list --scope "/subscriptions/$SUB" -o json > out/policy-exemptions.json
```

## Drill 5 - Cost and Advisor Evidence

```bash
az advisor recommendation list -o json > out/advisor-recommendations.json
az consumption budget list --scope "/subscriptions/$SUB" -o json > out/budgets.json
```

If budget command is unavailable in your tenant context, capture and document the exact error in `out/budgets-error.txt`.

## Required Deliverables
- `out/rbac-assignments-subscription.json`
- `out/rbac-assignments-rg.json`
- `out/rbac-principal.json`
- `out/policy-assignments.json`
- `out/policy-state-summary.json`
- `out/advisor-recommendations.json`
- `out/cli-analysis-summary.md` (what was found, key risks, recommended next actions)

## Acceptance Criteria
- All key exports generated without secrets
- RBAC and policy outputs are scope-correct
- Principal trace clearly maps role-to-scope
- Analysis summary includes at least three concrete findings

## Troubleshooting
- Empty output: verify subscription context with `az account show`
- Permission denied: confirm role at queried scope
- Incomplete management group results: verify tenant-level reader access
- Command version mismatch: run `az version` and update CLI if needed
