# M02 — Management Groups & Subscription Organization

## Module Overview
| Item | Details |
|------|----------|
| **Duration** | Beginner: ~45 min \| Intermediate: ~50 min \| Advanced: ~90 min |
| **Prerequisites** | M01 completion recommended |
| **Difficulty** | All tiers available |
| **Labs** | 4 hands-on labs (1 Beginner, 2 Intermediate, 1 Advanced) |

## Learning Outcomes
You will:
- Create an enterprise management group hierarchy
- Move a subscription into a management group (or validate instructor-provided placement)
- Assign RBAC at management group scope and verify inheritance
- Troubleshoot RBAC scope inheritance across MG→Sub→RG→Resource
- Validate via Portal + CLI + PowerShell + script

See [objectives.md](objectives.md) for full AZ-104 skill mapping.

## Prerequisites & Permissions
- **Subscription**: Non-production Azure lab subscription
- **RBAC permissions**:
  - Management group operations: Elevated MG permissions (Owner or Management Group Contributor)
  - If unavailable: Instructor will provide MG names and pre-place subscription
- **Prior knowledge**: M01 RBAC concepts (scope, role assignment)
- **Tools**: Azure Portal, Azure CLI, PowerShell Az

## Accessibility & Support
- **Portal labs**: Keyboard-navigable; high-contrast mode supported
- **CLI labs**: JSON output option for accessibility
- **Troubleshooting**: Playbook provided ([playbooks/rbac-scope-troubleshooting.md](../../../docs/program/playbooks/rbac-scope-troubleshooting.md))

## Self-Assessment Path
1. **Prerequisite check**: Complete M01 or take [knowledge-check-pre.md](knowledge-check-pre.md)
2. **Labs**: Beginner (hierarchy creation) → Intermediate (inheritance + troubleshooting) → Advanced (design scenario)
3. **Validate**: Script confirms MG structure and RBAC assignment
4. **Exit**: [knowledge-check-post.md](knowledge-check-post.md) (~10 min)

## Deliverables (Definition of Done)
- ✅ Pre-module knowledge check completed
- ✅ Portal/CLI/PowerShell labs reproducible
- ✅ MG hierarchy and subscription placement evidenced
- ✅ RBAC inheritance verified at MG scope
- ✅ Validation script returns `PASS`
- ✅ Post-module knowledge check ≥70%
