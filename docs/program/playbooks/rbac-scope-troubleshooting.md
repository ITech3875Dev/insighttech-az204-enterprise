# Playbook — RBAC Scope Troubleshooting

Use this checklist whenever access differs from expected results.

## Step 0 — Confirm identity
- Confirm the user/principal and tenant
- Confirm group membership (if applicable)

## Step 1 — Confirm subscription context
### Azure CLI
```bash
az account show --query "{name:name,id:id,tenantId:tenantId,user:user}" -o jsonc
```

### PowerShell
```powershell
Get-AzContext | Select-Object Subscription, Tenant, Account
```

## Step 2 — Confirm intended scope string
Common scopes:
- Management group: `/providers/Microsoft.Management/managementGroups/<mgName>`
- Subscription: `/subscriptions/<subId>`
- Resource group: `/subscriptions/<subId>/resourceGroups/<rgName>`
- Resource: `<resourceId>`

## Step 3 — Enumerate role assignments (at and above scope)
### Azure CLI
```bash
SCOPE="/subscriptions/<subId>/resourceGroups/<rgName>"
az role assignment list --scope "$SCOPE" -o table
```

### PowerShell
```powershell
$scope="/subscriptions/<subId>/resourceGroups/<rgName>"
Get-AzRoleAssignment -Scope $scope | Select-Object DisplayName, RoleDefinitionName, Scope
```

## Step 4 — Validate inheritance expectations
- If assignment is at subscription/MG scope, confirm it should apply to child scope
- Confirm the principal (Object ID) is correct

## Step 5 — Behavior test (effective access)
Try one read operation and one write operation.
- Reader: read succeeds, write fails
- Contributor: write succeeds (no role assignment)

## Step 6 — Propagation
- Entra/RBAC propagation can take **1–3 minutes**

## Evidence
- Role assignment outputs
- Scope strings used
- Timestamp
