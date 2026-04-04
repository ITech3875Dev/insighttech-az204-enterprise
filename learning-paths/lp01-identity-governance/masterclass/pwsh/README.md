# PowerShell Masterclass — LP01 (Identity & Governance)

## Purpose
Run LP01 governance operations with PowerShell-first workflows that are scriptable, auditable, and easy to automate.

## Time Estimate
- 90 to 120 minutes

## Prerequisites
- PowerShell 7+ recommended
- Az modules installed
- Access to non-production subscription

## Learning Outcomes
1. Export and analyze RBAC assignments by scope and principal
2. Inventory policy assignments and compliance posture
3. Triage Advisor and budget data for governance insights
4. Create reusable evidence artifacts for PR submission

## Setup

```powershell
New-Item -ItemType Directory -Force -Path ./out | Out-Null

$sub = "<subId>"
Set-AzContext -Subscription $sub
Get-AzContext | Format-List Account, Subscription, Tenant
```

## Exercise 1 - RBAC Inventory

```powershell
Get-AzRoleAssignment -Scope "/subscriptions/$sub" |
	Select-Object DisplayName, SignInName, RoleDefinitionName, Scope |
	Export-Csv -NoTypeInformation ./out/rbac-assignments-subscription.csv
```

Principal-centric lookup:

```powershell
$principalObjectId = "<objectId>"
Get-AzRoleAssignment -ObjectId $principalObjectId |
	Select-Object DisplayName, RoleDefinitionName, Scope |
	Export-Csv -NoTypeInformation ./out/rbac-principal.csv
```

## Exercise 2 - Policy Assignment and Compliance Snapshot

```powershell
Get-AzPolicyAssignment -Scope "/subscriptions/$sub" |
	Select-Object Name, DisplayName, Scope, EnforcementMode |
	Export-Csv -NoTypeInformation ./out/policy-assignments.csv

Get-AzPolicyStateSummary -SubscriptionId $sub |
	ConvertTo-Json -Depth 8 |
	Out-File ./out/policy-state-summary.json
```

## Exercise 3 - Policy Exemptions and Lock Inventory

```powershell
Get-AzPolicyExemption -Scope "/subscriptions/$sub" -ErrorAction SilentlyContinue |
	Select-Object Name, Scope, ExemptionCategory, ExpiresOn |
	Export-Csv -NoTypeInformation ./out/policy-exemptions.csv

Get-AzResourceLock |
	Select-Object Name, Level, ResourceGroupName, ResourceName |
	Export-Csv -NoTypeInformation ./out/locks.csv
```

## Exercise 4 - Advisor and Cost Governance Triage

```powershell
Get-AzAdvisorRecommendation |
	Select-Object Category, Impact, ShortDescription, ResourceId |
	Export-Csv -NoTypeInformation ./out/advisor-recommendations.csv

Get-AzAdvisorRecommendation |
	Group-Object Category |
	Sort-Object Count -Descending |
	Export-Csv -NoTypeInformation ./out/advisor-summary-by-category.csv
```

If cost cmdlets are unavailable in your environment, document the limitation in `./out/cost-command-note.txt` and include CLI budget evidence from the CLI masterclass track.

## Exercise 5 - Write Operational Findings
Create `./out/pwsh-analysis-summary.md` with:
1. Top 3 RBAC risk observations
2. Top 3 policy/compliance observations
3. Top 3 advisor or optimization actions
4. One rollback-safe remediation recommendation per finding

## Required Deliverables
- `./out/rbac-assignments-subscription.csv`
- `./out/rbac-principal.csv`
- `./out/policy-assignments.csv`
- `./out/policy-state-summary.json`
- `./out/policy-exemptions.csv` (or note file if none)
- `./out/locks.csv`
- `./out/advisor-recommendations.csv`
- `./out/pwsh-analysis-summary.md`

## Acceptance Criteria
- Exports are generated and readable
- Findings are specific and actionable
- Evidence is traceable to subscription scope used
- No secrets are present in output files

## Troubleshooting
- Missing cmdlets: install/update Az modules
- Empty outputs: verify scope and permissions
- Access denied: confirm role at subscription or target RG scope
