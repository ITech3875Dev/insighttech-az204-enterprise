# AZ-204 LP03 — Implement Azure Security

## Audience
Intermediate developers who have completed LP01 (compute) and LP02 (storage) or have equivalent hands-on Azure experience. Students should be comfortable with the Azure CLI and Python.

## Learning Outcomes
By completing this path, you will be able to:
- Authenticate users and applications using the Microsoft Identity Platform and MSAL.
- Implement OAuth 2.0 authorization code and client credentials flows.
- Provision and consume Azure Key Vault secrets, keys, and certificates from application code.
- Configure managed identities (system-assigned and user-assigned) to eliminate stored credentials.
- Apply Shared Access Signatures and stored access policies to delegate scoped storage access.
- Enforce App Configuration feature flags and secure reference to Key Vault.
- Validate the security posture of deployed resources using Azure CLI checks.

## Delivery Model
| Format | Duration | Notes |
|--------|----------|-------|
| Instructor-led | 2 × 3-hour sessions | Cover M01 (session 1) and M02 (session 2) |
| Self-paced | 8–10 hours | Complete modules, labs, then practice exam |
| Masterclass | 2 hours | CLI-driven deep-dive on Key Vault and managed identity |

## Modules
| # | Module | Core Topic | Duration |
|---|--------|-----------|---------|
| M01 | [Authentication and Authorization](modules/m01-authentication-and-authorization/README.md) | Microsoft Identity Platform, MSAL, OAuth 2.0, SAS | ~120 min |
| M02 | [Key Vault and Managed Identity](modules/m02-key-vault-and-managed-identity/README.md) | Key Vault SDK, managed identity, App Configuration | ~120 min |

## Lab Sequence
| Tier | Lab | Topic |
|------|-----|-------|
| Beginner | [lab-01-key-vault-secret-access](labs/beginner/lab-01-key-vault-secret-access/README.md) | Provision Key Vault, store and retrieve a secret via Python SDK |
| Intermediate | [lab-01-managed-identity-and-rbac](labs/intermediate/lab-01-managed-identity-and-rbac/README.md) | Assign managed identity to a compute resource; use RBAC to authorize Key Vault access |
| Advanced | [lab-01-oauth-and-app-registration](labs/advanced/lab-01-oauth-and-app-registration/README.md) | Register an Entra ID application; implement client credentials flow; scope API access |
| Capstone | [lab-01-security-solutions-production-readiness](labs/capstone/lab-01-security-solutions-production-readiness/README.md) | End-to-end credential-free application using managed identity + Key Vault + App Configuration |

## Masterclass
| Track | Format | Link |
|-------|--------|------|
| CLI | CLI-driven session | [masterclass/cli/README.md](masterclass/cli/README.md) |

## Assessment
| Asset | Link |
|-------|------|
| Practice Exam (50 Q) | [exams/practice-50q.md](exams/practice-50q.md) |
| Answer Key | [exams/answer-key.md](exams/answer-key.md) |

## Validation
Run the LP03 validation script after completing all labs to confirm your Azure resources are configured correctly:

```powershell
.\validation\az204-lp03-validate.ps1 `
  -SubscriptionId "<your-sub-id>" `
  -ResourceGroupName "rg-az204-lp03" `
  -KeyVaultName "kv-az204-lp03" `
  -SecretName "db-connection-string" `
  -AppConfigName "appconfig-az204-lp03"
```

## Definition of Done
- [ ] You can explain the difference between managed identity and service principal authentication.
- [ ] You provisioned Key Vault, stored a secret, and retrieved it from Python code without a hardcoded credential.
- [ ] You assigned a system-assigned managed identity to a compute resource and authorized Key Vault access via a RBAC role assignment.
- [ ] You registered an Entra ID application, obtained an access token using client credentials, and called a protected API.
- [ ] The LP03 validation script exits with `[RESULT] PASS`.
- [ ] You scored ≥70% on the practice exam or completed post-exam remediation.
- [ ] You can describe how SAS tokens scope access to Azure Storage without sharing account keys.
