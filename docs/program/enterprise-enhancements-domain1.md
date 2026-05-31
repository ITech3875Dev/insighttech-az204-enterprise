# Enterprise Enhancements — AZ-204 Program

These enhancements elevate the AZ-204 training program from "cert prep" to **enterprise developer readiness**.
They reinforce **credential hygiene**, **security-first SDK patterns**, and **production operations discipline**.

---

## Enhancement Set (Required)

### E1 — Credential-Free Design Enforcement
All labs must use `DefaultAzureCredential` or equivalent managed-identity-based authentication.
No lab may instruct the student to hard-code secrets, connection strings, or client credentials in code.

**Standards**
- Key Vault referenced at runtime via URI; never injected as env vars
- `DefaultAzureCredential` used in all Python SDK labs
- Managed identity preferred over service principal where the compute supports it

**Deliverables**
- All lab READMEs include a `grep` or `rg` negative test verifying no hard-coded secrets
- Validation scripts assert RBAC auth (not access policies) on Key Vault

---

### E2 — SDK-First Lab Delivery
Labs must use the official Azure SDK for the target language (Python for LP01–LP03).
CLI-only labs are acceptable for infra provisioning; data-plane operations must use SDK.

**Standards**
- LP01: `azure-functions`, `azure-mgmt-web` for data-plane operations
- LP02: `azure-storage-blob`, `azure-cosmos` for data-plane operations
- LP03: `azure-keyvault-secrets`, `azure-identity`, `msal` for security operations
- LP04+: `azure-monitor-query`, `azure-servicebus`, `azure-eventgrid`

**Deliverables**
- Each module README documents required Python packages
- Beginner labs include full working code snippets using the SDK

---

### E3 — Least Privilege Role Assignment Pattern
Every role assignment in a lab must use the minimum role that meets the requirement.
Students must articulate *why* a role was chosen in the lab checklist or capstone write-up.

**Standards**
- Key Vault: use `Key Vault Secrets User` (not Administrator or Contributor)
- Blob Storage: use `Storage Blob Data Reader` / `Storage Blob Data Contributor` (not account key)
- App Configuration: use `App Configuration Data Reader` (not Owner)
- Assignments scoped to the resource, not the resource group or subscription, where possible

**Deliverables**
- Advanced and capstone lab checklists include a "role justification" line
- Validation scripts verify specific role names, not broad roles

---

### E4 — Production Hardening Checklist
Capstone labs must demonstrate production readiness beyond functional completion.

**Required hardening items for LP03+:**
- Key Vault: `--enable-purge-protection true`
- Key Vault: `--enable-rbac-authorization true` (not vault access policies)
- App Configuration: Managed identity access only (no connection string)
- Secrets: No plaintext in environment variables, config files, or deployment YAMLs
- SAS tokens: Stored access policy bound; expiry ≤ 24 hours for external use

**Deliverables**
- Capstone lab README includes a production hardening checklist section
- LP validation script asserts all required hardening properties

---

### E5 — Incident Response Awareness
Advanced and capstone labs introduce controlled failure scenarios.

**Pattern**
- Create a resource without a required security setting
- Observe the failure (403, token error, compliance rejection)
- Apply the remediation
- Re-run validation to confirm recovery

**Deliverables**
- Each advanced lab includes at least one negative test (wrong role → 403, expired SAS → 403)
- Capstone lab documents the observed failure and the remediation applied

---

## Repo Placement

| Enhancement | Location |
|-------------|----------|
| Credential-free pattern examples | `shared/scripts/` |
| Lab hardening checklists | `learning-paths/*/labs/capstone/*/README.md` |
| Role justification guidance | `docs/program/standards-and-guardrails.md` |
| Incident response scenarios | `learning-paths/*/labs/advanced/*/README.md` |
| Validation assertions | `learning-paths/*/validation/*.ps1` |

---

## AZ-204 Exam Alignment

| Enhancement | Exam Skill Area |
|-------------|----------------|
| E1 — Credential-free design | Implement Azure security (managed identity, Key Vault) |
| E2 — SDK-first delivery | All SDK-based exam skills (compute, storage, security) |
| E3 — Least privilege | Implement Azure security (RBAC role assignment) |
| E4 — Production hardening | Implement Azure security (Key Vault configuration) |
| E5 — Incident response | Monitor, troubleshoot, and optimize Azure solutions |
