# PowerShell Lab — M02 Management Groups & Subscriptions (Beginner)

## Variables
```powershell
$SUBSCRIPTION_ID = "<your-subscription-id>"
$MG_ROOT = "mg-az104-root"
$MG_PLATFORM = "mg-az104-platform"
$MG_WORKLOADS = "mg-az104-workloads"
$MG_SANDBOX = "mg-az104-sandbox"
$GROUP_OBJECT_ID = "<entra-group-object-id>"  # az104-rbac-readers
```

## Task 1 — Create management groups (if permitted)
```powershell
Connect-AzAccount
Set-AzContext -Subscription $SUBSCRIPTION_ID

New-AzManagementGroup -GroupName $MG_ROOT
New-AzManagementGroup -GroupName $MG_PLATFORM -ParentId $MG_ROOT
New-AzManagementGroup -GroupName $MG_WORKLOADS -ParentId $MG_ROOT
New-AzManagementGroup -GroupName $MG_SANDBOX -ParentId $MG_ROOT
```

## Task 2 — Move subscription into mg-az104-workloads
```powershell
New-AzManagementGroupSubscription -GroupName $MG_WORKLOADS -SubscriptionId $SUBSCRIPTION_ID
```

## Task 3 — Assign Reader at MG scope
```powershell
$mgScope = "/providers/Microsoft.Management/managementGroups/$MG_WORKLOADS"
New-AzRoleAssignment -ObjectId $GROUP_OBJECT_ID -RoleDefinitionName "Reader" -Scope $mgScope | Out-Null
```

## Verify
```powershell
Get-AzRoleAssignment -Scope $mgScope | Where-Object RoleDefinitionName -eq "Reader"
```
