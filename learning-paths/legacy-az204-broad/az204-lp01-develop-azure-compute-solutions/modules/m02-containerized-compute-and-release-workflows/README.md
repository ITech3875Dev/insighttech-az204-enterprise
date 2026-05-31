# Module M02: Containerized Compute and Release Workflows

## Module Overview
| Item | Details |
|------|---------|
| Duration | 3 to 4 hours |
| Difficulty | Intermediate to Advanced |
| Primary services | App Service (container), Azure Container Registry, deployment slots |
| Labs | Advanced and Capstone |

## Learning Objectives
- Build and publish a containerized web workload.
- Configure App Service to pull container images from ACR.
- Execute release and rollback workflows using deployment slots.
- Apply production validation checks for runtime configuration and identity.

## Module Flow
1. Build container image and push to ACR.
2. Deploy image-backed App Service workload.
3. Configure staging slot and release ring settings.
4. Execute swap and rollback drill with evidence capture.

## Required Deliverables
- ACR repository and tagged image evidence.
- Web app container runtime configuration output.
- Slot swap and rollback command output.
- LP01 validation output with all checks passing.

## Associated Labs
- `labs/advanced/lab-01-containerized-compute-release/README.md`
- `labs/capstone/lab-01-compute-solutions-production-readiness/README.md`

## Exit Criteria
- Learner can ship containerized workloads with controlled release patterns.
- Learner can diagnose runtime misconfiguration issues from command output.
- Learner can run and interpret production readiness validation checks.
