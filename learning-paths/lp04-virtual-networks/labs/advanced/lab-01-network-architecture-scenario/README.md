# Advanced Lab 01 - Network Architecture Scenario

## Difficulty
- Advanced

## Time Estimate
- 90 to 150 minutes

## Scenario
You are designing segmented virtual network architecture with secure routing, controlled connectivity, and deterministic inspection paths.

## Architecture Goals
1. Define hub/spoke (or equivalent) segmentation intent.
2. Implement peering and route-table behavior with explicit next hops.
3. Validate allow/deny traffic behavior across network boundaries.
4. Document rollback-safe network operations.

## Constraints
- Use built-in roles where possible.
- Assign at the lowest scope that satisfies requirements.
- All created resources must include required tags.
- Document one break-glass path for emergencies.

## Required Deliverables
- architecture-diagram.md
- network-flow-validation.md
- implementation-evidence-cli.txt
- implementation-evidence-pwsh.txt
- validation-results.md
- design-rationale.md
- rollback-plan.md

## Task 1 - Design Network Topology and Scope Model
Define:
 - network segmentation and routing intent
 - ownership boundaries by resource group
 - expected inter-segment communication paths

Record route intent and control points in `network-flow-validation.md`.

## Task 2 - Implement Network Baseline
Apply network resources and controls with CLI and PowerShell.

CLI sample:

```bash
az network vnet create -g <rg> -n <hub-vnet> --address-prefixes 10.10.0.0/16
az network vnet subnet create -g <rg> --vnet-name <hub-vnet> -n AzureFirewallSubnet --address-prefixes 10.10.1.0/24
az network route-table create -g <rg> -n <spoke-udr>
az network route-table route create -g <rg> --route-table-name <spoke-udr> -n defaultToInspection --address-prefix 0.0.0.0/0 --next-hop-type VirtualAppliance --next-hop-ip-address <nva-ip>
```

PowerShell sample:

```powershell
$rt = New-AzRouteTable -Name <spoke-udr> -ResourceGroupName <rg> -Location <location>
Add-AzRouteConfig -Name defaultToInspection -AddressPrefix 0.0.0.0/0 -NextHopType VirtualAppliance -NextHopIpAddress <nva-ip> -RouteTable $rt
Set-AzRouteTable -RouteTable $rt
```

## Task 3 - Validate Allowed and Denied Connectivity
Run one allowed and one denied connectivity test for each critical path.

Example matrix:

| Validation | Expected | Evidence file |
|---|---|---|
| Approved network flow | Success | validation-results.md |
| Prohibited network flow | Denied | validation-results.md |

## Task 4 - Add Governance Controls
1. Assign required-tag policy at selected scope.
2. Validate policy impact on test deployment.
3. Record whether policy should be Audit or Deny and why.

## Task 5 - Document Network Operations Pattern
In design-rationale.md include:
- routing change controls
- rollback and revalidation sequence
- incident triage checkpoints

## Acceptance Criteria
- Role assignments map exactly to requirements
- No day-to-day Owner at subscription scope
- Allowed/denied behavior is demonstrated with evidence
- Governance policy behavior is demonstrated
- Design rationale explains scope decisions and blast-radius control

## Grading Guidance (100 points)
- 30: RBAC design quality
- 20: Implementation correctness
- 20: Validation evidence quality
- 15: Governance control integration
- 15: Rationale and rollback quality

## Submission Checklist
- All required artifacts present
- All command outputs included
- No secrets or credentials in evidence files
- Reviewer can reproduce design intent from documentation only
