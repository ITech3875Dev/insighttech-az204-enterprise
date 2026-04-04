# M01 — Users, Groups, and RBAC (Foundations)

## Module Overview
| Item | Details |
|------|----------|
| **Duration** | Beginner: ~50 min \| Intermediate: ~40 min \| Advanced: ~75 min |
| **Prerequisites** | AZ-104 Prerequisites module recommended |
| **Difficulty** | All tiers (Beginner: Lab-01; Intermediate: Labs-02; Advanced: N/A in LP01) |
| **Labs** | 3 hands-on labs (1 Beginner, 2 Intermediate) |

## Learning Outcomes
You will:
- Create a standard resource group with required tags
- Create/identify a Microsoft Entra security group
- Assign the **Reader** role to the group at **resource group scope**
- Verify assignments with Portal + Az CLI + PowerShell
- Run validation to prove completion

See [objectives.md](objectives.md) for full AZ-104 skill mapping.

## Prerequisites & Permissions
- **Subscription**: Non-production Azure lab subscription
- **RBAC permissions**:
  - Create RG: Contributor or Owner role
  - Assign roles: Owner or User Access Administrator role
  - Create Entra group: Entra Global Reader or Entra Roles Admin (if unavailable, instructor provides group Object ID)
- **Tools**: Azure Portal, Azure CLI, PowerShell Az
- **Prior knowledge**: Basic cloud computing terms; optional review of Microsoft Entra ID basics

## Accessibility & Support
- **Portal labs**: Full keyboard navigation; high-contrast mode supported
- **CLI labs**: Use `--output json` for screenreader compatibility
- **Bicep labs**: Automated deployment available for IaC preference
- **Time accommodations**: Extended time available; contact instructor

## Self-Assessment Path
1. **Start**: Take [knowledge-check-pre.md](knowledge-check-pre.md) (~5 min) to verify prerequisites
2. **Labs**: Follow labs in sequence (Beginner → Intermediate)
3. **Validate**: Run validation script; troubleshoot if needed
4. **Exit**: Take [knowledge-check-post.md](knowledge-check-post.md) (~10 min) to verify outcomes

## Deliverables (Definition of Done)
- ✅ Pre-module knowledge check completed (baseline)
- ✅ Portal lab steps reproducible and verified
- ✅ CLI lab commands execute successfully
- ✅ PowerShell lab commands execute successfully
- ✅ Validation script returns `PASS`
- ✅ Post-module knowledge check score ≥70%
- ✅ All references verified (official Microsoft Learn links)
