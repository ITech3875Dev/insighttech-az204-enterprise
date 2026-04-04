# LP03 Practice Exam - 50 Questions (Deploy and manage Azure compute resources)

**Domain:** Deploy and manage Azure compute resources (AZ-104)

## Questions

1. Which service is used for IaaS VM deployments in Azure?
   - A. App Service
   - B. Azure Virtual Machines
   - C. Azure Functions
   - D. Azure Policy
2. Which VM image source is supported?
   - A. Azure Marketplace
   - B. Cost Management
   - C. Azure Advisor
   - D. Monitor alerts
3. Managed disks are primarily used to:
   - A. Manage DNS records
   - B. Simplify and improve VM disk reliability
   - C. Replace NSGs
   - D. Create SAS tokens
4. Which VM family is typically memory optimized?
   - A. B-series
   - B. D-series
   - C. E-series
   - D. F-series
5. NSGs control:
   - A. VM cost budgets
   - B. Network traffic rules
   - C. App slot swaps
   - D. Backup policy retention
6. Preferred Linux VM authentication:
   - A. Password only
   - B. SSH keys
   - C. Anonymous login
   - D. Shared local admin
7. Availability sets help distribute VMs across:
   - A. Access tiers
   - B. Fault and update domains
   - C. Tag groups
   - D. Tenant roots
8. Azure CLI command to include VM power details:
   - A. `az vm show --show-details`
   - B. `az vm image list`
   - C. `az disk list`
   - D. `az network vnet list`
9. Which feature helps investigate boot failures?
   - A. Budget alerts
   - B. Boot diagnostics
   - C. Resource locks
   - D. Azure Policy
10. Best reason to choose ephemeral OS disks:
   - A. Faster stateless workloads and reimage scenarios
   - B. Long retention backups
   - C. Lower NSG complexity
   - D. App Service scale
11. VM Scale Sets are designed for:
   - A. Single VM management only
   - B. Large sets of identical VM instances
   - C. Blob replication
   - D. DNS failover only
12. Autoscale reacts to:
   - A. Storage account tags
   - B. Metrics and schedules
   - C. Only manual approval
   - D. Policy exemptions
13. A common frontend for VMSS web workloads:
   - A. Load Balancer/Application Gateway
   - B. Key Vault
   - C. Recovery Services Vault
   - D. Azure Boards
14. Availability Zones primarily protect from:
   - A. App bugs
   - B. Datacenter failures
   - C. RBAC misconfigurations
   - D. Certificate expirations
15. Best proof of autoscale setup:
   - A. VM screenshot
   - B. Autoscale settings JSON
   - C. Budget report
   - D. Advisor score
16. VMSS scaling is not happening; first check:
   - A. Backup policy
   - B. Rule thresholds and cooldown
   - C. Tag compliance
   - D. DNS labels
17. Rolling upgrades in VMSS support:
   - A. Controlled instance model updates
   - B. Cost exports
   - C. Policy assignment
   - D. VNet peering
18. Overprovisioning in VMSS can improve:
   - A. Deployment success speed
   - B. TLS versioning
   - C. RBAC inheritance
   - D. Backup retention
19. Regional resilience improves with:
   - A. Single-zone only
   - B. Multi-zone or paired-region design
   - C. One very large VM
   - D. Disabled monitoring
20. Minimum VMSS evidence should include:
   - A. Instance counts and scaling activity logs
   - B. DNS TXT records only
   - C. Policy exemption details
   - D. Container registry tags
21. Azure App Service is:
   - A. PaaS web/app hosting
   - B. VM backup service
   - C. Storage-only platform
   - D. Network appliance
22. Deployment slots are used for:
   - A. Blue/green-style releases
   - B. NSG rules
   - C. VM resize
   - D. Autoscale profiles
23. App Service Plan controls:
   - A. Runtime region/SKU/scale characteristics
   - B. Role assignments only
   - C. Blob soft delete
   - D. NSG priorities
24. Azure Container Instances provide:
   - A. Serverless container execution without VM management
   - B. VM image gallery
   - C. SQL backups
   - D. Policy definitions
25. First check for post-deployment 500 errors:
   - A. App logs/diagnostics
   - B. Budget thresholds
   - C. Tag policy
   - D. Storage lifecycle rules
26. Slot swap does what?
   - A. Exchanges slot and production app state with slot-setting behavior
   - B. Adds VM scale rules
   - C. Rotates SSH keys
   - D. Deletes logs
27. CLI command to list web apps in an RG:
   - A. `az webapp list --resource-group <rg>`
   - B. `az vm list -d`
   - C. `az aks list`
   - D. `az monitor metrics list`
28. Container instance stuck in Pending often indicates:
   - A. Invalid image or registry auth issue
   - B. Missing tag
   - C. Wrong budget scope
   - D. Deny lock
29. Scale out for App Service means:
   - A. Increase instance count
   - B. Increase only disk size
   - C. Disable slots
   - D. Change subscription
30. Managed identity helps by:
   - A. Avoiding embedded credentials for Azure resource access
   - B. Disabling RBAC
   - C. Replacing NSGs
   - D. Changing regions
31. Azure Bastion provides:
   - A. Portal-based secure RDP/SSH without exposing public VM admin ports
   - B. VMSS autoscale
   - C. Blob replication
   - D. Budget alerts
32. JIT VM access helps by:
   - A. Opening ports permanently
   - B. Limiting admin port exposure windows
   - C. Replacing MFA
   - D. Disabling Defender
33. VM backup service:
   - A. Recovery Services vault
   - B. Container Registry
   - C. Data Factory
   - D. Front Door
34. Metric alerts are used to:
   - A. Notify on threshold breaches
   - B. Assign RBAC
   - C. Create images
   - D. Move subscriptions
35. Baseline secure access pattern for VMs:
   - A. Bastion + restrictive NSGs + least privilege
   - B. Open 3389/22 to internet
   - C. Shared admin account
   - D. Anonymous access
36. Update orchestration supports:
   - A. Scheduled OS patching at scale
   - B. VMSS image creation
   - C. DNS forwarding
   - D. Blob tiering
37. Backup evidence should include:
   - A. Protection status and latest backup job result
   - B. VM size table only
   - C. Tag report only
   - D. App slot names
38. Login failure troubleshooting should start with:
   - A. NSG rules, credentials, and identity/RBAC context
   - B. Lifecycle policy
   - C. Cost analysis
   - D. App settings only
39. Compute security recommendations are surfaced in:
   - A. Microsoft Defender for Cloud
   - B. Azure Boards
   - C. Azure CDN
   - D. App Configuration
40. Boot diagnostics data is useful for:
   - A. Startup and console troubleshooting
   - B. RBAC export
   - C. Policy assignment
   - D. Budget planning
41. Which are compute availability controls? (Select all that apply)
   - A. Availability sets
   - B. Availability zones
   - C. VMSS across zones
   - D. Resource tags only
42. Which improve VM administration security? (Select all that apply)
   - A. Bastion
   - B. JIT
   - C. Permanent open RDP/SSH
   - D. Least-privilege RBAC
43. Valid VMSS scaling evidence includes: (Select all that apply)
   - A. Autoscale profile JSON
   - B. Before/after instance count
   - C. Cost chart only
   - D. Activity log scale events
44. Reliable App Service deployment practices include: (Select all that apply)
   - A. Deployment slots
   - B. Diagnostics logging
   - C. No testing before prod
   - D. Health checks
45. Core compute operations deliverables include: (Select all that apply)
   - A. Monitoring/alerts configuration
   - B. Backup and restore evidence
   - C. Anonymous admin design
   - D. Remediation notes
46. You need burst capacity weekdays and cost savings overnight. Best option:
   - A. Static VM fleet
   - B. VMSS autoscale profiles and schedules
   - C. Single oversized VM
   - D. Disable alerts
47. Near-zero downtime web release pattern:
   - A. Manual VM replacement
   - B. App Service deployment slots + swap
   - C. Restart production repeatedly
   - D. Disable probes
48. Secure admin access without public management ports:
   - A. Open 22/3389 internet-wide
   - B. Bastion + restrictive NSG rules
   - C. Shared local admin password
   - D. Disable MFA
49. VMSS does not scale in; likely cause:
   - A. Missing scale-in rule/cooldown mismatch
   - B. Unsupported service
   - C. App Service plan issue
   - D. Backup vault missing
50. Best enterprise LP03 operating model:
   - A. One-time portal clicks only
   - B. IaC + validation scripts + retained evidence
   - C. Disable controls to reduce noise
   - D. Shared credentials
