# AZ-204 LP01: Develop Azure Compute Solutions

## Overview
This learning path delivers production-oriented compute implementation skills for AZ-204, with hands-on workflows for Azure Functions, Azure App Service, containerized deployments, release slots, and operational validation.

## Audience
- Developers preparing for AZ-204 Domain 1 outcomes.
- Engineers transitioning from admin-centric Azure usage to application-centric delivery patterns.
- Instructors running enterprise-style cohorts with repeatable validation requirements.

## Learning Outcomes
By the end of LP01, learners can:
- Build and publish HTTP-triggered Azure Functions.
- Deploy and configure Azure App Service web workloads.
- Implement slot-based release workflows with safe swap procedures.
- Configure managed identity and secure app settings patterns.
- Validate compute deployments with script-based, repeatable checks.

## Delivery Model
- Beginner labs: guided, step-by-step build and verify.
- Intermediate labs: operational deployment and release controls.
- Advanced labs: production hardening and controlled rollback.
- Capstone: integrate all LP01 capabilities in one validated delivery flow.

## Modules
- `m01-app-service-and-functions`
- `m02-containerized-compute-and-release-workflows`

## Lab Sequence
- Beginner: `labs/beginner/lab-01-function-http-api`
- Intermediate: `labs/intermediate/lab-01-app-service-deployment-slots`
- Advanced: `labs/advanced/lab-01-containerized-compute-release`
- Capstone: `labs/capstone/lab-01-compute-solutions-production-readiness`

## Masterclass
- `masterclass/cli/README.md`: CLI-first compute delivery, release automation, and rollback drills.

## Assessments
- `exams/practice-50q.md`: 50-question LP01 practice set.
- `exams/answer-key.md`: answer key and objective mapping.

## Validation
Run LP-level validation after completing labs:

```powershell
pwsh learning-paths/az204-lp01-develop-azure-compute-solutions/validation/az204-lp01-validate.ps1 `
	-SubscriptionId <subscription-id> `
	-ResourceGroupName <rg-name> `
	-FunctionAppName <function-app-name> `
	-WebAppName <web-app-name> `
	-AppServicePlanName <plan-name>
```

## Definition of Done
- All four lab levels completed with evidence.
- Practice set attempted and reviewed against answer key.
- Validation script returns successful checks for resource state, slot configuration, and identity configuration.
- Learner can explain release and rollback decisions for App Service and Function workloads.
