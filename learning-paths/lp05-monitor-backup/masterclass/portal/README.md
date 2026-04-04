# Portal Exception Guide — LP05 Landing Zone Capstone

## Purpose
Use Azure Portal only for deploying the OPNsense Network Virtual Appliance (NVA) from Marketplace. All other capstone steps are completed with CLI, PowerShell, and Bicep.

## Time Estimate
- 30 to 45 minutes

## Scope
- In scope: OPNsense Marketplace deployment and initial access verification
- Out of scope: governance, routing, policy, monitoring, and backup configuration (done via command workflows)

## Prerequisites
- Hub VNet and required subnets already deployed
- Resource group for transit services exists
- Approved OPNsense image/publisher in your program policy

## Required Inputs
- Hub resource group name
- Hub VNet name
- WAN subnet name
- LAN/transit subnet name
- Region
- Admin username/password (stored securely)

## Deployment Steps (Portal)
1. Open Azure Marketplace and search for OPNsense.
2. Select the approved image and click Create.
3. Choose subscription, hub RG, and region.
4. Configure VM size according to lab guidance.
5. Configure networking:
   - NIC1 (WAN) in hub WAN/transit edge subnet
   - NIC2 (LAN) in hub internal transit subnet
6. Assign static private IPs for both NICs.
7. Configure or assign Public IP for management access if required by your lab policy.
8. Review and Create, then wait for deployment success.

## Post-Deployment Verification
1. Confirm VM provisioning state is Succeeded.
2. Confirm both NICs are attached and in expected subnets.
3. Confirm static private IP assignments are correct.
4. Confirm NSG rules allow approved management access only.
5. Record management endpoint and transition back to command workflow.

## Evidence to Capture
- `evidence/portal-opnsense-deployment-summary.png`
- `evidence/portal-opnsense-nics.png`
- `evidence/portal-opnsense-ip-config.png`
- `evidence/portal-opnsense-provisioning-state.png`

## Acceptance Criteria
- OPNsense deployed successfully from Marketplace
- Dual-NIC placement and static IP plan match topology design
- Management access is restricted to approved source range
- Student exits portal and continues with non-portal capstone phases
