# Intermediate Lab 01 - Identity Operations Runbook

## Purpose
This lab converts M01 foundations into operational identity work. You will perform group lifecycle, RBAC review, and access validation using repeatable commands and evidence artifacts.

## Time Estimate
- 60 to 90 minutes

## Prerequisites
- Completed beginner Lab 01
- Non-production subscription access
- Role to assign RBAC (Owner or User Access Administrator)
- Azure CLI and PowerShell Az installed

## Scenario
The platform team needs an operations-ready access model for an application resource group. You must:
1. Create and maintain an operations group
2. Assign least-privilege RBAC at resource group scope
3. Validate that allowed and denied actions match design intent
4. Produce evidence for audit and handoff

## Variables
Use these values in all steps.

```bash
SUB_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az104-idops-dev-eastus2-01"
OPS_GROUP_NAME="az104-idops-rg-contributors"
READER_GROUP_NAME="az104-idops-rg-readers"
```

```powershell
$SubscriptionId = "<subscription-id>"
$Location = "eastus2"
$RgName = "rg-az104-idops-dev-eastus2-01"
$OpsGroupName = "az104-idops-rg-contributors"
$ReaderGroupName = "az104-idops-rg-readers"
```

## Task 1 - Set Context and Create Baseline Resource Group

### Azure CLI
```bash
az account set --subscription "$SUB_ID"

az group create \
	--name "$RG_NAME" \
	--location "$LOCATION" \
	--tags Owner="student" CostCenter="IT-104" Environment="dev" Workload="identity-ops" DataClass="internal" ExpirationDate="2026-12-31"
```

### PowerShell
```powershell
Select-AzSubscription -SubscriptionId $SubscriptionId

New-AzResourceGroup \
	-Name $RgName \
	-Location $Location \
	-Tag @{
		Owner = "student"
		CostCenter = "IT-104"
		Environment = "dev"
		Workload = "identity-ops"
		DataClass = "internal"
		ExpirationDate = "2026-12-31"
	}
```

## Task 2 - Create or Locate Entra Security Groups

### Azure CLI
```bash
az ad group create --display-name "$OPS_GROUP_NAME" --mail-nickname "$OPS_GROUP_NAME"
az ad group create --display-name "$READER_GROUP_NAME" --mail-nickname "$READER_GROUP_NAME"

OPS_GROUP_ID=$(az ad group show --group "$OPS_GROUP_NAME" --query id -o tsv)
READER_GROUP_ID=$(az ad group show --group "$READER_GROUP_NAME" --query id -o tsv)
echo "$OPS_GROUP_ID"
echo "$READER_GROUP_ID"
```

### PowerShell
```powershell
$opsGroup = Get-AzADGroup -DisplayName $OpsGroupName -ErrorAction SilentlyContinue
if (-not $opsGroup) { $opsGroup = New-AzADGroup -DisplayName $OpsGroupName -MailNickname $OpsGroupName }

$readerGroup = Get-AzADGroup -DisplayName $ReaderGroupName -ErrorAction SilentlyContinue
if (-not $readerGroup) { $readerGroup = New-AzADGroup -DisplayName $ReaderGroupName -MailNickname $ReaderGroupName }

$opsGroup.Id
$readerGroup.Id
```

## Task 3 - Assign RBAC at Resource Group Scope

### Azure CLI
```bash
RG_SCOPE=$(az group show --name "$RG_NAME" --query id -o tsv)

az role assignment create --assignee-object-id "$OPS_GROUP_ID" --assignee-principal-type Group --role Contributor --scope "$RG_SCOPE"
az role assignment create --assignee-object-id "$READER_GROUP_ID" --assignee-principal-type Group --role Reader --scope "$RG_SCOPE"
```

### PowerShell
```powershell
$rgScope = (Get-AzResourceGroup -Name $RgName).ResourceId

New-AzRoleAssignment -ObjectId $opsGroup.Id -RoleDefinitionName Contributor -Scope $rgScope
New-AzRoleAssignment -ObjectId $readerGroup.Id -RoleDefinitionName Reader -Scope $rgScope
```

## Task 4 - Validate Effective Access

1. List role assignments at RG scope.
2. Confirm there are no subscription-scope Owner assignments for these groups.
3. Document one allowed action and one denied action for each role profile.

### Azure CLI checks
```bash
az role assignment list --scope "$RG_SCOPE" --query "[].{principal:principalName,role:roleDefinitionName,scope:scope}" -o table

az role assignment list --scope "/subscriptions/$SUB_ID" \
	--query "[?contains(principalName, '$OPS_GROUP_NAME') || contains(principalName, '$READER_GROUP_NAME')].[principalName,roleDefinitionName,scope]" -o table
```

### Suggested allowed and denied tests
- Contributor group member: can create storage account in target RG
- Reader group member: cannot create storage account in target RG

## Task 5 - Produce Evidence Package
Create these files in your branch under this lab folder:
- evidence-rg.json: output of resource group show
- evidence-rbac-table.txt: role assignment output
- evidence-access-tests.md: allowed and denied behavior with timestamps
- root-cause-and-prevention.md: short ops note on why RG-scope assignment is safer than subscription-scope assignment

## Acceptance Criteria
- Resource group exists with required tags
- Two groups exist and are role-assigned at RG scope
- Role assignments are visible via CLI and PowerShell
- Allowed and denied action tests are documented
- Evidence files are complete and readable

## Troubleshooting

### Group creation fails
- Cause: insufficient Entra permissions
- Fix: ask instructor to pre-create groups and provide Object IDs

### Role assignment fails with authorization error
- Cause: account lacks Owner or User Access Administrator at target scope
- Fix: request temporary elevation or instructor-assisted assignment

### Role assignment appears delayed
- Cause: RBAC propagation delay
- Fix: wait 5 to 10 minutes and retry query
