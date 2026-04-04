# Intermediate Lab 03 - Operational Recovery and Validation Operations

## Time Estimate
- 60 to 90 minutes

## Safety Guardrail
- Use non-production scope only.
- Remove elevated access before ending the lab.

## Scenario
During an outage, your standard admin account cannot authenticate because of MFA or conditional access changes. You must run an emergency-access process with clear approvals, temporary elevation, and complete auditing.

## Objective
Simulate a full operational recovery workflow safely:
1. Build and document a runbook
2. Grant temporary access at minimum scope
3. Execute one authorized action
4. Revoke access
5. Capture audit evidence and conclusions

## Prerequisites
- Owner or User Access Administrator rights at target scope
- Access to Azure Activity Log
- Azure CLI and PowerShell Az installed

## Variables

```bash
SUB_ID="<subscription-id>"
TARGET_SCOPE="/subscriptions/<subscription-id>/resourceGroups/rg-az104-opsrecovery-dev-eastus2-01"
OPS_RECOVERY_GROUP="az104-opsrecovery-ops"
```

```powershell
$SubscriptionId = "<subscription-id>"
$TargetScope = "/subscriptions/<subscription-id>/resourceGroups/rg-az104-opsrecovery-dev-eastus2-01"
$BreakGlassGroup = "az104-opsrecovery-ops"
```

## Step 1 - Author the Operational Runbook
Create runbook-operations-recovery.md with these sections:
- Preconditions
- Trigger criteria
- Approval chain and separation of duties
- Grant workflow
- Validation workflow
- Revoke workflow
- Post-incident review

Minimum required controls:
- Approval SLA defined
- Max elevation duration defined
- Explicit rollback step

## Step 2 - Capture Baseline

### Azure CLI
```bash
az account set --subscription "$SUB_ID"

az role assignment list --scope "$TARGET_SCOPE" -o json > evidence-opsrecovery-baseline.json
```

### PowerShell
```powershell
Select-AzSubscription -SubscriptionId $SubscriptionId
Get-AzRoleAssignment -Scope $TargetScope | ConvertTo-Json -Depth 8 | Out-File evidence-opsrecovery-baseline-pwsh.json
```

## Step 3 - Create or Locate Emergency Principal

### Azure CLI
```bash
az ad group create --display-name "$OPS_RECOVERY_GROUP" --mail-nickname "$OPS_RECOVERY_GROUP"
OPS_RECOVERY_GROUP_ID=$(az ad group show --group "$OPS_RECOVERY_GROUP" --query id -o tsv)
echo "$OPS_RECOVERY_GROUP_ID" > evidence-opsrecovery-group-id.txt
```

### PowerShell
```powershell
$bg = Get-AzADGroup -DisplayName $BreakGlassGroup -ErrorAction SilentlyContinue
if (-not $bg) { $bg = New-AzADGroup -DisplayName $BreakGlassGroup -MailNickname $BreakGlassGroup }
$bg.Id | Out-File evidence-opsrecovery-group-id-pwsh.txt
```

## Step 4 - Grant Temporary Access

### Azure CLI
```bash
az role assignment create \
  --assignee-object-id "$OPS_RECOVERY_GROUP_ID" \
  --assignee-principal-type Group \
  --role Contributor \
  --scope "$TARGET_SCOPE"

date -u > evidence-grant-time-utc.txt
az role assignment list --scope "$TARGET_SCOPE" -o table > evidence-grant-role-table.txt
```

### PowerShell
```powershell
New-AzRoleAssignment -ObjectId $bg.Id -RoleDefinitionName Contributor -Scope $TargetScope
Get-Date -AsUTC | Out-File evidence-grant-time-utc-pwsh.txt
```

## Step 5 - Perform One Authorized Incident Action
Run one low-risk action at target scope, for example updating a non-critical tag.

CLI example:

```bash
RG_NAME="rg-az104-opsrecovery-dev-eastus2-01"
az group update --name "$RG_NAME" --set tags.OpsRecoveryTest="true" > evidence-incident-action.json
```

## Step 6 - Revoke Temporary Access

### Azure CLI
```bash
az role assignment delete \
  --assignee-object-id "$OPS_RECOVERY_GROUP_ID" \
  --role Contributor \
  --scope "$TARGET_SCOPE"

date -u > evidence-revoke-time-utc.txt
az role assignment list --scope "$TARGET_SCOPE" -o table > evidence-revoke-role-table.txt
```

### PowerShell
```powershell
Remove-AzRoleAssignment -ObjectId $bg.Id -RoleDefinitionName Contributor -Scope $TargetScope
Get-Date -AsUTC | Out-File evidence-revoke-time-utc-pwsh.txt
```

## Step 7 - Collect and Summarize Activity Log Evidence

```bash
az monitor activity-log list --offset 2h --status Succeeded --max-events 200 --output json > evidence-activity-log.json
```

Create evidence-activity-summary.md and identify:
- grant event
- incident action event
- revoke event

## Required Deliverables
- A runbook documenting:
  - Preconditions (MFA/strong password/monitoring)
  - Trigger criteria
  - Approval workflow (separation of duties)
  - Simulated steps and rollback
- Evidence:
  - Activity log query evidence (Portal + CLI)

## Acceptance Criteria
- Break-glass runbook is complete and specific
- Temporary elevation was granted and revoked successfully
- Activity log confirms grant, action, and revoke events
- No standing elevated assignment remains

## Troubleshooting
- Missing log events: increase query window to 4 hours
- Delete fails: verify principal ID and exact scope used for assignment
- Authorization errors: ensure role-assignment rights at target scope
