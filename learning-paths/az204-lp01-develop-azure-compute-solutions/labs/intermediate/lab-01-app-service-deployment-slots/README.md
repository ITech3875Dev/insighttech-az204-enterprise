# Lab 01 (Intermediate): App Service Deployment Slots

## Scenario
Deploy an application to Azure App Service, configure a staging slot, validate behavior, and perform a controlled slot swap.

## Prerequisites
- Existing sample app source.
- Azure App Service plan and app permissions.

## Tasks
1. Deploy baseline application to production slot.
2. Create and configure a staging slot.
3. Deploy updated build to staging.
4. Validate staging behavior and settings.
5. Swap staging into production and confirm health.

## Validation Checks
- Staging slot deployment succeeds.
- Slot swap completes without downtime indicators.
- Post-swap endpoint behavior matches expected output.

## Cleanup
Remove test artifacts and note final slot configuration.
