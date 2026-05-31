# LP03 Capstone Lab: Compute Operations and Resilience

## Difficulty
- Capstone

## Time Estimate
- 4 to 6 hours

## Scenario
Build a compute platform using VMs/VMSS/App Service patterns with least privilege, availability controls, and operational validation.

## Objectives
1. Design workload placement and scaling strategy.
2. Implement secure administration and runtime access boundaries.
3. Validate availability, patching, and operational readiness.
4. Produce evidence-driven rollback and incident procedures.

## Required Deliverables
- architecture-diagram.md
- compute-placement-matrix.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- incident-drill-results.md
- design-rationale.md
- rollback-plan.md

## Workstream
### Part A - Compute Architecture
- Build workload topology and ownership boundaries.
- Define scaling and availability intent.
- Document access boundaries for operators and applications.

### Part B - Secure Operations
- Apply baseline hardening and patching controls.
- Validate authorized and unauthorized operation paths.
- Record remediation flow for failed checks.

### Part C - Resilience Validation
- Run one fault or degradation simulation.
- Validate recovery behavior and SLO alignment.
- Capture evidence and post-incident notes.

## Acceptance Criteria
- Compute architecture reflects workload and resilience needs.
- Access and operational controls are validated with evidence.
- Incident/recovery simulation demonstrates operational readiness.
- Design rationale explains tradeoffs and containment strategy.
