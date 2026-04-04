# LP05 Practice Exam - 50 Questions (Monitor and back up Azure resources)

**Domain:** Monitor and back up Azure resources (AZ-104)

## Questions

1. Which Azure service centralizes metrics, logs, and alerts?
   - A. Azure Monitor
   - B. Azure Policy
   - C. Cost Management
   - D. Azure DNS
2. Log Analytics workspace is primarily used to:
   - A. Host VMs
   - B. Store/query logs for analysis
   - C. Route internet traffic
   - D. Manage RBAC only
3. KQL is used in Azure to:
   - A. Build virtual networks
   - B. Query telemetry data
   - C. Resize VMs
   - D. Rotate keys
4. Activity Log captures:
   - A. Guest OS syslog
   - B. Subscription-level control plane events
   - C. App source code
   - D. Network packet captures only
5. Diagnostic settings are used to:
   - A. Export platform logs/metrics to destinations
   - B. Configure DNS zones
   - C. Create NSG rules
   - D. Set VM size
6. Which alert type uses a numeric threshold over a metric?
   - A. Activity log alert
   - B. Metric alert
   - C. Budget alert
   - D. Security recommendation
7. Action Groups define:
   - A. Backup policies
   - B. Notification and automation actions for alerts
   - C. Route table associations
   - D. DNS links
8. Best first step to reduce alert noise:
   - A. Disable all alerts
   - B. Tune thresholds/window and scope
   - C. Increase VM size
   - D. Remove diagnostics
9. Dynamic threshold alerts are useful when:
   - A. Data is stable forever
   - B. Baseline behavior varies over time
   - C. No metrics exist
   - D. Using DNS logs only
10. Which destination can diagnostic settings send data to?
   - A. Log Analytics workspace
   - B. Event Hub
   - C. Storage account
   - D. All of the above
11. Which service is used for VM backups in Azure?
   - A. Recovery Services vault
   - B. Azure Firewall
   - C. App Service
   - D. Route Server
12. Backup policy defines:
   - A. VM size and image
   - B. Schedule and retention of backups
   - C. DNS TTL
   - D. NSG priorities
13. Soft delete in backup context helps protect against:
   - A. Query timeouts
   - B. Accidental deletion of backup items
   - C. Routing loops
   - D. Alert fatigue
14. What must you verify after enabling backup for a VM?
   - A. Route table association
   - B. First successful backup job/recovery points
   - C. DNS alias
   - D. NSG deny rule
15. Cross-region restore capability depends on:
   - A. Vault configuration and supported scenarios
   - B. NSG rules
   - C. App slots
   - D. Budget thresholds
16. Restore testing should be:
   - A. Avoided in non-prod
   - B. Regularly performed and documented
   - C. Done only after incidents
   - D. Manual with no evidence
17. Azure Monitor metrics are typically:
   - A. Near real-time numerical time-series
   - B. Static text files
   - C. DNS records
   - D. VM images
18. Logs differ from metrics because logs are:
   - A. Less detailed and always numeric
   - B. Richer, event-based records for deep analysis
   - C. Not queryable
   - D. Only for backups
19. What does an alert severity indicate?
   - A. VM size category
   - B. Relative criticality (Sev0-Sev4)
   - C. Cost center
   - D. Retention period
20. Which Azure feature can visualize and query log data interactively?
   - A. Logs in Azure Monitor
   - B. Azure Advisor only
   - C. Load Balancer
   - D. ExpressRoute
21. Which is best for availability monitoring from multiple regions?
   - A. Budget alerts
   - B. Availability tests/Application Insights where applicable
   - C. NSG flow logs only
   - D. Role assignments
22. If an alert did not fire, first check:
   - A. Metric availability, scope, condition, evaluation window
   - B. VM size
   - C. DNS zone
   - D. Backup vault name
23. Which governance practice improves monitorability?
   - A. Inconsistent naming
   - B. Standardized tagging and alert ownership metadata
   - C. No runbooks
   - D. Shared credentials
24. Data retention in Log Analytics affects:
   - A. How long queryable logs are stored
   - B. VM CPU usage only
   - C. VNet peering
   - D. DNS resolution
25. Which backup storage redundancy options are common for vaults?
   - A. LRS/GRS (based on service support)
   - B. ZRS only
   - C. Premium SSD
   - D. None
26. Which command type validates backup policy assignments best?
   - A. Backup policy/item listing commands
   - B. DNS query commands
   - C. VNet peering commands
   - D. Budget commands
27. A critical VM is protected but no recent restore point exists. Likely issue:
   - A. Backup job failures or schedule misconfiguration
   - B. Missing NSG
   - C. DNS TTL too low
   - D. Route not propagated
28. Which operation should be documented for recovery readiness?
   - A. Test restore outcome and timing
   - B. VM resize history
   - C. DNS changes only
   - D. Budget trend only
29. Alert processing rules are used to:
   - A. Suppress/route alert notifications under defined conditions
   - B. Create backup snapshots
   - C. Change VM size
   - D. Configure VNet peering
30. A runbook linked from an alert should include:
   - A. Triage steps, owners, rollback/remediation actions
   - B. Only screenshots
   - C. Billing data only
   - D. NSG templates only
31. Which signal source supports service health notifications?
   - A. Activity log/service health alerts
   - B. VM extensions
   - C. Route tables
   - D. DNS aliases
32. Which is a good KPI for monitoring maturity?
   - A. Number of open alerts forever
   - B. Mean time to detect/respond trends
   - C. Number of tags only
   - D. VM count
33. For backup governance, which is most important?
   - A. Protected item coverage by policy tiers
   - B. NSG default rule count
   - C. DNS record quantity
   - D. VM naming style
34. Which helps correlate incidents across resources?
   - A. Centralized workspace queries and consistent dimensions/tags
   - B. Random per-team logs
   - C. Manual notes only
   - D. Disable diagnostics
35. Which alert action can trigger automation?
   - A. Action Group webhook/logic app/runbook integration
   - B. DNS record creation
   - C. Route table update automatically
   - D. VM image gallery sync
36. A backup restore fails due to missing permissions. Most likely fix:
   - A. Correct RBAC on vault/resource scopes
   - B. Change DNS server
   - C. Open all NSG ports
   - D. Disable alerts
37. Which evidence best proves monitoring baseline is active?
   - A. Workspace query output + active alerts + action group config
   - B. Portal homepage screenshot only
   - C. VM size list
   - D. Cost export
38. Which evidence best proves backup baseline is active?
   - A. Vault policy, protected items, recent successful jobs
   - B. DNS records
   - C. Route table JSON
   - D. NSG rules
39. Post-incident review should include:
   - A. Root cause, alert effectiveness, remediation actions, preventive controls
   - B. Only a restart timestamp
   - C. Only budget impact
   - D. Only VM SKU
40. Which statement is true about alert scope?
   - A. Scope must target the resource(s) emitting the monitored signal
   - B. Scope does not matter
   - C. Scope is always tenant-wide
   - D. Scope only works at RG
41. Which are core monitor-and-backup controls? (Select all that apply)
   - A. Alerts and action groups
   - B. Log Analytics queries
   - C. Backup policies and restore tests
   - D. Random manual checks only
42. Which artifacts support alert troubleshooting? (Select all that apply)
   - A. Rule condition configuration
   - B. Signal metric/log evidence
   - C. Action group delivery traces
   - D. DNS NS records only
43. Which actions improve backup reliability? (Select all that apply)
   - A. Regular restore testing
   - B. Policy coverage audits
   - C. Ignore failed jobs
   - D. Documented recovery runbooks
44. Which are good remediation practices after noisy alerts? (Select all that apply)
   - A. Adjust thresholds and windows
   - B. Add suppression windows where justified
   - C. Disable all alerts permanently
   - D. Validate changes with test signals
45. Which deliverables are expected for LP05? (Select all that apply)
   - A. Monitoring baseline evidence
   - B. Alert tuning decisions
   - C. Backup and restore evidence
   - D. Anonymous admin model
46. You need rapid notification plus auto-ticket creation. Best design:
   - A. Action Group with email/webhook integration
   - B. Route table only
   - C. NSG flow logs only
   - D. DNS alias
47. A VM backup succeeded yesterday but failed today. Best first check:
   - A. Backup job error details and recent environment changes
   - B. DNS TTL
   - C. VNet peering
   - D. Cost budget
48. Alert fires but no one receives notifications. Most likely cause:
   - A. Action Group misconfiguration or processing rule suppression
   - B. VM size mismatch
   - C. DNS record type
   - D. Missing route table
49. Workspace query returns no data for a resource. Likely causes include:
   - A. Missing diagnostic settings or wrong time range/scope
   - B. NSG deny rule only
   - C. Backup policy retention
   - D. VM generation type
50. Best enterprise LP05 operating pattern:
   - A. IaC + monitoring standards + backup policy governance + regular recovery drills
   - B. One-time setup with no validation
   - C. Disable alerts to reduce noise
   - D. Shared credentials and manual-only recovery
