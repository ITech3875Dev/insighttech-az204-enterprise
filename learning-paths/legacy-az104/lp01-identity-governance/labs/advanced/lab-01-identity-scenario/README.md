# Advanced Lab 01 - Identity Governance Architecture Scenario

## Difficulty
- Advanced

## Time Estimate
- 90 to 150 minutes

## Scenario
You are the Azure governance lead for a multi-team organization. You must design an identity and governance model that meets security, operations, and audit requirements without over-privileging users.

## Business Requirements
1. Team Platform must deploy and manage resources in the shared platform RG only.
2. Team App must deploy app resources in one app RG only.
3. Finance must read cost and inventory data subscription-wide.
4. Security must read all policy and RBAC assignments subscription-wide.
5. No subscription-scope Owner assignment is allowed for day-to-day roles.

## Constraints
- Use built-in roles where possible.
- Assign at the lowest scope that satisfies requirements.
- All created resources must include required tags.
- Document one break-glass path for emergencies.

## Required Deliverables
- architecture-diagram.md
- rbac-design-table.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- design-rationale.md
- rollback-plan.md

## Task 1 - Design Topology and Scope Model
Define:
- management group or subscription scope used
- resource groups and ownership boundaries
- role assignments by team

Use this template in rbac-design-table.md:

| Team | Role | Scope | Reason | Risk if broader |
|---|---|---|---|---|
| Platform | Contributor | RG shared | deploy shared infra | broad change risk |

## Task 2 - Implement RBAC Design
Apply assignments via CLI and PowerShell.

CLI sample:

```bash
az role assignment create --assignee-object-id "<platform-group-id>" --assignee-principal-type Group --role Contributor --scope "/subscriptions/<sub-id>/resourceGroups/rg-shared"
az role assignment create --assignee-object-id "<app-group-id>" --assignee-principal-type Group --role Contributor --scope "/subscriptions/<sub-id>/resourceGroups/rg-app"
az role assignment create --assignee-object-id "<finance-group-id>" --assignee-principal-type Group --role Reader --scope "/subscriptions/<sub-id>"
```

PowerShell sample:

```powershell
New-AzRoleAssignment -ObjectId "<security-group-id>" -RoleDefinitionName Reader -Scope "/subscriptions/<sub-id>"
```

## Task 3 - Validate Allowed and Denied Actions
For each team, run one allowed test and one denied test.

Example matrix:

| Team | Allowed action | Denied action | Evidence file |
|---|---|---|---|
| App | create resource in rg-app | create resource in rg-shared | validation-results.md |

## Task 4 - Add Governance Controls
1. Assign required-tag policy at selected scope.
2. Validate policy impact on test deployment.
3. Record whether policy should be Audit or Deny and why.

## Task 5 - Document Break-Glass Pattern
In design-rationale.md include:
- who approves elevation
- max elevation duration
- minimum emergency scope
- rollback and audit requirements

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
