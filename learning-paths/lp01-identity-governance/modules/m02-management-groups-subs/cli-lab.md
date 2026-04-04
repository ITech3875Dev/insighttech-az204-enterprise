# Az CLI Lab — M02 Management Groups & Subscriptions (Beginner)

## Variables
```bash
export SUBSCRIPTION_ID="<your-subscription-id>"
export MG_ROOT="mg-az104-root"
export MG_PLATFORM="mg-az104-platform"
export MG_WORKLOADS="mg-az104-workloads"
export MG_SANDBOX="mg-az104-sandbox"
export GROUP_OBJECT_ID="<entra-group-object-id>"   # az104-rbac-readers
```

## Task 1 — Create management groups (if permitted)
```bash
az login
az account show --query "{subscription:id,tenantId:tenantId,user:user}" -o jsonc

az account management-group create --name "$MG_ROOT"
az account management-group create --name "$MG_PLATFORM" --parent "$MG_ROOT"
az account management-group create --name "$MG_WORKLOADS" --parent "$MG_ROOT"
az account management-group create --name "$MG_SANDBOX" --parent "$MG_ROOT"
```

## Task 2 — Move subscription into mg-az104-workloads
```bash
az account management-group subscription add --name "$MG_WORKLOADS" --subscription "$SUBSCRIPTION_ID"
```

## Task 3 — Assign Reader at management group scope
```bash
MG_SCOPE="/providers/Microsoft.Management/managementGroups/${MG_WORKLOADS}"

az role assignment create   --assignee-object-id "$GROUP_OBJECT_ID"   --assignee-principal-type Group   --role "Reader"   --scope "$MG_SCOPE"   -o table
```

## Verify
```bash
az account management-group show --name "$MG_WORKLOADS" -o jsonc
az role assignment list --scope "$MG_SCOPE" -o table
```
