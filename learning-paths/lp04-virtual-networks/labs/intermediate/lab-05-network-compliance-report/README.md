# Intermediate Lab 05 — Tagging Compliance Reporting

## Time Estimate
- 45 to 75 minutes

## Prerequisites
- At least two resource groups in subscription
- Some resources intentionally missing one or more required tags
- Bash and PowerShell available

## Objective
Generate an audit-friendly tag compliance report for resource groups.

## Required Tags
- Owner
- CostCenter
- Environment
- Workload
- DataClass
- ExpirationDate

## Tasks
1. Run PowerShell report:
   - `shared/scripts/pwsh/validation/tag-compliance-report.ps1`
2. Run CLI report:
   - `shared/scripts/cli/validation/tag-compliance-report.sh`
3. Attach outputs (CSV + JSON) to PR evidence

## Step 1 - Execute PowerShell Report

```powershell
$SubscriptionId = "<subscription-id>"
Select-AzSubscription -SubscriptionId $SubscriptionId

pwsh shared/scripts/pwsh/validation/tag-compliance-report.ps1 \
  -SubscriptionId $SubscriptionId
```

Expected outputs:
- tag-compliance-report.csv
- tag-compliance-report.json

## Step 2 - Execute CLI Report

```bash
SUB_ID="<subscription-id>"
az account set --subscription "$SUB_ID"

chmod +x shared/scripts/cli/validation/tag-compliance-report.sh
shared/scripts/cli/validation/tag-compliance-report.sh "$SUB_ID"
```

Expected outputs:
- tag-compliance-report-cli.csv
- tag-compliance-report-cli.json

## Step 3 - Validate Output Quality

Check that each report includes:
- resource identifier
- missing tags list
- compliance status
- recommended remediation

Quick checks:

```bash
head -n 5 tag-compliance-report.csv
jq '.[0]' tag-compliance-report.json
```

## Step 4 - Reconcile Differences Between CLI and PowerShell Reports
Create report-diff-summary.md describing:
1. Count of resources scanned by each script
2. Count of non-compliant resources in each output
3. Any parsing or scope differences
4. Final source of truth and reason

## Step 5 - Create Remediation Plan
Create remediation-plan.md with:
- top 5 non-compliant resources by risk
- tags to add
- owner assignment
- due date
- verification command

Example remediation command:

```bash
RESOURCE_ID="<resource-id>"
az tag update --resource-id "$RESOURCE_ID" --operation merge --tags Owner="team-a" CostCenter="IT-104" Environment="dev" Workload="identity" DataClass="internal" ExpirationDate="2026-12-31"
```

## Acceptance Criteria
- Report files generated
- Non-compliance correctly flagged
- Short remediation plan included

## Required Deliverables
- tag-compliance-report.csv
- tag-compliance-report.json
- tag-compliance-report-cli.csv
- tag-compliance-report-cli.json
- report-diff-summary.md
- remediation-plan.md

## Troubleshooting
- Empty report: verify subscription context and permissions
- Permission denied running script: run chmod +x for CLI script
- JSON parse errors: ensure jq is installed or inspect raw JSON directly
