# M01 — Authentication and Authorization

## Module Overview
| Item | Details |
|------|---------|
| **Duration** | ~120 minutes |
| **Difficulty** | Intermediate |
| **Services** | Microsoft Entra ID, MSAL Python, Azure Storage (SAS) |
| **Labs** | Beginner: Key Vault secret access; Intermediate: Managed identity + RBAC |

## Module Flow
1. Microsoft Identity Platform concepts — tenants, apps, service principals, managed identities
2. OAuth 2.0 grant types — client credentials, authorization code, device code
3. MSAL for Python — `ConfidentialClientApplication`, `acquire_token_for_client()`
4. Shared Access Signatures — account SAS, service SAS, stored access policies
5. Delegated vs. application permissions; consent model
6. Hands-on: register app, acquire token, call Microsoft Graph

## Learning Outcomes
By the end of this module, you will be able to:
- Describe the Microsoft Identity Platform app model (application object vs. service principal).
- Implement the OAuth 2.0 client credentials flow using MSAL for Python.
- Generate a service SAS token with a stored access policy for scoped blob access.
- Distinguish delegated permissions from application permissions.
- Validate that a token contains expected claims (`aud`, `iss`, `roles`, `scp`).

## Required Deliverables
| # | Deliverable | Acceptance Criteria |
|---|------------|-------------------|
| D1 | Entra ID app registration | Application ID, client secret, and API permission recorded |
| D2 | MSAL token acquisition script | Script exits without error; token printed to console |
| D3 | SAS token validation | Blob URL with SAS returns 200; expired SAS returns 403 |

## Associated Labs
- [Beginner — Key Vault Secret Access](../../labs/beginner/lab-01-key-vault-secret-access/README.md)
- [Intermediate — Managed Identity and RBAC](../../labs/intermediate/lab-01-managed-identity-and-rbac/README.md)

## Exit Criteria
- Student can explain the OAuth 2.0 client credentials flow end-to-end.
- Student can generate and revoke a SAS token using a stored access policy.
- Student understands when to use managed identity vs. app registration.
