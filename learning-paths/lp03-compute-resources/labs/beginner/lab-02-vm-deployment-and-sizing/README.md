# Beginner Lab 02 — Management Groups & Subscriptions

**Goal:** Create (or validate) a management group hierarchy, move the subscription, and apply RBAC at MG scope.

## Variables

### Azure CLI
```bash
export SUBSCRIPTION_ID="<your-subscription-id>"
export MG_ROOT="mg-az104-root"
export MG_WORKLOADS="mg-az104-workloads"
export GROUP_OBJECT_ID="<entra-group-object-id>"   # az104-rbac-readers
```

### PowerShell
```powershell
$SUBSCRIPTION_ID="<your-subscription-id>"
$MG_ROOT="mg-az104-root"
$MG_WORKLOADS="mg-az104-workloads"
$GROUP_OBJECT_ID="<entra-group-object-id>"
```

---

## Task 1 — Create the MG hierarchy (Portal + CLI + PowerShell)
Follow module `M02` portal steps. If denied, record the error and proceed to verification tasks.

---

## Task 2 — Move the subscription to `mg-az104-workloads`

### Portal
Management groups → `mg-az104-workloads` → **Add subscription** → select subscription → **Save**.

### Azure CLI
```bash
az login
az account set --subscription "$SUBSCRIPTION_ID"
az account management-group subscription add --name "$MG_WORKLOADS" --subscription "$SUBSCRIPTION_ID"
```

### PowerShell
```powershell
Connect-AzAccount
Set-AzContext -Subscription $SUBSCRIPTION_ID
New-AzManagementGroupSubscription -GroupName $MG_WORKLOADS -SubscriptionId $SUBSCRIPTION_ID
```

---

## Task 3 — Assign Reader to `az104-rbac-readers` at MG scope

### Azure CLI
```bash
MG_SCOPE="/providers/Microsoft.Management/managementGroups/${MG_WORKLOADS}"

az role assignment create   --assignee-object-id "$GROUP_OBJECT_ID"   --assignee-principal-type Group   --role "Reader"   --scope "$MG_SCOPE"   -o table
```

### PowerShell
```powershell
$mgScope="/providers/Microsoft.Management/managementGroups/$MG_WORKLOADS"
New-AzRoleAssignment -ObjectId $GROUP_OBJECT_ID -RoleDefinitionName "Reader" -Scope $mgScope | Out-Null
```

---

## Verify
- `az role assignment list --scope "$MG_SCOPE" -o table`
- `Get-AzRoleAssignment -Scope $mgScope | Where RoleDefinitionName -eq "Reader"`

---

## Validation
```powershell
pwsh -File learning-paths/lp03-compute-resources/modules/m02-management-groups-subs/validation/validate.ps1 `
  -SubscriptionId $SUBSCRIPTION_ID `
  -WorkloadsManagementGroupName $MG_WORKLOADS `
  -GroupObjectId $GROUP_OBJECT_ID
```
