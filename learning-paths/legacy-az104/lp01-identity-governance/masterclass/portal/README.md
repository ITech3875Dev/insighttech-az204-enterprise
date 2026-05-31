# Portal Masterclass — LP01

## Purpose
Master governance operations in Azure Portal with deliberate scope selection, verification discipline, and audit-grade evidence capture.

## Time Estimate
- 75 to 105 minutes

## Prerequisites
- Access to non-production subscription
- Permission to view and assign RBAC at RG scope
- Permission to assign policy at RG or subscription scope

## Learning Outcomes
1. Choose correct scope for RBAC and policy tasks
2. Verify behavior with explicit positive and negative tests
3. Capture clear evidence for instructor or reviewer validation

## Focus Areas
- Correct scope selection (management group, subscription, resource group)
- Evidence capture and verification
- Troubleshooting without guessing

## Drill 1 - RBAC Scope Precision

Goal: Assign Reader at RG scope and verify access boundaries.

Steps:
1. Open target resource group.
2. Go to Access control (IAM) -> Role assignments -> Add role assignment.
3. Assign Reader to test principal at RG scope.
4. Test with the same principal:
	- Allowed: view RG resources
	- Denied: create resource in RG

Evidence:
- Screenshot of role assignment details
- Screenshot of denied create operation

## Drill 2 - Policy Audit-to-Deny Progression

Goal: apply guardrails safely using staged enforcement.

Steps:
1. Assign required-tag policy at a controlled scope with effect set to Audit.
2. Create or identify non-compliant resource and confirm audit finding.
3. Change effect to Deny in same controlled scope.
4. Attempt non-compliant deployment and verify it is blocked.
5. Correct deployment and verify success.

Evidence:
- Screenshot of policy assignment and parameters
- Screenshot of compliance state before and after
- Screenshot of denied operation error

## Drill 3 - Cost and Tag Governance Verification

Goal: prove that tagging standards support cost analysis.

Steps:
1. Open Cost Management -> Cost analysis.
2. Group by tag (CostCenter or Workload).
3. Filter to target resource group.
4. Export report data.

Evidence:
- Screenshot of grouped cost view
- Exported file in evidence folder

## Drill 4 - Troubleshooting Decision Tree

For each issue, document symptom, probable cause, validation, and fix:
1. Access denied unexpectedly
2. Policy not triggering
3. Cost data missing expected resources

Create `portal-troubleshooting-notes.md` with this table:

| Symptom | Scope checked | Root cause | Fix applied | Re-test result |
|---|---|---|---|---|

## Required Deliverables
- `evidence/portal-rbac-assignment.png`
- `evidence/portal-rbac-denied-action.png`
- `evidence/portal-policy-assignment.png`
- `evidence/portal-policy-deny.png`
- `evidence/portal-cost-tag-view.png`
- `evidence/portal-cost-export.csv`
- `portal-troubleshooting-notes.md`

## Acceptance Criteria
- All three drills completed with clear scope choices
- Positive and negative behavior validated
- Evidence artifacts are complete and timestamped
- Troubleshooting notes contain root cause and fix validation

## Troubleshooting Tips
- If policy appears inactive, verify assignment scope and effect parameter
- If denied action is not reproduced, re-check principal context and RBAC propagation delay
- If cost views are empty, verify data latency window and filter settings
