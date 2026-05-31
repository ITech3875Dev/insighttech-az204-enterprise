# Answer Key — AZ-204 LP03: Implement Azure Security

---

## Answer Map

| Q# | Answer | Topic Area |
|----|--------|------------|
| Q01 | B | Authentication — managed identity (no stored credentials) |
| Q02 | A | `DefaultAzureCredential` — provider chain order |
| Q03 | C | OAuth 2.0 — client credentials grant for background services |
| Q04 | B | MSAL — `acquire_token_for_client` = client credentials |
| Q05 | B | JWT — `aud` claim identifies the intended resource (ARM) |
| Q06 | B | OAuth 2.0 — authorization code + PKCE for delegated access |
| Q07 | B | Entra ID — application vs delegated permission behavior |
| Q08 | C | Azure CLI — `az ad app create` |
| Q09 | C | SAS — expired tokens return 403 |
| Q10 | B | SAS — stored policy deletion invalidates all bound SAS tokens |
| Q11 | C | SAS — user delegation SAS uses Entra ID identity |
| Q12 | C | Storage — `--sas-expiry-action Log` is a policy governance tool (note: disabling key-based SAS uses `--key-expiration-period-in-days` with cross-tenant enforcement; closest policy control in the list is C — this is a nuanced point to discuss in review) |
| Q13 | B | Key Vault — `--enable-rbac-authorization true` |
| Q14 | C | Key Vault SDK — `SecretClient` |
| Q15 | C | Key Vault RBAC — `Key Vault Secrets User` for read |
| Q16 | B | Key Vault — configurable retention (7–90 days) |
| Q17 | B | Key Vault — purge protection prevents permanent deletion during retention |
| Q18 | A | `DefaultAzureCredential` — Azure CLI (local), Managed Identity (ACI) |
| Q19 | B | Azure CLI — `az keyvault secret show --vault-name $VAULT --name app-key` |
| Q20 | C | Key Vault — Certificate type for TLS private key |
| Q21 | B | `DefaultAzureCredential` — falls through all providers; no identity available |
| Q22 | B | Key Vault pricing — RSA key crypto operations are higher-cost tier |
| Q23 | B | Key Vault — built-in rotation policy |
| Q24 | B | Key Vault networking — private endpoint + disabled public access = VNet only |
| Q25 | B | App Configuration — `application/vnd.microsoft.appconfig.keyvaultref+json` |
| Q26 | B | Managed identity — credential lifecycle managed by Azure |
| Q27 | B | System-assigned identity — deleted with the parent resource |
| Q28 | B | User-assigned identity — can be shared across multiple resources |
| Q29 | B | IMDS — `http://169.254.169.254/metadata/identity/oauth2/token` |
| Q30 | C | Key Vault RBAC — `Key Vault Secrets User` for managed identity |
| Q31 | B | RBAC scoping — vault-scope role covers all current and future secrets |
| Q32 | B | `az identity create` — creates a user-assigned managed identity |
| Q33 | B | RBAC propagation — can take up to a few minutes |
| Q34 | C | Local dev — `AzureCliCredential` via `az login` |
| Q35 | B | ACI — `--assign-identity` enables system-assigned MI |
| Q36 | A | ACI — full resource ID path for user-assigned identity |
| Q37 | B | App Configuration RBAC — `App Configuration Data Reader` |
| Q38 | B | App Configuration CLI — `az appconfig kv set-keyvault` |
| Q39 | A | Dual role — `Key Vault Secrets User` + `App Configuration Data Reader` |
| Q40 | B | Key Vault — `enablePurgeProtection` |
| Q41 | C | Security — runtime Key Vault URI reference with `DefaultAzureCredential` |
| Q42 | B | Key Vault — enforces TLS 1.2+ by default |
| Q43 | A | SAS revocation — rotating the key that signed the SAS invalidates it |
| Q44 | B | SAS — minimal write permission scoped to blob and container |
| Q45 | B | Key Vault — `--enabled-for-disk-encryption` |
| Q46 | B | Key Vault events — `SecretNearExpiry` via Event Grid |
| Q47 | B | Incident response — immediately rotate the compromised secret |
| Q48 | B | SAS — time-limited service SAS for external vendor |
| Q49 | B | CLI — `az role assignment list --scope <vault-resource-id>` |
| Q50 | B | Validation remediation — `az keyvault update --enable-purge-protection true` (requires soft-delete already enabled, which is always on; D is a common misconception — purge protection CAN be enabled after creation) |

---

## Objective Coverage by Topic Area

| Topic | Questions | Count |
|-------|-----------|-------|
| Microsoft Identity Platform & OAuth 2.0 | Q01–Q12 | 12 |
| Azure Key Vault (provisioning, RBAC, SDK, networking) | Q13–Q25 | 13 |
| Managed Identity (system/user-assigned, IMDS, role scoping) | Q26–Q36 | 11 |
| Secure Solutions (App Config, SAS, production patterns) | Q37–Q50 | 14 |

---

## AZ-204 Exam Domain Alignment

| AZ-204 Skill Area | LP03 Coverage |
|-------------------|---------------|
| Implement user authentication and authorization | Q01–Q12 |
| Implement secure cloud solutions (Key Vault) | Q13–Q25 |
| Implement secure cloud solutions (managed identity) | Q26–Q36 |
| Secure configurations and production hardening | Q37–Q50 |

---

## Scoring Bands

| Score | Band | Recommendation |
|-------|------|----------------|
| 45–50 (90–100%) | Mastery | Ready for AZ-204 exam; review any missed items |
| 38–44 (76–88%) | Proficient | Targeted review of incorrect topic areas; re-attempt labs |
| 35–37 (70–75%) | Passing | Retake relevant module; complete capstone lab before exam attempt |
| 0–34 (< 70%) | Needs Work | Revisit M01 + M02 fully; complete all labs before re-testing |

---

## Instructor Notes

**Common traps:**
- **Q12**: Disabling key-based SAS generation uses `--key-expiration-period-in-days` or organizational policy enforcement rather than `--default-action Deny`. Prompt class discussion on why C is listed — the exam scenario rewards identifying that `--sas-expiry-action Log` is a governance control, but the most correct way to _prohibit_ key-based SAS is via Azure Policy (`Allowed values` for `sasPolicy.expirationAction`). Use this question as a teaching moment.
- **Q31**: Candidates often believe role assignments must be re-applied per secret. Clarify that vault-scope assignments cover all objects created before and after the assignment.
- **Q33**: Propagation delay is a real-world gotcha. Teach teams to wait 1–2 minutes after assigning roles before testing.
- **Q50**: `enablePurgeProtection` CAN be enabled on an existing vault (it cannot be _disabled_ once set). Option D is the misconception to address.
