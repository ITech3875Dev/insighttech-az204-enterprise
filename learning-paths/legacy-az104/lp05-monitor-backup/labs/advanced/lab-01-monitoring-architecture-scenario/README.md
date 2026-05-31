# Advanced Lab 01 - Monitoring and Backup Architecture Scenario

## Difficulty
- Advanced

## Time Estimate
- 90 to 150 minutes

## Scenario
You are designing observability and recovery architecture for enterprise operations with strict incident-response and restoration requirements.

## Architecture Goals
1. Define diagnostics and log ingestion coverage by critical service.
2. Implement actionable alert routing and response integration.
3. Implement backup policy and restore validation evidence.
4. Document operations ownership and rollback controls.

## Constraints
- Use built-in roles where possible.
- Assign at the lowest scope that satisfies requirements.
- All created resources must include required tags.
- Document one break-glass path for emergencies.

## Required Deliverables
- architecture-diagram.md
- monitoring-kpi-summary.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- design-rationale.md
- rollback-plan.md

## Task 1 - Design Monitoring and Recovery Topology
Define:
 - monitoring scopes and data-flow boundaries
 - ownership boundaries and alert ownership model
 - backup policy coverage and restore expectations

Document KPI targets and restore objectives in `monitoring-kpi-summary.md`.

## Task 2 - Implement Monitoring and Backup Baseline
Apply diagnostics, alerts, and backup controls via CLI and PowerShell.

CLI sample:

```bash
az monitor diagnostic-settings create --name <diag-name> --resource <resource-id> --workspace <law-id> --logs '[{"category":"Administrative","enabled":true}]'
az monitor metrics alert create -g <rg> -n <cpu-alert> --scopes <vm-id> --condition "avg Percentage CPU > 80" --window-size 5m --evaluation-frequency 1m --action <action-group-id>
az backup vault create -g <rg> -n <vault-name> --location <location>
```

PowerShell sample:

```powershell
Set-AzDiagnosticSetting -Name <diag-name> -ResourceId <resource-id> -WorkspaceId <law-id> -Enabled $true
Add-AzMetricAlertRuleV2 -Name <cpu-alert> -ResourceGroupName <rg> -WindowSize 00:05:00 -Frequency 00:01:00 -TargetResourceId <vm-id> -Condition (New-AzMetricAlertRuleV2Criteria -MetricName "Percentage CPU" -TimeAggregation Average -Operator GreaterThan -Threshold 80)
```

## Task 3 - Validate Operational Outcomes
Validate one expected-success and one expected-failure operational outcome.

Example matrix:

| Validation | Expected | Evidence file |
|---|---|---|
| Alert and notification path | Success | validation-results.md |
| Non-compliant backup posture | Detected/failed | validation-results.md |

## Task 4 - Add Governance Controls
1. Assign required-tag policy at selected scope.
2. Validate policy impact on test deployment.
3. Record whether policy should be Audit or Deny and why.

## Task 5 - Document Monitoring Operations Pattern
In design-rationale.md include:
- incident response checkpoints
- restore validation procedure
- rollback and revalidation sequence

## Acceptance Criteria
- Role assignments map exactly to requirements
- No day-to-day Owner at subscription scope
- Allowed/denied behavior is demonstrated with evidence
- Governance policy behavior is demonstrated
- Design rationale explains scope decisions and blast-radius control

## Grading Guidance (100 points)
- 30: RBAC design quality
- 20: Implementation correctness
- 20: Validation evidence quality
- 15: Governance control integration
- 15: Rationale and rollback quality

## Submission Checklist
- All required artifacts present
- All command outputs included
- No secrets or credentials in evidence files
- Reviewer can reproduce design intent from documentation only
