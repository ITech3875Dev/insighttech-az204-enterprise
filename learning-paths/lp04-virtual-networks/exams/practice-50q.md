# LP04 Practice Exam - 50 Questions (Configure and manage virtual networks for Azure administrators)

**Domain:** Configure and manage virtual networks for Azure administrators (AZ-104)

## Questions

1. What is the primary purpose of an Azure virtual network?
   - A. Host DNS zones only
   - B. Provide isolated networking for Azure resources
   - C. Replace NSGs
   - D. Store backups
2. Which CIDR block is valid for a VNet address space?
   - A. 10.10.0.0/16
   - B. 10.10.0.0/33
   - C. 10.10.0.0/64
   - D. 300.1.1.0/24
3. Subnets in the same VNet can communicate by default unless blocked by:
   - A. Budget settings
   - B. NSG or route controls
   - C. RBAC only
   - D. Tags
4. A subnet must always reserve IP addresses for:
   - A. NSG rules
   - B. Azure internal use
   - C. DNS records
   - D. Route tables
5. Which service provides managed private DNS for Azure resources?
   - A. Azure Private DNS
   - B. Azure Advisor
   - C. Cost Management
   - D. Azure DevOps
6. VNet peering allows:
   - A. Only one-way connectivity
   - B. Low-latency connectivity between VNets
   - C. On-premises DNS replacement
   - D. Automatic internet breakout
7. Peering is non-transitive by default means:
   - A. Routes are always blocked
   - B. VNet A to B and B to C does not imply A to C
   - C. DNS will fail
   - D. NSGs are ignored
8. User-defined routes are configured in:
   - A. NSGs
   - B. Route tables
   - C. Azure Monitor
   - D. Policy assignments
9. What does the next hop type VirtualAppliance represent?
   - A. Azure DNS
   - B. Network virtual appliance IP
   - C. Load balancer frontend
   - D. VPN gateway subnet
10. Effective routes are used to:
   - A. Size virtual machines
   - B. Validate actual route behavior for a NIC/subnet
   - C. Create DNS records
   - D. Configure Bastion
11. Which service is used for site-to-site encrypted connectivity to on-premises?
   - A. VNet peering
   - B. VPN Gateway
   - C. App Service Environment
   - D. Azure Firewall Policy
12. ExpressRoute typically provides:
   - A. Public internet-only path
   - B. Private dedicated connectivity to Azure
   - C. DNS failover
   - D. VM scale sets
13. A route table associated to subnet A affects:
   - A. All VNets in subscription
   - B. Only resources in subnet A
   - C. Only gateway subnet
   - D. DNS zones
14. Which tool can test reachability between two Azure resources?
   - A. Connection troubleshoot (Network Watcher)
   - B. Budget export
   - C. Advisor
   - D. Blueprint
15. What is a common cause of unexpected traffic pathing?
   - A. Duplicate tags
   - B. Overlapping UDRs or incorrect next hop
   - C. Missing role assignment
   - D. Backup policy
16. Azure Load Balancer is primarily a:
   - A. Layer 4 load balancer
   - B. Layer 7 web application firewall only
   - C. DNS service
   - D. Monitoring agent
17. A health probe in Load Balancer determines:
   - A. Budget thresholds
   - B. Backend endpoint availability
   - C. NSG deny rules
   - D. Route propagation
18. Internal load balancer is used for:
   - A. Internet-facing endpoints only
   - B. Private backend workloads within virtual networks
   - C. DNS forwarding
   - D. Gateway routing
19. Public load balancer requires:
   - A. Private DNS zone
   - B. Public frontend IP
   - C. VPN gateway
   - D. Route server
20. What is a backend pool?
   - A. List of route tables
   - B. Target instances receiving balanced traffic
   - C. Collection of DNS records
   - D. NSG rule set
21. Azure DNS zone is used to:
   - A. Store VM disks
   - B. Host DNS records for a domain
   - C. Configure VPN tunnels
   - D. Configure NSGs
22. Which record maps a name to IPv4 address?
   - A. AAAA
   - B. A
   - C. CNAME
   - D. TXT
23. Which record maps one name to another canonical name?
   - A. PTR
   - B. NS
   - C. CNAME
   - D. SRV
24. Private DNS zones are commonly linked to:
   - A. Resource groups
   - B. Virtual networks
   - C. NSGs
   - D. Route tables
25. NSGs evaluate rules by:
   - A. Highest priority number first
   - B. Lowest priority number first
   - C. Random order
   - D. Creation date
26. NSGs can be associated with:
   - A. VNet only
   - B. Subnet and NIC
   - C. Route tables only
   - D. DNS zones
27. Which platform service helps centralize network filtering with DNAT/SNAT features?
   - A. Azure Firewall
   - B. Cost Management
   - C. Azure Advisor
   - D. App Service
28. Service endpoints provide:
   - A. Private IP into PaaS resource
   - B. Secure service access over Azure backbone from subnet
   - C. DNS failover
   - D. VM backups
29. Private endpoints provide:
   - A. Public endpoint hardening only
   - B. Private IP address to access PaaS resource
   - C. Dynamic route creation
   - D. App scaling
30. What is the first check when traffic is blocked unexpectedly?
   - A. Cost analysis
   - B. NSG effective security rules and UDRs
   - C. VM size
   - D. Policy compliance
31. Network Watcher IP flow verify helps determine:
   - A. DNS zone health
   - B. If traffic is allowed or denied by NSG rules
   - C. Route table creation status
   - D. VPN SKU
32. Packet capture in Network Watcher is used to:
   - A. Record packet traffic for troubleshooting
   - B. Create peering
   - C. Configure firewall rules
   - D. Build DNS records
33. Connection Monitor can help with:
   - A. Long-term connectivity monitoring
   - B. VM resizing
   - C. Budgeting
   - D. Tagging
34. Which design best supports segmented enterprise networking?
   - A. Flat single subnet for all workloads
   - B. Hub-spoke with subnet segmentation and controls
   - C. Public IP for every workload
   - D. Disable NSGs
35. DNS resolution fails across peered VNets. Common fix:
   - A. Recreate NSGs
   - B. Configure DNS settings/forwarders and zone links correctly
   - C. Resize gateway
   - D. Remove route tables
36. Which command can show VNet peerings using CLI?
   - A. `az network vnet peering list`
   - B. `az network nsg list`
   - C. `az monitor metrics list`
   - D. `az vm list`
37. Which command can display route tables using CLI?
   - A. `az network route-table list`
   - B. `az network dns list`
   - C. `az network peering list`
   - D. `az network firewall list`
38. Which command can list NSGs using CLI?
   - A. `az network nsg list`
   - B. `az network route list`
   - C. `az dns zone list`
   - D. `az vm nsg list`
39. Best practice for network change validation includes:
   - A. Apply and assume success
   - B. Pre/post checks with evidence and rollback notes
   - C. Skip documentation
   - D. Test only in production
40. Which item is most useful in a troubleshooting handoff?
   - A. Screenshot only
   - B. Root cause, impacted flows, evidence, and remediation steps
   - C. Budget data
   - D. VM inventory
41. Which are valid Azure network security controls? (Select all that apply)
   - A. NSG
   - B. Azure Firewall
   - C. UDR with NVA
   - D. Tag policy only
42. Which artifacts support routing validation? (Select all that apply)
   - A. Effective routes output
   - B. Route table JSON
   - C. Health probe config
   - D. Next-hop test result
43. Which practices improve DNS reliability? (Select all that apply)
   - A. Zone link validation
   - B. Split-horizon planning
   - C. Random record updates in production
   - D. TTL strategy
44. Which actions support secure remote administration? (Select all that apply)
   - A. Bastion
   - B. Restrictive NSGs
   - C. Permanently open management ports
   - D. JIT where applicable
45. Which are expected deliverables for LP04 operations? (Select all that apply)
   - A. Connectivity test evidence
   - B. Security rule rationale
   - C. DNS/route diagrams
   - D. Anonymous access design
46. You need controlled east-west traffic inspection between spokes. Best design:
   - A. Flat peering everywhere
   - B. Hub with NVA/firewall and UDR steering
   - C. Public internet routing
   - D. Disable NSGs
47. Traffic reaches load balancer frontend but not backend. Most likely first fix:
   - A. Remove DNS
   - B. Validate backend pool membership and health probe
   - C. Change VM size
   - D. Delete route table
48. Hybrid branch cannot reach Azure subnet after route change. Best first check:
   - A. Cost data
   - B. Gateway/UDR next-hop consistency and effective routes
   - C. Tag compliance
   - D. VM extension status
49. DNS name resolves publicly but not privately in VNet. Likely issue:
   - A. NSG outbound deny only
   - B. Missing private DNS zone link or record
   - C. Route table absent
   - D. Budget limit
50. Best enterprise pattern for LP04 readiness:
   - A. Manual portal-only changes
   - B. IaC + validation scripts + troubleshooting playbooks
   - C. Disable logging
   - D. Shared admin credentials
