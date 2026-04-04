# Beginner Lab 01 — Identity Foundations (Users, Groups, RBAC)

**Track:** Beginner  
**Learning Path:** LP04 — Configure and manage virtual networks for Azure administrators  
**Module Coverage:** M01

## Goal
You will:
1) Set subscription context (Portal + CLI + PowerShell)  
2) Create a resource group with enterprise naming + required tags  
3) Create (or be provided) an Entra security group  
4) Assign **Reader** role to the group at **RG scope**  
5) Verify in Portal + CLI + PowerShell  
6) Run validation (PASS/FAIL)

---

## Variables (Set these first)

### Azure CLI (bash/zsh)
```bash
export SUBSCRIPTION_ID="<your-subscription-id>"
export LOCATION="eastus2"
export ENV="dev"
export WORKLOAD="az104"
export RG_NAME="rg-${WORKLOAD}-idgov-${ENV}-${LOCATION}-01"

# Required tags
export TAG_Owner="student01"
export TAG_CostCenter="training"
export TAG_Environment="${ENV}"
export TAG_Workload="${WORKLOAD}"
export TAG_DataClass="training"
export TAG_ExpirationDate="2026-12-31"

# Entra group
export GROUP_NAME="az104-rbac-readers"
export GROUP_OBJECT_ID="<paste-group-object-id>"
```

### PowerShell
```powershell
$SUBSCRIPTION_ID = "<your-subscription-id>"
$LOCATION = "eastus2"
$ENV = "dev"
$WORKLOAD = "az104"
$RG_NAME = "rg-$WORKLOAD-idgov-$ENV-$LOCATION-01"
$GROUP_OBJECT_ID = "<paste-group-object-id>"

$Tags = @{
  Owner="student01"
  CostCenter="training"
  Environment=$ENV
  Workload=$WORKLOAD
  DataClass="training"
  ExpirationDate="2026-12-31"
}
```

---

# Task 1 — Set subscription context

## Portal
1. Open Azure Portal
2. Search **Subscriptions**
3. Click your lab subscription and confirm it is correct

## Azure CLI
```bash
az login
az account set --subscription "$SUBSCRIPTION_ID"
az account show --query "{name:name,id:id}" -o table
```

## PowerShell
```powershell
Connect-AzAccount
Set-AzContext -Subscription $SUBSCRIPTION_ID
Get-AzContext | Select-Object Subscription, Tenant
```

**Verify**
- Subscription name/ID matches your lab subscription.

---

# Task 2 — Create the resource group (naming + tags)

## Portal
1. Search **Resource groups** → **Create**
2. Name: `rg-az104-idgov-dev-eastus2-01`
3. Region: **East US 2**
4. Tags: add the required tags (Owner, CostCenter, Environment, Workload, DataClass, ExpirationDate)
5. **Review + create** → **Create**

## Azure CLI
```bash
az group create   --name "$RG_NAME"   --location "$LOCATION"   --tags     Owner="$TAG_Owner"     CostCenter="$TAG_CostCenter"     Environment="$TAG_Environment"     Workload="$TAG_Workload"     DataClass="$TAG_DataClass"     ExpirationDate="$TAG_ExpirationDate"   -o table
```

## PowerShell
```powershell
New-AzResourceGroup -Name $RG_NAME -Location $LOCATION -Tag $Tags | Out-Null
Get-AzResourceGroup -Name $RG_NAME | Select-Object ResourceGroupName, Location, Tags
```

**Verify**
- Portal: Tags visible on the RG
- CLI: `az group show --name "$RG_NAME" --query tags -o jsonc`

---

# Task 3 — Create Entra security group (or use instructor-provided object ID)

## Portal
1. Search **Microsoft Entra ID**
2. Groups → **New group**
3. Type: Security
4. Name: `az104-rbac-readers`
5. Create and copy **Object ID** → paste into `GROUP_OBJECT_ID`

## Azure CLI (if permitted)
```bash
az ad group create --display-name "$GROUP_NAME" --mail-nickname "$GROUP_NAME" 1>/dev/null
export GROUP_OBJECT_ID=$(az ad group show --group "$GROUP_NAME" --query id -o tsv)
echo "GROUP_OBJECT_ID=$GROUP_OBJECT_ID"
```

---

# Task 4 — Assign Reader at RG scope

## Portal
1. Open RG → **Access control (IAM)**
2. Add role assignment → **Reader**
3. Select group `az104-rbac-readers`
4. Review + assign (wait 1–3 minutes)

## Azure CLI
```bash
SCOPE="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RG_NAME}"

az role assignment create   --assignee-object-id "$GROUP_OBJECT_ID"   --assignee-principal-type Group   --role "Reader"   --scope "$SCOPE"   -o table
```

## PowerShell
```powershell
$scope = "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RG_NAME"
New-AzRoleAssignment -ObjectId $GROUP_OBJECT_ID -RoleDefinitionName "Reader" -Scope $scope | Out-Null
```

**Verify**
- CLI: `az role assignment list --scope "$SCOPE" -o table`
- PowerShell: `Get-AzRoleAssignment -Scope $scope | Where-Object RoleDefinitionName -eq "Reader"`

---

# Task 5 — Run validation (required)

```powershell
pwsh -File learning-paths/lp04-virtual-networks/modules/m01-users-groups-rbac/validation/validate.ps1 `
  -SubscriptionId $SUBSCRIPTION_ID `
  -ResourceGroupName $RG_NAME `
  -GroupObjectId $GROUP_OBJECT_ID
```

**Expected**
- PASS: Resource group exists
- PASS: Required tags present
- PASS: Reader role assignment present
