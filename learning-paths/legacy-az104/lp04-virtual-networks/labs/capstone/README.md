# LP04 Capstone Lab: Enterprise Network Segmentation and Routing

## Difficulty
- Capstone

## Time Estimate
- 4 to 6 hours

## Scenario
Implement segmented enterprise networking with deterministic routing, controlled east-west and north-south paths, and validated inspection controls.

## Objectives
1. Implement hub/spoke segmentation and peering strategy.
2. Enforce route-table and security control boundaries.
3. Validate permitted and denied connectivity flows.
4. Produce rollback-safe network operations documentation.

## Required Deliverables
- architecture-diagram.md
- traffic-flow-matrix.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- incident-drill-results.md
- design-rationale.md
- rollback-plan.md

## Workstream
### Part A - Network Architecture
- Define address plan and subnet boundaries.
- Implement peering and route intent.
- Document inspection and egress strategy.

### Part B - Security and Connectivity Validation
- Validate one approved flow per critical path.
- Validate one prohibited flow per critical boundary.
- Capture evidence for NSG/UDR/DNS behavior.

### Part C - Failure and Recovery Drill
- Simulate routing or connectivity degradation.
- Validate restoration sequence and evidence quality.
- Record lessons learned and prevention controls.

## Acceptance Criteria
- Segmentation and routing model is coherent and testable.
- Allowed and denied traffic behavior is evidenced.
- Recovery drill demonstrates operational control.
- Design rationale explains route and security tradeoffs.
