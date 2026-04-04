# Enterprise Landing Zone Masterclass - Hub and Spoke (LP06 Capstone Final Project)

## Purpose
Build an enterprise-class Azure landing zone (near-MVP) using a hub-and-spoke topology that integrates all AZ-104 learning paths:
- Identity and governance
- Storage services and protection
- Compute deployment and operations
- Virtual networking and secure routing
- Monitoring, alerting, backup, and recovery

This track is command-first (CLI, PowerShell, and Bicep). Portal use is limited to one required step: deploying the OPNsense NVA from Azure Marketplace.

## Time Estimate
- 6 to 8 hours

## Delivery Mode
- Non-portal by default
- Portal exception: Marketplace NVA deployment only

## Topology (Target State)

```text
On-prem/Lab Client
    |
    | S2S VPN (IPsec)
    v
[Hub VNet 10.10.0.0/16]
  - GatewaySubnet 10.10.0.0/27 (VPN Gateway)
  - AzureFirewallSubnet/NVA-Transit subnet 10.10.1.0/24 (OPNsense NVA)
  - Mgmt subnet 10.10.2.0/24 (jump/admin VM optional)
    |
    +---- VNet Peering ---- [Spoke-Prod 10.20.0.0/16]
    |                         - app subnet
    |                         - data subnet
    |
    +---- VNet Peering ---- [Spoke-Shared 10.30.0.0/16]
                      - ops subnet
                      - private endpoint subnet

Routing intent:
- Spoke UDR default route -> OPNsense LAN IP in Hub
- NVA forwards north/south and east/west per policy
- VPN Gateway provides encrypted site connectivity
- Spoke workloads have no direct internet access; all egress is forced to hub for inspection and policy enforcement
```

## Requirements

## Subscription and access
- One non-production Azure subscription
- Owner or equivalent rights for RG, network, identity, policy, and backup configuration
- Ability to assign RBAC and Azure Policy at subscription and RG scope

## Tools
- Azure CLI latest stable
- PowerShell 7+ and Az modules
- Bicep CLI integration (`az bicep version`)
- SSH client for OPNsense management

## Naming and regions
- Region: choose one primary region (example: `eastus2`)
- Prefix pattern: `az104lz-<team>-<env>-<region>-<nn>`
- Required tags on all resources:
  - `Environment`
  - `CostCenter`
  - `Workload`
  - `Owner`

## Security baseline
- Least-privilege RBAC only
- Deny public endpoints where not required
- Private endpoints for data-plane services where feasible
- Defender/monitoring signals enabled where available in scope
- Spoke subnets must not have direct internet egress; internet destinations are denied by policy on NVA

## Learning Outcomes
1. Build and govern a hub-and-spoke landing zone using IaC and command workflows
2. Implement policy, locks, tags, and RBAC guardrails with repeatable evidence
3. Deploy and operate VPN Gateway plus OPNsense NVA as transit firewall
4. Configure workload routing through NVA with explicit allow/deny controls
5. Implement monitoring, alerting, and backup posture with recovery validation

## Code Breadcrumbs and Command References

Use these breadcrumbs to keep the capstone implementation organized and reviewable. If a file does not exist yet, create it in the location shown.

| Deployment Element | Code Breadcrumb (Repo Path) | Primary Command Set | Official Reference URL |
|---|---|---|---|
| Global variables and naming | `learning-paths/lp06-capstone-final-project/artifacts/variables.env` | Azure CLI account and context | [Azure CLI account](https://learn.microsoft.com/en-us/cli/azure/account) |
| Resource groups | `learning-paths/lp06-capstone-final-project/artifacts/00-rg.bicep` | `az group` | [Azure CLI group](https://learn.microsoft.com/en-us/cli/azure/group) |
| Hub VNet and subnets | `learning-paths/lp06-capstone-final-project/artifacts/01-hub-network.bicep` | `az network vnet` | [Azure CLI network vnet](https://learn.microsoft.com/en-us/cli/azure/network/vnet) |
| Spoke VNets and subnets | `learning-paths/lp06-capstone-final-project/artifacts/02-spoke-network.bicep` | `az network vnet` | [Azure CLI network vnet](https://learn.microsoft.com/en-us/cli/azure/network/vnet) |
| VNet peerings | `learning-paths/lp06-capstone-final-project/artifacts/03-peering.bicep` | `az network vnet peering` | [Azure CLI vnet peering](https://learn.microsoft.com/en-us/cli/azure/network/vnet/peering) |
| Route tables and spoke forced tunnel | `learning-paths/lp06-capstone-final-project/artifacts/04-routing.bicep` | `az network route-table` and `az network nic show-effective-route-table` | [Azure CLI route-table](https://learn.microsoft.com/en-us/cli/azure/network/route-table) |
| NSGs and baseline network controls | `learning-paths/lp06-capstone-final-project/artifacts/05-nsg.bicep` | `az network nsg` | [Azure CLI nsg](https://learn.microsoft.com/en-us/cli/azure/network/nsg) |
| VPN gateway | `learning-paths/lp06-capstone-final-project/artifacts/06-vpn-gateway.bicep` | `az network vnet-gateway` | [Azure CLI vnet-gateway](https://learn.microsoft.com/en-us/cli/azure/network/vnet-gateway) |
| Local network gateway and S2S connection | `learning-paths/lp06-capstone-final-project/artifacts/07-vpn-connection.bicep` | `az network local-gateway` and `az network vpn-connection` | [Azure CLI local-gateway](https://learn.microsoft.com/en-us/cli/azure/network/local-gateway) |
| OPNsense marketplace deployment notes (portal step) | `learning-paths/lp06-capstone-final-project/artifacts/08-opnsense-marketplace.md` | Portal deployment and post-check via `az vm`/`az network nic` | [Azure CLI vm](https://learn.microsoft.com/en-us/cli/azure/vm) |
| OPNsense hardening checklist | `learning-paths/lp06-capstone-final-project/evidence/opnsense-hardening-checklist.md` | OPNsense web console procedure | [OPNsense hardening](https://docs.opnsense.org/manual/hardening.html) |
| OPNsense firewall policy export | `learning-paths/lp06-capstone-final-project/evidence/opnsense-firewall-rules.csv` | OPNsense firewall and NAT policy operations | [OPNsense firewall](https://docs.opnsense.org/manual/firewall.html) |
| Spoke validation VM | `learning-paths/lp06-capstone-final-project/artifacts/09-spoke-vm.bicep` | `az vm` | [Azure CLI vm](https://learn.microsoft.com/en-us/cli/azure/vm) |
| Hub validation endpoint VM | `learning-paths/lp06-capstone-final-project/artifacts/10-hub-validation-vm.bicep` | `az vm` | [Azure CLI vm](https://learn.microsoft.com/en-us/cli/azure/vm) |
| Managed identity and RBAC | `learning-paths/lp06-capstone-final-project/artifacts/11-identity-rbac.bicep` | `az identity` and `az role assignment` | [Azure CLI identity](https://learn.microsoft.com/en-us/cli/azure/identity) |
| Policy assignments and exemptions | `learning-paths/lp06-capstone-final-project/artifacts/12-policy.bicep` | `az policy assignment` and `az policy exemption` | [Azure CLI policy assignment](https://learn.microsoft.com/en-us/cli/azure/policy/assignment) |
| Locks | `learning-paths/lp06-capstone-final-project/artifacts/13-locks.bicep` | `az lock` | [Azure CLI lock](https://learn.microsoft.com/en-us/cli/azure/lock) |
| Storage account and protection controls | `learning-paths/lp06-capstone-final-project/artifacts/14-storage.bicep` | `az storage account` | [Azure CLI storage account](https://learn.microsoft.com/en-us/cli/azure/storage/account) |
| Private endpoints and private DNS | `learning-paths/lp06-capstone-final-project/artifacts/15-private-endpoints.bicep` | `az network private-endpoint` and `az network private-dns` | [Azure CLI private-endpoint](https://learn.microsoft.com/en-us/cli/azure/network/private-endpoint) |
| Log Analytics workspace | `learning-paths/lp06-capstone-final-project/artifacts/16-log-analytics.bicep` | `az monitor log-analytics workspace` | [Azure CLI log-analytics workspace](https://learn.microsoft.com/en-us/cli/azure/monitor/log-analytics/workspace) |
| Diagnostic settings | `learning-paths/lp06-capstone-final-project/artifacts/17-diagnostic-settings.sh` | `az monitor diagnostic-settings` | [Azure CLI diagnostic-settings](https://learn.microsoft.com/en-us/cli/azure/monitor/diagnostic-settings) |
| Alerts and action groups | `learning-paths/lp06-capstone-final-project/artifacts/18-alerts.bicep` | `az monitor metrics alert` and `az monitor action-group` | [Azure CLI metrics alert](https://learn.microsoft.com/en-us/cli/azure/monitor/metrics/alert) |
| Recovery Services vault and backup policy | `learning-paths/lp06-capstone-final-project/artifacts/19-backup.bicep` | `az backup` | [Azure CLI backup](https://learn.microsoft.com/en-us/cli/azure/backup) |
| End-to-end validation script | `learning-paths/lp06-capstone-final-project/artifacts/validate-capstone.sh` | `az network`, `az vm run-command`, and route checks | [Azure CLI network nic](https://learn.microsoft.com/en-us/cli/azure/network/nic) |
| PowerShell orchestration equivalent | `learning-paths/lp06-capstone-final-project/artifacts/Deploy-Capstone.ps1` | `Az.Network`, `Az.Resources`, `Az.Monitor`, `Az.RecoveryServices` | [Azure PowerShell Az](https://learn.microsoft.com/en-us/powershell/azure/new-azureps-module-az) |

### Command Set Quick Links
- Azure CLI root reference: [learn.microsoft.com/en-us/cli/azure](https://learn.microsoft.com/en-us/cli/azure/)
- Azure CLI sample index: [learn.microsoft.com/en-us/cli/azure/reference-index](https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)
- Azure PowerShell Az reference: [learn.microsoft.com/en-us/powershell/module/az](https://learn.microsoft.com/en-us/powershell/module/az/)
- Bicep reference: [learn.microsoft.com/en-us/azure/azure-resource-manager/bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

## Phase-by-Phase Implementation

## Phase 0 - Initialize Context and Baseline
1. Set subscription context and verify active tenant.
2. Create working folders:
  - `./artifacts`
  - `./evidence`
3. Define core variables (subscription, region, naming prefix, hub/spoke CIDRs).

Example CLI baseline:

```bash
SUB_ID="<subscription-id>"
LOC="eastus2"
PREFIX="az104lz-team1-dev-eus2"

az account set --subscription "$SUB_ID"
az account show -o table
az group create -n "rg-${PREFIX}-hub" -l "$LOC"
az group create -n "rg-${PREFIX}-spoke-prod" -l "$LOC"
az group create -n "rg-${PREFIX}-spoke-shared" -l "$LOC"
```

## Phase 1 - Governance Foundation (LP01)
1. Create custom and built-in role assignment plan:
  - Platform admin group at subscription scope
  - App ops group at spoke RG scope
  - Reader/audit roles for monitoring scope
2. Apply tagging policy in `Audit`, validate, then promote controlled scopes to `Deny`.
3. Add lock strategy:
  - `CanNotDelete` on hub RG and critical shared services
4. Capture evidence:
  - role assignments
  - policy compliance snapshot
  - lock inventory

## Phase 2 - Core Network Fabric (LP04)
1. Deploy hub and spoke VNets with subnets.
2. Create VNet peering (hub<->spoke-prod, hub<->spoke-shared).
3. Attach route tables for spoke subnets with default route (`0.0.0.0/0`) targeting NVA LAN IP.
4. Deploy VPN Gateway in hub `GatewaySubnet`.
5. Validate effective routes and next hop behavior.

Minimum route controls:
- No user-defined next hop from spoke directly to Internet
- Spoke subnet route table must force-tunnel all egress to hub NVA
- Effective route check on spoke NIC must show default route via virtual appliance

## Phase 3 - OPNsense NVA Deployment (Portal Exception)
Use the portal only for this step.

1. Go to Azure Marketplace and deploy OPNsense (publisher image approved by your program).
2. Place OPNsense NICs in hub VNet:
  - WAN/Untrusted interface subnet (transit perimeter)
  - LAN/Trusted interface subnet (toward spokes)
3. Disable source/destination check if required by image guidance.
4. Assign static private IPs to NVA interfaces.
5. Record management public IP and admin credentials in secure notes.

After provisioning, return to command-first workflow.

## Phase 4 - OPNsense Initial Hardening and Gateway Configuration
Login to OPNsense Web UI (HTTPS management endpoint) and complete:

1. Update firmware
  - System -> Firmware -> Check and apply latest stable updates
  - Reboot if required

2. Baseline hardening
  - Change default admin password
  - Set NTP and correct timezone
  - Restrict management access to admin subnet/public source allowlist
  - Disable insecure management services not in use

3. Interface and gateway setup
  - Confirm WAN/LAN interface assignments
  - Set static LAN gateway behavior for spoke return paths
  - Enable packet forwarding

4. NAT policy
  - Do not provide broad outbound NAT for spoke workloads
  - If NAT is required for controlled updates, use explicit temporary rules and remove after validation

5. Firewall rule model (best-practice starting point)
  - Default deny all inbound and inter-zone
  - Explicit allow for:
    - Hub management subnet -> OPNsense management ports (HTTPS/SSH as approved)
    - Spoke workloads -> hub services and explicitly approved Azure service destinations only
    - DNS/NTP required flows
    - Spoke VM -> hub validation endpoints (ICMP/TCP test targets)
  - Explicit deny for spoke -> Internet (`0.0.0.0/0`) and log all hits
  - Explicit deny and log for prohibited flows
  - Enable logging on critical allow and deny rules

6. Optional IDS/IPS (if SKU/performance allows)
  - Enable with conservative baseline policy
  - Monitor false positives before strict mode

7. Backup OPNsense config
  - Export encrypted configuration to `evidence/opnsense-config-backup.xml`

## Phase 5 - Platform Services and Connectivity Validation (LP02 + LP03 + LP04)
1. Storage in spoke-shared:
  - Secure storage accounts (TLS min, HTTPS-only)
  - Private endpoints as applicable
  - Lifecycle + soft delete + versioning where required
2. Compute in spoke-prod:
  - Deploy at least one validation VM in spoke-prod subnet (`vm-spoke-validation-01`)
  - Deploy one lightweight validation endpoint in hub (`vm-hub-validation-01` or equivalent test target)
  - NSGs and route tables enforce NVA path
3. Identity and secrets:
  - Managed identity for workload access
  - RBAC at minimal required scope
4. Validate required connectivity behavior from spoke VM:
  - Expected success: spoke VM -> hub endpoint
  - Expected failure: spoke VM -> Internet endpoint

Suggested validation commands (run from spoke VM):

```bash
# Should succeed (replace with your hub endpoint IP/hostname)
ping -c 4 <hub-validation-ip>
nc -zv <hub-validation-ip> 22

# Should fail by policy
curl -I https://www.microsoft.com --max-time 10
curl -I https://www.bing.com --max-time 10
```

Capture both successful hub path and blocked internet attempts in logs and evidence.

## Phase 6 - Monitoring, Alerts, and Backup (LP05)
1. Create or assign Log Analytics workspace.
2. Enable diagnostics for network gateway, NVA VM, and critical resources.
3. Create alert rules:
  - VPN tunnel state
  - NVA VM health/perf
  - denied-flow spikes (where telemetry is available)
4. Configure Recovery Services vault and backup policies for critical compute.
5. Run and document at least one restore validation.

## Validation Checklist
- Hub and spokes are peered and routing is deterministic
- Spoke default route points to OPNsense transit IP
- Spoke validation VM exists in spoke subnet and can reach hub validation target
- Spoke validation VM cannot reach public internet destinations
- VPN Gateway is operational and tunnel is established
- OPNsense firmware updated and admin baseline hardened
- Firewall default deny with explicit least-privilege rules enforced
- Policy/tag/lock baseline active with compliance evidence
- Monitoring alerts trigger and action groups notify
- Backup and restore test completed successfully

## Required Deliverables
- `evidence/topology-diagram.md` (or image)
- `evidence/rbac-matrix.csv`
- `evidence/policy-compliance.json`
- `evidence/route-table-exports.json`
- `evidence/vpn-gateway-status.json`
- `evidence/opnsense-hardening-checklist.md`
- `evidence/opnsense-firewall-rules.csv`
- `evidence/spoke-vm-effective-routes.json`
- `evidence/spoke-to-hub-connectivity.txt`
- `evidence/spoke-to-internet-blocked.txt`
- `evidence/storage-protection-validation.md`
- `evidence/compute-access-validation.md`
- `evidence/alerts-validation.md`
- `evidence/backup-restore-proof.md`
- `evidence/capstone-runbook.md`

## Acceptance Criteria
- Topology matches hub-and-spoke design with VPN and NVA transit
- Non-portal implementation used except Marketplace NVA deployment
- Spoke VM is deployed and validated for forced tunnel behavior
- Spoke to hub connectivity succeeds and spoke to internet is blocked
- Governance controls are enforced and evidenced
- OPNsense is updated, hardened, and functioning as security gateway
- At least one blocked flow and one allowed flow are demonstrated with logs
- Monitoring and backup controls are operational and validated

## Troubleshooting Guide
- Traffic bypasses NVA:
  - Verify spoke UDR next hop and subnet association
  - Check peering flags and effective routes
- Tunnel down:
  - Verify shared key, local network gateways, and on-prem endpoint reachability
- Asymmetric routing:
  - Validate return routes on NVA and Azure route tables
- OPNsense management unavailable:
  - Confirm NSG/OPNsense management allow rules and source IP restrictions
- Policy blocking expected deployment:
  - Validate assignment scope and exemption strategy before changes

## Instructor Notes
- Require students to justify each allow rule in terms of business need.
- Penalize broad wildcard allows where a narrower scope is possible.
- Require proof of rollback-safe changes for security and routing updates.
