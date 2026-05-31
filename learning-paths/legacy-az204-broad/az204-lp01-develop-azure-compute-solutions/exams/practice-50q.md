# AZ-204 LP01 Practice Questions (50)

## Instructions
- Select one best answer (A, B, C, or D) for each question.
- Target time: 60 minutes.
- Focus areas: Azure Functions, App Service, deployment slots, containerized compute, release operations, and managed identity.

1. Which hosting option is best for event-driven, short-lived compute that scales automatically with execution demand?
A. Azure Kubernetes Service
B. Azure Virtual Machine Scale Sets
C. Azure Functions Consumption plan
D. Azure App Service Environment

2. Which statement best describes deployment slots in App Service?
A. Slots can only be used with Linux web apps.
B. Slots let you stage and swap application versions.
C. Slots are available only in Free tier plans.
D. Slots automatically replicate across subscriptions.

3. Which command enables system-assigned managed identity for a Function App?
A. az functionapp auth set
B. az functionapp identity assign
C. az webapp config identity
D. az ad sp create-for-rbac

4. What is the main advantage of using a staging slot before production deployment?
A. It removes the need for testing.
B. It guarantees zero errors.
C. It allows validation before traffic cutover.
D. It increases storage account throughput.

5. In a slot swap, which slot receives production traffic after the swap completes?
A. Source slot
B. Staging slot always
C. Target slot (production)
D. Slot with highest SKU

6. Which resource is required when creating a Function App?
A. Azure SQL Managed Instance
B. Storage account
C. Azure Front Door profile
D. Recovery Services vault

7. What is the primary purpose of App Service Plan SKU selection?
A. Choose authentication provider
B. Define compute size and pricing tier
C. Configure DNS records
D. Set TLS certificate issuer

8. Which setting should remain slot-specific to avoid production leakage?
A. WEBSITE_RUN_FROM_PACKAGE
B. Build metadata for staging validation
C. Runtime stack setting
D. Always On setting

9. A team needs to deploy container images to App Service. Which feature is required?
A. Deployment Center with container source
B. Azure Bastion
C. Azure Arc-enabled servers
D. VM extension configuration

10. Which statement about system-assigned managed identity is true?
A. It survives resource deletion.
B. It requires manual secret rotation.
C. It is tied to the lifecycle of the resource.
D. It can only access Graph API.

11. Which check best confirms a Function App endpoint is healthy?
A. Resource group has tags.
B. HTTP invocation returns expected JSON payload.
C. Storage account has soft delete enabled.
D. App Service plan is in East US.

12. What is the safest order for release using slots?
A. Deploy to production, test in staging, then rollback
B. Deploy to staging, smoke test, swap to production
C. Stop production, deploy to staging, restart
D. Delete staging slot, deploy new production slot

13. Which App Service capability supports rollback after a faulty swap?
A. Manual reverse swap
B. Recovery Services restore only
C. Availability Zone reconfiguration
D. Backup vault failover

14. Which command lists slots for a web app?
A. az webapp list-slots
B. az webapp deployment slot list
C. az appservice slot show
D. az webapp slot enumerate

15. Which runtime identifier is valid for Linux Python App Service in CLI?
A. PYTHON:3.11
B. python-3_11-linux
C. Python311App
D. RUNTIME_PY311

16. Which scenario is most appropriate for Azure Functions over App Service?
A. Monolithic web front end with continuous traffic
B. Scheduled file cleanup job triggered hourly
C. Stateful in-memory cache tier
D. GUI-heavy desktop workload

17. Why should teams keep app configuration outside code where possible?
A. It reduces DNS latency.
B. It enables environment-specific release control.
C. It avoids TLS requirements.
D. It prevents autoscale events.

18. Which item is most useful as release evidence in LP01?
A. Screenshot of Azure home page
B. Swap command output and post-swap endpoint response
C. Billing export CSV only
D. VM serial console output

19. What does WEBSITE_RUN_FROM_PACKAGE primarily provide?
A. Container orchestration
B. Immutable zip package deployment behavior
C. SQL connection pooling
D. DNS failover

20. Which command verifies managed identity principalId exists?
A. az functionapp identity show
B. az functionapp settings show
C. az ad user show
D. az monitor metrics list

21. Which service best hosts a long-running REST API with predictable traffic and built-in slots?
A. Azure Batch
B. Azure App Service
C. Azure Automation
D. Azure Queue Storage

22. A release pipeline needs warm-up checks before swap. What should run first?
A. Delete production slot settings
B. Smoke tests against staging endpoint
C. Restart resource group
D. Disable health check path

23. Which statement about Function App consumption plan scaling is correct?
A. Scale is manual only.
B. Scale is trigger-driven and automatic.
C. Scale requires VMSS attachment.
D. Scale is fixed to one instance.

24. What is the most likely cause if staging slot appears healthy but swap fails?
A. Resource group naming mismatch only
B. Locked setting or configuration conflict
C. Azure region outage always
D. Subscription has no tags

25. Why capture both CLI and PowerShell procedures in labs?
A. To duplicate documentation unnecessarily
B. To support mixed enterprise tooling standards
C. Because CLI cannot deploy apps
D. Because PowerShell cannot query resources

26. Which command creates an App Service plan for Linux workloads?
A. az appservice plan create --is-linux
B. az webapp plan add --linux
C. az appservice create-linux-plan
D. az plan appservice create

27. What is the best action when production health degrades immediately after swap?
A. Wait 30 minutes and do nothing
B. Reverse swap to rollback, then investigate
C. Delete the staging slot
D. Recreate subscription

28. Which artifact most directly supports post-incident analysis?
A. Browser bookmarks
B. Timestamped deployment and validation logs
C. Regional price sheet
D. Empty markdown template

29. Which type of identity should be preferred for app-to-Azure service access?
A. Shared account keys in source code
B. Managed identity with least privilege RBAC
C. Personal user credentials
D. Static password in app settings

30. In LP01, which item is part of production readiness criteria?
A. Unvalidated manual portal changes
B. Repeatable validation script pass output
C. One-time deployment only
D. No rollback plan required

31. Which command returns the default hostname for a web app?
A. az webapp host show
B. az webapp show --query defaultHostName
C. az network dns cname list
D. az appservice hostname get

32. What should be validated after assigning managed identity?
A. principalId exists and role assignments are correct
B. Storage account is Premium tier
C. Slot name changed
D. Plan moved subscriptions

33. Which option best describes a release ring strategy in App Service?
A. Deploy directly to production only
B. Use slot-based staged validation before full cutover
C. Use separate tenant per build
D. Disable all app settings

34. Which app setting pattern is safest?
A. Hardcode secrets in repo
B. Environment-specific settings per slot
C. Reuse one secret across all environments forever
D. Store passwords in README

35. Which function output is best for health endpoint observability?
A. Plain text with no timestamp
B. Structured JSON with status and timestamp
C. Binary output only
D. Empty 200 response

36. Which task should happen before cleanup in labs?
A. Delete evidence files
B. Capture final validation outputs
C. Remove tags from resources
D. Disable logging permanently

37. Why include rollback simulation in intermediate lab?
A. To increase lab time only
B. To prove recoverability under bad release conditions
C. To avoid slot usage
D. To remove need for staging tests

38. Which command deploys a zip package to App Service?
A. az webapp deploy --type zip
B. az webapp slot zipadd
C. az functionapp pack deploy
D. az appservice upload bundle

39. Which check validates slot isolation of environment variables?
A. Compare appsettings values between production and staging
B. Compare subscription IDs only
C. Compare billing alerts only
D. Compare VM hostnames

40. What is a key benefit of LP-level validation scripts?
A. They replace all learning objectives.
B. They provide consistent pass/fail checks across cohorts.
C. They remove the need for labs.
D. They guarantee exam success.

41. Which service pair is central to LP01 scope?
A. Virtual Network and DNS Private Resolver
B. Azure Functions and Azure App Service
C. Azure SQL and Synapse
D. AKS and Arc Kubernetes

42. Which is the best source of truth during release verification?
A. Verbal confirmation
B. Command output and endpoint response evidence
C. Memory of prior run
D. Uncommitted local notes only

43. If `az webapp deployment slot list` returns no staging slot, what should happen?
A. Continue swap anyway
B. Create slot and rerun validation
C. Delete web app
D. Ignore because slots are optional for all tiers

44. Which LP01 lab level should first introduce rollback workflow?
A. Beginner
B. Intermediate
C. Capstone only
D. No level should include rollback

45. Which principle is applied when assigning role access to managed identity?
A. Broadest possible permissions
B. Least privilege
C. Temporary anonymous access
D. Shared ownership keys

46. Which runtime/config mismatch should fail validation?
A. App running in expected runtime
B. linuxFxVersion not matching expected stack
C. Resource group contains tags
D. Slot has app settings

47. What should a production-ready LP include beyond lab instructions?
A. Placeholder notes only
B. Validation scripts, exam artifacts, and evidence standards
C. Only marketing summary
D. No prerequisites

48. Why keep a single LP01 blueprint for other paths?
A. To force identical service content
B. To standardize quality, structure, and validation across paths
C. To avoid writing module docs
D. To remove need for assessments

49. Which action best aligns with release governance?
A. Deploy from local machine without records
B. Track deployment commands and outcomes per environment
C. Skip staging verification for urgency
D. Disable logs to reduce noise

50. What is the best final checkpoint before marking LP01 completion?
A. Read the module title once
B. Validate resources, review assessment results, and archive evidence
C. Delete all content files
D. Rename the resource group only
