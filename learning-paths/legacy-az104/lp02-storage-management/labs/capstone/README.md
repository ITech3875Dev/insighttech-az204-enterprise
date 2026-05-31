# LP02 Capstone Lab: Storage Resilience and Data Governance

## Difficulty
- Capstone

## Time Estimate
- 4 to 6 hours

## Scenario
Design and implement a production-ready storage platform with durability, lifecycle controls, immutability, and verified recovery outcomes.

## Objectives
1. Implement tiering and lifecycle strategy aligned to data classes.
2. Enforce secure access patterns (RBAC/SAS/private endpoints where applicable).
3. Validate data protection controls (versioning, soft delete, immutability as required).
4. Produce operational evidence and rollback-safe procedures.

## Required Deliverables
- architecture-diagram.md
- storage-classification-matrix.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- recovery-drill-results.md
- design-rationale.md
- rollback-plan.md

## Workstream
### Part A - Storage Architecture
- Define storage account topology and naming.
- Map workloads to durability and replication choices.
- Document ingress/egress access model and boundaries.

### Part B - Protection and Lifecycle
- Configure lifecycle and retention controls.
- Configure data protection controls for selected containers/shares.
- Record non-compliant behavior and remediation.

### Part C - Recovery and Validation
- Execute restore or recovery simulation.
- Validate one expected-success and one expected-failure operation.
- Capture objective evidence and timestamps.

## Acceptance Criteria
- Architecture aligns to workload durability and access requirements.
- Protection and lifecycle controls are implemented and evidenced.
- Recovery drill is completed with verifiable outcomes.
- Design rationale explains tradeoffs and blast-radius control.
