# M02 — Key Vault and Managed Identity

## Module Overview
| Item | Details |
|------|---------|
| **Duration** | ~120 minutes |
| **Difficulty** | Intermediate |
| **Services** | Azure Key Vault, Managed Identity, Azure App Configuration, Azure CLI |
| **Labs** | Advanced: OAuth + app registration; Capstone: credential-free app |

## Module Flow
1. Key Vault resource model — vaults, secrets, keys, certificates, RBAC vs. access policies
2. Secret lifecycle — create, retrieve, rotate, expire, soft-delete, purge-protect
3. System-assigned vs. user-assigned managed identities — lifecycle and use cases
4. Authorizing managed identity access — Key Vault Secrets User RBAC role assignment
5. Azure App Configuration — feature flags, Key Vault references
6. Hands-on: provision vault, store secret, retrieve from Python with no stored credential

## Learning Outcomes
By the end of this module, you will be able to:
- Provision an Azure Key Vault and store a secret using the Azure CLI.
- Retrieve a secret from Key Vault in Python using `SecretClient` with `DefaultAzureCredential`.
- Enable a system-assigned managed identity on a compute resource and assign the Key Vault Secrets User role.
- Configure soft-delete and purge protection on a Key Vault for production safety.
- Create an App Configuration store and add a Key Vault reference.

## Required Deliverables
| # | Deliverable | Acceptance Criteria |
|---|------------|-------------------|
| D1 | Key Vault with secret | Secret visible via `az keyvault secret show`; no plaintext credential in code |
| D2 | Managed identity RBAC assignment | `az role assignment list` shows Key Vault Secrets User on vault scope |
| D3 | Python retrieval script | Script uses `DefaultAzureCredential`; secret value printed; no credential in code |

## Associated Labs
- [Advanced — OAuth and App Registration](../../labs/advanced/lab-01-oauth-and-app-registration/README.md)
- [Capstone — Security Solutions Production Readiness](../../labs/capstone/lab-01-security-solutions-production-readiness/README.md)

## Exit Criteria
- Student can describe the Key Vault RBAC model vs. access policies.
- Student can enable and assign a managed identity without using a password or secret.
- Student can explain when to use `DefaultAzureCredential` vs. an explicit credential class.
