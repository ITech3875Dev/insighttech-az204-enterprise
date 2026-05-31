# Advanced Lab 01 - Compute Architecture Scenario

## Difficulty
- Advanced

## Time Estimate
- 90 to 150 minutes

## Scenario
You are the platform architect for a multi-team organization. Build compute architecture that balances availability, security boundaries, and operational readiness.

## Architecture Goals
1. Define workload placement across VM/VMSS/App Service tiers.
2. Enforce least-privilege administrative and runtime access.
3. Validate availability strategy and operational health signals.
4. Capture rollback-safe implementation and incident handling notes.

## Required Deliverables
- architecture-diagram.md
- compute-ops-checklist.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- design-rationale.md
- rollback-plan.md

## Task 1 - Design Compute Topology and Scope Model
Define:
- workload placement and scaling intent
- resource group ownership boundaries
- access control model for operations

## Task 2 - Implement Compute Baseline
Deploy compute resources and baseline controls using CLI and PowerShell.

## Task 3 - Validate Operational Behavior
Run one expected-success and one expected-failure test for critical operations.

Example matrix:

| Validation | Expected | Evidence file |
|---|---|---|
| Authorized compute operation | Success | validation-results.md |
| Unauthorized admin/runtime action | Denied | validation-results.md |

## Task 4 - Add Governance Controls
1. Assign required-tag policy at selected scope.
2. Validate policy impact on test deployment.
3. Record whether policy should be Audit or Deny and why.

## Task 5 - Document Compute Operations Pattern
In design-rationale.md include:
- incident response checkpoints
- rollback-safe change procedure
- post-change validation sequence

## Acceptance Criteria
- Compute architecture aligns to workload requirements.
- Access and resilience controls are validated with evidence.
- Expected success and expected denial behavior are demonstrated.
- Design rationale explains decisions and blast-radius control.

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
