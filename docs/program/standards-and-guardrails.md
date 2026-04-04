# Standards and Guardrails (Enterprise)

## Non-negotiables
1. No secrets in repo.
2. Official references only (Microsoft Learn / Microsoft Docs).
3. Every module must include:
   - objectives.md
   - portal-lab.md
   - cli-lab.md
   - pwsh-lab.md
   - bicep-lab.md (where applicable)
   - validation script(s)
   - references.md

## Required Tags (if resources are created)
Owner, CostCenter, Environment, Workload, DataClass, ExpirationDate

## Naming convention (baseline)
- Resource Group: rg-<workload>-<domain>-<env>-<region>-<##>
- VNet: vnet-<workload>-<env>-<region>-<##>
- Subnet: snet-<tier>-<env>-<region>-<##>

## Beginner track standard
- Step-by-step portal click path
- Copy/paste Az CLI and PowerShell
- Verification + troubleshoot steps per task

## Enterprise enhancements (Domain 1)
Domain 1 labs must incorporate:
- Inheritance/scope troubleshooting (see `docs/program/playbooks/rbac-scope-troubleshooting.md`)
- Policy compliance troubleshooting (see `docs/program/playbooks/policy-compliance-troubleshooting.md`)
- Least privilege design rationale (Advanced track)
- Break-glass operational pattern (Intermediate/Advanced track)
- Tagging compliance reporting scripts (shared scripts)
