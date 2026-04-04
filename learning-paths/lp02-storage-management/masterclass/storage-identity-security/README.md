# Modern Identity Masterclass - LP02 Extension

## Purpose
Build practical skill with modern Azure identity patterns used in production environments:
- managed identities for workloads
- workload identity federation for CI/CD
- least-privilege authorization and auditing

## Time Estimate
- 3 to 5 hours

## Prerequisites
- LP02 M01 fundamentals complete
- Azure CLI and PowerShell Az installed
- Access to a non-production subscription
- Access to at least one CI platform (GitHub or GitLab)

## Learning Outcomes
1. Implement system-assigned and user-assigned managed identities
2. Grant and validate least-privilege RBAC for identities
3. Configure OIDC federation for CI/CD without client secrets
4. Diagnose common identity failures and fix them safely
5. Produce clear evidence for audit and peer review

## Setup

### Azure CLI baseline
```bash
SUB_ID="<subscription-id>"
az account set --subscription "$SUB_ID"
az account show -o table
```

## Exercises

### Lab 1 - System-Assigned Managed Identity
Goal:
- attach system-assigned identity to a VM or App Service
- grant read access to a target resource
- verify token-based access succeeds

Key checks:
- identity principal exists
- role assignment scope is correct
- request succeeds without credential files

### Lab 2 - User-Assigned Managed Identity
Goal:
- create one user-assigned identity
- attach it to multiple resources
- confirm centralized lifecycle and access behavior

Key checks:
- both resources share the same identity principal
- role grants are least privilege
- removing role assignment immediately affects access

### Lab 3 - Identity Troubleshooting Drill
Goal:
- intentionally break access
- diagnose root cause
- apply minimal corrective change

Failure patterns to test:
- missing role assignment
- wrong scope assignment
- stale context or wrong tenant

### Lab 4 - GitHub OIDC Federation
Goal:
- configure federated credential on app registration
- authenticate GitHub Actions to Azure without secrets
- deploy a test resource through workflow

Minimum workflow requirements:
- no client secret in repository
- constrained subject claim (repo/branch)
- deployment output captured as artifact

### Lab 5 - Terraform or GitLab OIDC Federation
Goal:
- implement second platform federation path
- compare issuer and claim configuration differences
- validate same deployment outcome

### Lab 6 - Security and Audit Review
Goal:
- inspect activity logs and role assignments
- identify over-privileged grants
- document remediation actions

## Command Patterns

### Managed identity validation
```bash
az identity list -g "<rg-name>" -o table
az role assignment list --assignee "<principal-id>" -o table
```

### OIDC federation validation
```bash
az ad app federated-credential list --id "<app-object-id>" -o table
```

## Required Deliverables
- `evidence/mi-system-assigned.txt`
- `evidence/mi-user-assigned.txt`
- `evidence/mi-troubleshooting.md`
- `evidence/oidc-github-workflow.yml`
- `evidence/oidc-platform2-notes.md`
- `evidence/activity-log-identity.json`
- `evidence/storage-identity-security-summary.md`

## Acceptance Criteria
- At least one system-assigned and one user-assigned identity validated
- At least one OIDC pipeline flow validated without secrets
- All role assignments justified by least-privilege rationale
- Troubleshooting drill includes root cause, fix, rollback
- Evidence package is complete and reviewer-readable

## Common Troubleshooting
- access denied after identity setup:
  - verify role assignment principal and scope
  - wait for propagation and re-test
- OIDC login fails in CI:
  - verify issuer, audience, and subject claim match exactly
- command executes in wrong tenant:
  - verify active context before every critical step

## Alignment Notes
This track strengthens AZ-104 identity/governance readiness while reflecting current enterprise patterns for passwordless automation.
