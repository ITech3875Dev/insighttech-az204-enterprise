# Intermediate Lab 02 — Inheritance & Scope Troubleshooting (RBAC + Policy)

## Time Estimate
- 75 to 105 minutes

## Prerequisites
- M01 and M02 completed
- Access to at least one management group and one subscription
- Ability to read RBAC and policy assignments

## Scenario
A team reports:
- They can read resources in one resource group but not another.
- A “required tag” policy blocks creation in some places but not others.

Your job:
1. Identify correct scope(s)
2. Enumerate RBAC assignments and inheritance
3. Validate policy assignments and effects
4. Produce evidence using CLI + PowerShell
5. Document the fix and rollback plan

## Variables

```bash
SUB_ID="<subscription-id>"
RG_A="rg-az104-inherit-a-dev-eastus2-01"
RG_B="rg-az104-inherit-b-dev-eastus2-01"
MG_ID="<management-group-id>"
```

```powershell
$SubscriptionId = "<subscription-id>"
$RgA = "rg-az104-inherit-a-dev-eastus2-01"
$RgB = "rg-az104-inherit-b-dev-eastus2-01"
$ManagementGroupId = "<management-group-id>"
```

## Step 1 - Collect Current State

### Azure CLI
```bash
az account set --subscription "$SUB_ID"

az role assignment list --scope "/subscriptions/$SUB_ID" -o json > evidence-rbac-subscription.json
az role assignment list --scope "/subscriptions/$SUB_ID/resourceGroups/$RG_A" -o json > evidence-rbac-rga.json
az role assignment list --scope "/subscriptions/$SUB_ID/resourceGroups/$RG_B" -o json > evidence-rbac-rgb.json

az policy assignment list --scope "/providers/Microsoft.Management/managementGroups/$MG_ID" -o json > evidence-policy-mg.json
az policy assignment list --scope "/subscriptions/$SUB_ID" -o json > evidence-policy-subscription.json
az policy assignment list --scope "/subscriptions/$SUB_ID/resourceGroups/$RG_A" -o json > evidence-policy-rga.json
az policy assignment list --scope "/subscriptions/$SUB_ID/resourceGroups/$RG_B" -o json > evidence-policy-rgb.json
```

### PowerShell
```powershell
Select-AzSubscription -SubscriptionId $SubscriptionId

Get-AzRoleAssignment -Scope "/subscriptions/$SubscriptionId" | ConvertTo-Json -Depth 8 | Out-File evidence-rbac-subscription-pwsh.json
Get-AzRoleAssignment -Scope "/subscriptions/$SubscriptionId/resourceGroups/$RgA" | ConvertTo-Json -Depth 8 | Out-File evidence-rbac-rga-pwsh.json
Get-AzRoleAssignment -Scope "/subscriptions/$SubscriptionId/resourceGroups/$RgB" | ConvertTo-Json -Depth 8 | Out-File evidence-rbac-rgb-pwsh.json

Get-AzPolicyAssignment -Scope "/providers/Microsoft.Management/managementGroups/$ManagementGroupId" | ConvertTo-Json -Depth 8 | Out-File evidence-policy-mg-pwsh.json
Get-AzPolicyAssignment -Scope "/subscriptions/$SubscriptionId" | ConvertTo-Json -Depth 8 | Out-File evidence-policy-subscription-pwsh.json
```

## Step 2 - Compare Effective RBAC Across Scopes

1. Identify principal differences between RG_A and RG_B.
2. Confirm if missing access is due to:
   - No role assignment at inherited scope
   - Explicit narrower assignment in one RG only
   - Wrong principal object
3. Capture your findings in a table.

Template:

| Principal | Expected Role | Expected Scope | Actual Scope | Gap | Fix |
|---|---|---|---|---|---|
| team-ops | Reader | Subscription | RG_A only | Missing inheritance to RG_B | add assignment at subscription |

## Step 3 - Compare Effective Policy Behavior

1. Confirm where required-tag policy is assigned.
2. Check if exemptions exist for one RG but not the other.
3. Verify policy effect (Audit, Deny, Modify).

CLI helper:

```bash
az policy exemption list --scope "/subscriptions/$SUB_ID" -o table
az policy state summarize --management-group "$MG_ID" -o json > evidence-policy-summary-mg.json
az policy state summarize --subscription "$SUB_ID" -o json > evidence-policy-summary-subscription.json
```

## Step 4 - Implement and Verify Fix

Apply only the minimum change required:
- RBAC fix example: add missing Reader assignment at subscription scope
- Policy fix example: align assignment scope, remove incorrect exemption, or use targeted exemption with expiration

CLI RBAC example:

```bash
PRINCIPAL_ID="<object-id>"
az role assignment create \
  --assignee-object-id "$PRINCIPAL_ID" \
  --assignee-principal-type Group \
  --role Reader \
  --scope "/subscriptions/$SUB_ID"
```

Policy exemption example:

```bash
az policy exemption create \
  --name "ex-rga-temporary-tag" \
  --scope "/subscriptions/$SUB_ID/resourceGroups/$RG_A" \
  --policy-assignment "<policy-assignment-id>" \
  --exemption-category Waiver \
  --expires-on "2026-12-31T23:59:00Z" \
  --display-name "Temporary waiver for migration"
```

Re-run evidence commands from Step 1 after fix.

## Step 5 - Root Cause and Rollback
Create root-cause-summary.md with:
1. What was wrong
2. Why it happened
3. Fix applied
4. Rollback command(s)
5. Prevention control (review cadence, policy guardrail, RBAC standards)

## Required Deliverables
- Completed troubleshooting checklist using playbooks:
  - `docs/program/playbooks/rbac-scope-troubleshooting.md`
  - `docs/program/playbooks/policy-compliance-troubleshooting.md`
- Evidence:
  - RBAC role assignment listings at relevant scopes
  - Policy assignment listings at relevant scopes
- Root-cause summary:
  - What was wrong
  - Why it happened
  - Fix + rollback
  - Prevention

## Acceptance Criteria
- Evidence files captured for before and after states
- Root cause is specific and testable
- Fix minimizes blast radius
- Rollback is executable
- Prevention guidance is documented

