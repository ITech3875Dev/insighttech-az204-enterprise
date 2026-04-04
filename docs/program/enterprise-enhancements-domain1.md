# Enterprise Enhancements — Domain 1 (Identity & Governance)

These enhancements elevate AZ-104 Domain 1 from “cert prep” to **enterprise operations readiness**.
They reinforce **least privilege**, **governance at scale**, and **incident-safe operations**.

## Enhancement Set (Required)

### E1 — Inheritance & Scope Troubleshooting Labs
Students must diagnose access and policy behavior across:
- Management Group → Subscription → Resource Group → Resource
- RBAC inheritance and scope correctness
- Policy inheritance, exemptions, and compliance reasoning

**Deliverables**
- Intermediate troubleshooting lab with a broken scenario and “fix it” objective
- Reusable playbook checklists

### E2 — Least Privilege Design Challenge
Students must design RBAC to meet requirements with minimal privileges:
- Prefer built-in roles
- Assign at lowest scope that meets requirements
- Avoid broad rights (Owner/Contributor at subscription) unless required

**Deliverables**
- Advanced scenario + acceptance criteria
- Written design rationale (“why this role, why this scope”)

### E3 — Break-Glass & Privileged Access Operational Pattern
Introduce enterprise emergency access operations:
- Break-glass accounts (concept + controls)
- Separation of duties, approvals
- MFA/CA expectations and monitoring (conceptual where tenant constraints apply)

**Deliverables**
- Intermediate runbook + evidence (audit trail, activity log)

### E4 — Deny-by-Policy + Remediation/Exemption Pattern
Enforce governance using Azure Policy:
- Require tags
- Restrict locations/SKUs
- Audit vs Deny
- Remediation or exemption workflow where applicable

**Deliverables**
- Beginner: tag policy (Audit) + verify non-compliance
- Intermediate: Deny policy + corrected deployment OR exemption workflow
- Advanced: policy-as-code in Bicep (parameterized)

### E5 — Tagging Compliance Reporting Script
Students produce an audit-friendly compliance report:
- Enumerate RGs/resources
- Validate required tags
- Export CSV/JSON
- Provide remediation recommendations

**Deliverables**
- PowerShell + CLI scripts under `shared/scripts/*/validation/`
- Sample output format and evidence guidance

## Repo placement
- Labs:
  - `learning-paths/lp01-identity-governance/labs/intermediate/`
  - `learning-paths/lp01-identity-governance/labs/advanced/`
- Playbooks:
  - `docs/program/playbooks/`
- Scripts:
  - `shared/scripts/pwsh/validation/`
  - `shared/scripts/cli/validation/`
