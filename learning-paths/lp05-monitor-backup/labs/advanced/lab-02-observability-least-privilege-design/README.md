# Advanced Lab 02 — Least Privilege Design Challenge (RBAC)

## Difficulty
- Advanced

## Time Estimate
- 90 to 120 minutes

## Scenario
Design RBAC for a new application team.

### Requirements
- Deploy resources only into: `rg-az104-app-dev-eastus2-01`
- View resources across the subscription
- A small subset can assign roles (only within that RG)
- No subscription-scope Owner assignments

## Objective
Produce a least-privilege RBAC design that is operationally useful and auditable. You must prove that permissions are sufficient for required actions and blocked for non-required actions.

## Required Deliverables
- design-assumptions.md
- role-scope-matrix.md
- implementation-cli.txt
- implementation-pwsh.txt
- validation-allowed-denied.md
- rationale.md
- rollback.md

## Step 1 - Capture Assumptions
In design-assumptions.md include:
1. Team personas (app-dev, app-lead, platform-auditor)
2. Required actions per persona
3. Non-required actions that must be denied

## Step 2 - Build Role/Scope Matrix
Create role-scope-matrix.md with this structure:

| Persona | Role | Scope | Why this role | Why not broader |
|---|---|---|---|---|
| app-dev | Contributor | app RG | deploy app resources | avoids cross-RG changes |
| app-viewer | Reader | subscription | read visibility | no write actions |
| app-lead | User Access Administrator | app RG | delegate within RG only | avoids tenant-wide RBAC risk |

## Step 3 - Implement Assignments

CLI examples:

```bash
SUB_ID="<subscription-id>"
APP_RG_SCOPE="/subscriptions/$SUB_ID/resourceGroups/rg-az104-app-dev-eastus2-01"

az role assignment create --assignee-object-id "<app-dev-group-id>" --assignee-principal-type Group --role Contributor --scope "$APP_RG_SCOPE"
az role assignment create --assignee-object-id "<app-viewer-group-id>" --assignee-principal-type Group --role Reader --scope "/subscriptions/$SUB_ID"
az role assignment create --assignee-object-id "<app-lead-group-id>" --assignee-principal-type Group --role "User Access Administrator" --scope "$APP_RG_SCOPE"
```

PowerShell examples:

```powershell
$SubId = "<subscription-id>"
$AppRgScope = "/subscriptions/$SubId/resourceGroups/rg-az104-app-dev-eastus2-01"

New-AzRoleAssignment -ObjectId "<app-dev-group-id>" -RoleDefinitionName Contributor -Scope $AppRgScope
New-AzRoleAssignment -ObjectId "<app-viewer-group-id>" -RoleDefinitionName Reader -Scope "/subscriptions/$SubId"
New-AzRoleAssignment -ObjectId "<app-lead-group-id>" -RoleDefinitionName "User Access Administrator" -Scope $AppRgScope
```

## Step 4 - Validate Required and Blocked Actions
Complete this table in validation-allowed-denied.md:

| Persona | Test action | Expected | Actual | Evidence |
|---|---|---|---|---|
| app-dev | create storage in app RG | allow | allow | cli output |
| app-dev | create role assignment at subscription | deny | deny | error output |
| app-viewer | read resource inventory | allow | allow | cli output |
| app-viewer | delete resource in app RG | deny | deny | error output |
| app-lead | assign Reader in app RG | allow | allow | cli output |
| app-lead | assign Owner at subscription | deny | deny | error output |

## Step 5 - Write Design Rationale
In rationale.md explain:
1. Why each role was selected
2. Why each scope was selected
3. Blast radius implications if scope were broader
4. Operational trade-offs and residual risks

## Step 6 - Add Rollback Plan
In rollback.md include exact role-assignment delete commands for each assignment.

CLI example:

```bash
az role assignment delete --assignee-object-id "<app-dev-group-id>" --role Contributor --scope "$APP_RG_SCOPE"
```

## Acceptance Criteria
- No Owner created at subscription scope
- Contributor limited to the app RG
- Read-only access confirmed at broader scope

## Scoring Guide (100 points)
- 30: Least-privilege design quality
- 25: Correct implementation
- 25: Validation quality (allowed and denied tests)
- 20: Rationale and rollback quality

## Reviewer Notes
A passing submission must be reproducible and auditable. Evidence should make it possible to verify design intent without direct access to the student environment.
