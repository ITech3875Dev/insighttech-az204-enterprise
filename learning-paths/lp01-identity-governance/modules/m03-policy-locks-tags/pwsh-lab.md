# PowerShell Lab — M03 Policy, Locks, Tags (Beginner)

## Variables
```powershell
$SUBSCRIPTION_ID="<your-subscription-id>"
$RG="rg-az104-idgov-dev-eastus2-01"
$PolicyName="require-env-tag-rg"
$AssignmentName="assign-require-env-tag-audit"
$Effect="Audit"   # change to Deny for enforcement test in TEST scope
```

## 1) Create custom policy definition (from JSON)
```powershell
Connect-AzAccount
Set-AzContext -Subscription $SUBSCRIPTION_ID

$rulesPath = "learning-paths/lp01-identity-governance/modules/m03-policy-locks-tags/code/policy/require-environment-tag.json"
$rulesJson = Get-Content $rulesPath -Raw | ConvertFrom-Json

New-AzPolicyDefinition -Name $PolicyName -Policy $rulesJson.properties.policyRule -Parameter $rulesJson.properties.parameters -Mode All `
  -DisplayName $rulesJson.properties.displayName -Description $rulesJson.properties.description | Out-Null
```

## 2) Assign policy at subscription scope
```powershell
$scope="/subscriptions/$SUBSCRIPTION_ID"
New-AzPolicyAssignment -Name $AssignmentName -PolicyDefinition (Get-AzPolicyDefinition -Name $PolicyName) -Scope $scope `
  -PolicyParameterObject @{ effect = $Effect } | Out-Null
```

## 3) Allowed locations (built-in policy definition ID)
```powershell
$allowedLocationsPolicyId = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
New-AzPolicyAssignment -Name "assign-allowed-locations" -PolicyDefinitionId $allowedLocationsPolicyId -Scope $scope `
  -PolicyParameterObject @{ listOfAllowedLocations = @("eastus2") } | Out-Null
```

## 4) CanNotDelete lock
```powershell
New-AzResourceLock -LockLevel CanNotDelete -LockName "lock-rg-cannotdelete" -ResourceGroupName $RG | Out-Null
Get-AzResourceLock -ResourceGroupName $RG | Select Name, LockLevel
```

## Tag compliance report
```powershell
pwsh -File shared/scripts/pwsh/validation/tag-compliance-report.ps1 -SubscriptionId $SUBSCRIPTION_ID -OutputFolder "./out"
```
