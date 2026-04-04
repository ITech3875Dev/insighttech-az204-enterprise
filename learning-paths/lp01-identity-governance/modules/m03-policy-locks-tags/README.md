# M03 — Azure Policy, Locks, and Tags (Enterprise Governance)

## Module Overview
| Item | Details |
|------|----------|
| **Duration** | Beginner: ~60 min \| Intermediate: ~75 min \| Advanced: ~120 min |
| **Prerequisites** | M01-M02 recommended (Policy deploys at RG+ scope) |
| **Difficulty** | All tiers available |
| **Labs** | 5 hands-on labs (1 Beginner, 3 Intermediate, 1 Advanced) |

## Learning Outcomes
You will:
- Assign a policy to require standard tags (Audit → Deny pattern)
- Assign an allowed locations policy (East US 2 only)
- Create a resource lock to prevent accidental deletion
- Verify compliance and understand exemptions
- Produce a tagging compliance report using shared scripts
- Apply deny-by-policy pattern in production-like scenarios

See [objectives.md](objectives.md) for full AZ-104 skill mapping.

## Prerequisites & Permissions
- **Subscription**: Non-production Azure lab subscription with resource group
- **RBAC permissions**:
  - Policy assignment: Resource Policy Contributor (or Owner)
  - Locks: Contributor or Owner on RG
- **Prior knowledge**: M01 (RBAC scope), M02 (MG hierarchy)
- **Tools**: Portal, Azure CLI, PowerShell Az

## Accessibility & Support
- **Portal labs**: Full keyboard navigation; sorting/filtering accessible
- **CLI labs**: Use `--output json` for compliance report parsing
- **Bicep labs**: Infrastructure-as-code option for policy-as-code preference
- **Playbook**: Policy compliance troubleshooting guide ([policy-compliance-troubleshooting.md](../../../docs/program/playbooks/policy-compliance-troubleshooting.md))

## Self-Assessment Path
1. **Prerequisite**: Take [knowledge-check-pre.md](knowledge-check-pre.md) on policy + tagging concepts
2. **Labs**: Beginner (simple tag policy) → Intermediate (deny + remediation + reports) → Advanced (policy-as-code)
3. **Compliance report**: Run shared scripts ([shared/scripts/pwsh/validation/tag-compliance-report.ps1](../../../shared/scripts/pwsh/validation/tag-compliance-report.ps1))
4. **Exit**: [knowledge-check-post.md](knowledge-check-post.md) (~15 min)

## Deliverables (Definition of Done)
- ✅ Pre-module knowledge check completed
- ✅ Policy assignment evidence (CLI + PowerShell)
- ✅ Failed + successful deployment evidence (Deny behavior)
- ✅ Lock evidence
- ✅ Tag compliance report outputs (CSV + JSON)
- ✅ Validation script returns `PASS`
- ✅ Post-module knowledge check ≥70%
