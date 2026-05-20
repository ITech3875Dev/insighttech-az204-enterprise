# Capstone Lab 01: Compute Solutions Production Readiness

## Scenario
Build and validate a complete compute delivery path combining Function App and App Service workloads, managed identity, staging release controls, rollback readiness, and script-based quality gates.

## Outcome
At completion, your environment should satisfy all LP01 validation checks and provide evidence suitable for instructor sign-off.

## Scope
- Function App endpoint deployment and health validation.
- App Service web workload with staging slot.
- Managed identity enabled for both compute resources.
- Slot swap and rollback verification.
- LP01 validation script execution.

## Required Inputs
- Subscription ID
- Resource group name
- Function App name
- Web App name
- App Service plan name

## Execution Plan
1. Run beginner lab and verify Function endpoint response.
2. Run intermediate lab and verify staging swap workflow.
3. Run advanced lab and verify container release workflow.
4. Execute LP01 validation script and resolve all failures.
5. Package evidence and summarize release decisions.

## Validation Command

```powershell
pwsh learning-paths/az204-lp01-develop-azure-compute-solutions/validation/az204-lp01-validate.ps1 `
  -SubscriptionId <subscription-id> `
  -ResourceGroupName <rg-name> `
  -FunctionAppName <function-app-name> `
  -WebAppName <web-app-name> `
  -AppServicePlanName <plan-name> `
  -StagingSlotName staging
```

## Pass Criteria
- Validation script returns `[RESULT] PASS`.
- Function and web app resources are running.
- Staging slot exists and has been used in release workflow.
- Managed identity is configured and verifiable.
- Runtime stack values match expected baseline.

## Evidence Package
- Deployment command transcript.
- Endpoint responses (function and web app).
- Slot swap and rollback outputs.
- Final validation output.
- One-page release summary:
  - What changed
  - How risk was controlled
  - How rollback was proven

## Cleanup
Delete lab resources only after evidence is archived and reviewed.
