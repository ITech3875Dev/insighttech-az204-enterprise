# Module M01: App Service and Functions

## Module Overview
| Item | Details |
|------|---------|
| Duration | 2.5 to 3.5 hours |
| Difficulty | Beginner to Intermediate |
| Primary services | Azure Functions, Azure App Service |
| Labs | Beginner and Intermediate |

## Learning Objectives
- Build and publish an HTTP-triggered Function endpoint.
- Deploy an App Service workload and manage runtime settings.
- Create and validate deployment slots.
- Execute a low-risk release swap and confirm post-swap health.

## Module Flow
1. Build baseline compute endpoint in Function App.
2. Deploy web workload to App Service plan.
3. Configure staging slot and environment-specific settings.
4. Perform swap, verify endpoint health, and capture evidence.

## Required Deliverables
- Function endpoint URL and successful JSON response evidence.
- App Service default hostname and health verification output.
- Staging slot creation evidence and swap verification logs.
- Validation output from LP01 script.

## Associated Labs
- `labs/beginner/lab-01-function-http-api/README.md`
- `labs/intermediate/lab-01-app-service-deployment-slots/README.md`

## Exit Criteria
- Learner can explain when to choose Functions vs App Service.
- Learner can perform slot-based release safely.
- Learner can validate resource state with CLI and PowerShell output.
