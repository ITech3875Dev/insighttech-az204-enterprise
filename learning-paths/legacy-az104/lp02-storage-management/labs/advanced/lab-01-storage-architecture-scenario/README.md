# Advanced Lab 01 - Storage Architecture Scenario

## Difficulty
- Advanced

## Time Estimate
- 90 to 150 minutes

## Scenario
You are the platform architect for a multi-team organization. Build a storage architecture that enforces durability, data protection, and controlled data access while remaining operationally efficient.

## Architecture Goals
1. Separate shared platform storage from application storage by scope.
2. Enforce secure transfer, TLS baseline, and public access restrictions.
3. Implement lifecycle and recovery controls (versioning, soft delete, retention).
4. Produce repeatable evidence for compliance and operations review.

## Required Deliverables
- architecture-diagram.md
- storage-access-matrix.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- design-rationale.md
- rollback-plan.md

## Task 1 - Design Storage Topology
Define:
- storage accounts by workload and data class
- ownership boundaries by resource group
- required access paths (private endpoint or restricted public path)

## Task 2 - Implement Security and Protection Baseline
Apply with CLI and PowerShell:
- secure transfer required
- minimum TLS version
- blob versioning and soft delete
- lifecycle management for stale data

## Task 3 - Validate Allowed and Denied Behavior
Run one allowed and one denied test for each required access path.

Example matrix:

| Validation | Expected | Evidence |
|---|---|---|
| Authorized private access | Success | validation-results.md |
| Unauthorized public access | Denied | validation-results.md |

## Task 4 - Add Governance Controls
1. Apply tag and storage-related policy controls.
2. Validate policy impact with a test deployment.
3. Record audit vs deny recommendation with rationale.

## Task 5 - Document Operations Pattern
In design-rationale.md include:
- ownership handoff model
- incident response checkpoints for storage failures
- rollback and revalidation sequence

## Acceptance Criteria
- Storage architecture matches business and durability requirements.
- Security and data protection controls are enabled and verified.
- Validation proves both expected success and expected denial behavior.
- Documentation is complete and reproducible for reviewer verification.
