# M04 — Cost Management + Advisor Governance (Enterprise)

## Module Overview
| Item | Details |
|------|----------|
| **Duration** | Beginner: ~40 min \| Intermediate: ~50 min \| Advanced: ~N/A (included in integration lab) |
| **Prerequisites** | M01-M03 recommended (budget filters use resource groups + tags) |
| **Difficulty** | Beginner + Intermediate available |
| **Labs** | 2 hands-on labs (1 Beginner, 1 Intermediate) |

## Learning Outcomes
You will:
- Create a monthly cost budget with alerts
- Use cost analysis views and filters (RG + tags)
- Review Azure Advisor recommendations and categorize actions
- Understand resource tagging impact on cost allocation
- Produce evidence and run validation

See [objectives.md](objectives.md) for full AZ-104 skill mapping.

## Prerequisites & Permissions
- **Subscription**: Non-production Azure lab subscription
- **RBAC required**: At minimum Reader; some views may require Billing Account Reader
- **Cost Management visibility**: Depends on billing model; may take 24–48 hours for data
- **Prior knowledge**: M01 (RBAC), M03 (tagging, resource groups)
- **Tools**: Portal, Azure CLI, PowerShell Az

## Accessibility & Support
- **Portal labs**: Cost graphs support data export (CSV/JSON for screenreaders)
- **CLI labs**: `--output json` for machine-readable analysis
- **Limitations**: Cost data may not appear for brand-new resources; use test resources from prior labs

## Self-Assessment Path
1. **Prerequisite**: Take [knowledge-check-pre.md](knowledge-check-pre.md) on cost/advisor concepts
2. **Labs**: Beginner (budget creation) → Intermediate (cost analysis by tag + advisor integration)
3. **Validate**: Script confirms budget and cost data retrieval
4. **Exit**: [knowledge-check-post.md](knowledge-check-post.md) (~10 min)

## Deliverables (Definition of Done)
- ✅ Pre-module knowledge check completed
- ✅ Budget created (Portal + CLI/PowerShell evidence)
- ✅ Cost analysis screenshot or export evidence
- ✅ Advisor recommendations evidenced (query output if none exist)
- ✅ Validation script returns `PASS`
- ✅ Post-module knowledge check ≥70%
