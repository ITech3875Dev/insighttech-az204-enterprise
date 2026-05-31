# Practice Exam — AZ-204 LP03: Implement Azure Security (50 Questions)

> **Instructions**: Select the single best answer for each question unless stated otherwise. Target score: 70% (35/50).

---

## Section A — Microsoft Identity Platform and Authentication (Q01–Q12)

**Q01.** You need your application to authenticate to Azure services without storing credentials. Which authentication approach should you use?

A. Hard-code a client secret in `appsettings.json`  
B. Managed identity  
C. Certificate stored in blob storage  
D. Basic authentication with a service account  

---

**Q02.** Your application uses `DefaultAzureCredential`. What is the order in which it tries credential providers?

A. Environment → Workload identity → Managed identity → Azure CLI  
B. Managed identity → Azure CLI → Environment → Visual Studio  
C. Azure CLI → Environment → Managed identity → Visual Studio  
D. Environment → Azure CLI → Visual Studio → Managed identity  

---

**Q03.** Which OAuth 2.0 grant type is appropriate for a background service that runs without user interaction?

A. Authorization code  
B. Device code  
C. Client credentials  
D. Resource owner password  

---

**Q04.** A developer calls `app.acquire_token_for_client(scopes=["https://management.azure.com/.default"])`. Which grant type is being used?

A. Authorization code  
B. Client credentials  
C. Implicit  
D. Device code  

---

**Q05.** You decode an access token JWT. The `aud` claim is `https://management.azure.com/`. What does this indicate?

A. The token was issued by management.azure.com  
B. The token is intended for the Azure Resource Manager audience  
C. The token scope is limited to the management plane  
D. The token cannot be used for data plane operations  

---

**Q06.** Your application needs delegated permissions to call Microsoft Graph on behalf of a signed-in user. Which flow should you implement?

A. Client credentials  
B. Authorization code with PKCE  
C. Device code  
D. Resource owner password  

---

**Q07.** An Entra ID app registration has both `Application` permissions and `Delegated` permissions assigned to Microsoft Graph. What is the key behavioral difference?

A. Application permissions require a user to consent; delegated permissions do not  
B. Application permissions are used by daemons; delegated permissions act on behalf of a user  
C. Application permissions expire after 24 hours; delegated permissions do not  
D. There is no difference in practice  

---

**Q08.** Which `az` CLI command registers an application in Entra ID?

A. `az identity create`  
B. `az ad sp create`  
C. `az ad app create`  
D. `az role assignment create`  

---

**Q09.** A Shared Access Signature (SAS) token grants `r` (read) permission with an expiry in 2 hours. What happens after 2 hours?

A. The token downgrades to list-only permission  
B. The token automatically renews  
C. Any request using the token returns a 403 error  
D. The token remains valid until explicitly revoked  

---

**Q10.** You create a SAS using a stored access policy. You want to invalidate the SAS before it expires. What is the correct action?

A. Delete the blob container  
B. Delete the stored access policy  
C. Rotate the storage account key  
D. Update the SAS expiry to a past date  

---

**Q11.** Which type of SAS token uses the Entra ID identity of the requesting user rather than a storage account key?

A. Account SAS  
B. Service SAS  
C. User delegation SAS  
D. Stored policy SAS  

---

**Q12.** Your security team requires that no SAS tokens are generated using storage account keys. Which storage configuration enforces this?

A. `--min-tls-version TLS1_2`  
B. `--allow-blob-public-access false`  
C. `--sas-expiry-action Log`  
D. `--default-action Deny` on the network ACL  

---

## Section B — Azure Key Vault (Q13–Q25)

**Q13.** You provision a Key Vault and want to use Azure RBAC to control access instead of vault access policies. Which flag must be set?

A. `--enable-soft-delete true`  
B. `--enable-rbac-authorization true`  
C. `--enabled-for-deployment true`  
D. `--network-acls-bypass AzureServices`  

---

**Q14.** A developer stores a connection string in Key Vault. Which Python class is used to retrieve it?

A. `KeyClient`  
B. `CertificateClient`  
C. `SecretClient`  
D. `VaultClient`  

---

**Q15.** What is the minimum RBAC role that allows reading a secret value from Key Vault?

A. Key Vault Administrator  
B. Key Vault Secrets Officer  
C. Key Vault Secrets User  
D. Reader  

---

**Q16.** Soft-delete is enabled on a Key Vault. A secret is deleted. What is the retention period before the secret is permanently purged?

A. 7 days  
B. The configured retention days (7–90)  
C. 30 days always  
D. 90 days always  

---

**Q17.** Purge protection is enabled on a Key Vault. What does this prevent?

A. Creating new secrets while deleted secrets are in the retention period  
B. Permanent deletion of the vault or its objects during the retention period  
C. Reading secrets from the vault  
D. Updating the vault's network ACLs  

---

**Q18.** Your application uses `DefaultAzureCredential` and connects to Key Vault. It runs in a local dev environment but also on ACI in production. Which credential is used in each environment respectively?

A. Azure CLI (local) → Managed Identity (ACI)  
B. Environment variables (local) → Azure CLI (ACI)  
C. Managed Identity (local) → Environment (ACI)  
D. Visual Studio (local) → Managed Identity (ACI)  

---

**Q19.** Which `az keyvault` command retrieves the current value of a secret named `app-key`?

A. `az keyvault secret get --name app-key`  
B. `az keyvault secret show --vault-name $VAULT --name app-key`  
C. `az keyvault secret list --vault-name $VAULT --name app-key`  
D. `az keyvault key show --vault-name $VAULT --name app-key`  

---

**Q20.** You need to store a TLS certificate private key in Key Vault and reference it from an Azure App Service. Which Key Vault object type should you use?

A. Secret  
B. Key  
C. Certificate  
D. Managed HSM key  

---

**Q21.** An application connects to Key Vault using `SecretClient(vault_url=url, credential=DefaultAzureCredential())`. The app is running on a VM with no managed identity. Authentication fails. What is the most likely reason?

A. The vault URL is incorrect  
B. No managed identity is assigned; `DefaultAzureCredential` falls through all providers without success  
C. `DefaultAzureCredential` is not supported on VMs  
D. The vault requires a user delegation SAS  

---

**Q22.** Key Vault charges per operation. Which operation type incurs the highest cost tier?

A. Secret `get`  
B. RSA key cryptographic operations  
C. Certificate `import`  
D. All operations are equally priced  

---

**Q23.** You need to rotate a Key Vault secret automatically every 90 days. Which Azure service enables this without code changes?

A. Azure Automation runbook  
B. Key Vault rotation policy  
C. Azure Logic Apps  
D. Event Grid subscription  

---

**Q24.** A Key Vault is configured with a private endpoint. Public network access is disabled. Which connection is still permitted?

A. Any Azure service in the same region  
B. Only connections from the linked virtual network via the private endpoint  
C. Connections from trusted Microsoft services only  
D. No connections are permitted until the firewall is re-enabled  

---

**Q25.** An application team wants to reference a Key Vault secret from an App Configuration key. What is the `contentType` of the resulting App Configuration entry?

A. `application/json`  
B. `application/vnd.microsoft.appconfig.keyvaultref+json`  
C. `text/plain`  
D. `application/x-www-form-urlencoded`  

---

## Section C — Managed Identity (Q26–Q36)

**Q26.** What is the primary benefit of a system-assigned managed identity over a service principal with a client secret?

A. Managed identities support more OAuth scopes  
B. The credential lifecycle is managed by Azure and is not exposed to developers  
C. Managed identities have a higher token expiry  
D. Managed identities can be shared across multiple resources  

---

**Q27.** A system-assigned managed identity is enabled on an Azure Function. What happens when the Function App is deleted?

A. The identity is converted to user-assigned  
B. The identity is deleted automatically  
C. The identity is retained in Entra ID for 30 days  
D. The identity must be manually deleted  

---

**Q28.** Which is TRUE of a user-assigned managed identity?

A. It is deleted when the associated resource is deleted  
B. It can be assigned to multiple resources simultaneously  
C. It cannot be used with Azure Container Instances  
D. It requires a client secret to authenticate  

---

**Q29.** An ACI container uses its system-assigned managed identity to authenticate. Which endpoint does the container call internally to obtain a token?

A. `https://login.microsoftonline.com`  
B. `http://169.254.169.254/metadata/identity/oauth2/token` (IMDS)  
C. `https://management.azure.com/token`  
D. `https://vault.azure.net/auth/token`  

---

**Q30.** Which role assignment allows a managed identity to read secrets from a Key Vault with RBAC authorization?

A. Contributor at the resource group  
B. Key Vault Administrator  
C. Key Vault Secrets User  
D. Reader at the vault  

---

**Q31.** You assign `Key Vault Secrets User` to a managed identity at the vault scope. A new secret is added to the same vault. Does the identity need a new role assignment?

A. Yes — role assignments apply only at the time of assignment  
B. No — the role applies to all secrets in the vault scope  
C. Only if the secret is in a different vault version  
D. Only if the identity is user-assigned  

---

**Q32.** `az identity create --name mi-app --resource-group rg-lp03` creates what kind of managed identity?

A. System-assigned  
B. User-assigned  
C. Workload identity  
D. Service principal  

---

**Q33.** After assigning a role to a managed identity, the application immediately calls Key Vault and receives a 403. What is the most likely cause?

A. The vault has purge protection enabled  
B. RBAC role assignment propagation can take up to a few minutes  
C. The managed identity token has expired  
D. The role must be assigned at the subscription level  

---

**Q34.** A developer wants to test managed-identity code locally. Which `DefaultAzureCredential` provider should they configure?

A. `EnvironmentCredential` with a service principal client secret  
B. `ManagedIdentityCredential` targeting the local IMDS  
C. `AzureCliCredential` (running `az login` on the local machine)  
D. `InteractiveBrowserCredential`  

---

**Q35.** Which `az container` parameter enables a system-assigned managed identity during container creation?

A. `--identity system`  
B. `--assign-identity`  
C. `--managed-identity-type SystemAssigned`  
D. `--enable-msi`  

---

**Q36.** You have a user-assigned managed identity named `mi-processor`. You want to assign it to an Azure Container Instance. Which CLI flag should you use?

A. `--assign-identity /subscriptions/.../resourceGroups/.../providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-processor`  
B. `--identity mi-processor`  
C. `--user-assigned-identity mi-processor`  
D. `--managed-identity mi-processor`  

---

## Section D — Secure Solutions: App Config, SAS, and Production Patterns (Q37–Q50)

**Q37.** An App Configuration store contains a Key Vault reference. Which permission does the reading application need on the App Configuration store?

A. App Configuration Data Owner  
B. App Configuration Data Reader  
C. Reader  
D. Contributor  

---

**Q38.** Which `az appconfig kv` sub-command creates a Key Vault reference in App Configuration?

A. `set`  
B. `set-keyvault`  
C. `import`  
D. `lock`  

---

**Q39.** Your application reads feature flags from App Configuration and secrets from Key Vault. It runs on ACI with a managed identity. Which role assignments are needed?

A. Key Vault Secrets User on vault; App Configuration Data Reader on App Config  
B. Key Vault Administrator on vault; App Configuration Data Owner on App Config  
C. Contributor on resource group  
D. Key Vault Secrets User on vault only — App Config reads from Key Vault automatically  

---

**Q40.** You need to prevent any user from permanently purging deleted Key Vault objects before the retention period expires. Which property controls this?

A. `enableSoftDelete`  
B. `enablePurgeProtection`  
C. `retentionDays`  
D. `enableRbacAuthorization`  

---

**Q41.** Which of the following is the most secure way to pass a Key Vault secret value into an application?

A. Inject as an environment variable in the container config  
B. Store in Azure Blob Storage and read at startup  
C. Reference via Key Vault URI using `DefaultAzureCredential` at runtime  
D. Store as a base64-encoded string in `appsettings.json`  

---

**Q42.** Your security policy requires that TLS 1.2 is the minimum protocol version for all Key Vault traffic. Where is this enforced?

A. In the application code with `ssl_minimum_version`  
B. Key Vault enforces TLS 1.2+ by default; no configuration is required  
C. In the Key Vault network ACL `--bypass` flag  
D. In the `az keyvault update --min-tls-version` parameter  

---

**Q43.** A storage account SAS token is compromised. Rotating which key immediately invalidates all SAS tokens created with that key?

A. The account primary or secondary key used to generate the SAS  
B. The storage account's managed identity  
C. The Entra ID tenant key  
D. The App Configuration access key  

---

**Q44.** You need an account SAS with the minimum permissions to allow an external vendor to upload blobs to a specific container. Which permission string is correct?

A. `racwdl`  
B. `w` with object type `b` (blob) scoped to the container  
C. `r` — read permission is sufficient for upload  
D. `acdlrw` — all permissions to ensure the vendor does not encounter errors  

---

**Q45.** Which `az keyvault` flag must be set to `true` to allow Azure Disk Encryption to use a Key Vault?

A. `--enabled-for-deployment`  
B. `--enabled-for-disk-encryption`  
C. `--enable-rbac-authorization`  
D. `--enable-purge-protection`  

---

**Q46.** Your team defines the Key Vault secret rotation policy to trigger every 90 days. What Azure event enables notification when a secret is about to expire?

A. Azure Monitor metric alert on vault secret count  
B. Key Vault `SecretNearExpiry` event via Event Grid  
C. Azure Policy audit rule on Key Vault  
D. Logic App polling the vault on a schedule  

---

**Q47.** A developer accidentally hard-codes a client secret in a public GitHub repository. The secret is still valid. What is the correct first response?

A. Delete the repository  
B. Rotate the client secret immediately in Entra ID  
C. Change the application's redirect URI  
D. Disable the app registration  

---

**Q48.** You need to grant a third-party vendor read access to a storage blob for exactly 24 hours with no ongoing management. Which approach is most appropriate?

A. Add the vendor as a Guest user and assign Storage Blob Data Reader  
B. Generate a service SAS with a 24-hour expiry  
C. Share the storage account connection string  
D. Generate an account key and provide it to the vendor  

---

**Q49.** Which Azure CLI command shows the current role assignments on a Key Vault?

A. `az keyvault show --name $VAULT --query "properties.accessPolicies"`  
B. `az role assignment list --scope $(az keyvault show --name $VAULT --query id -o tsv)`  
C. `az ad role assignment list --vault $VAULT`  
D. `az keyvault policy list --name $VAULT`  

---

**Q50.** Your LP03 validation script exits with `[RESULT] FAIL` and reports that `enablePurgeProtection` is `null`. What is the most appropriate remediation?

A. Delete and re-create the Key Vault  
B. Run `az keyvault update --name $VAULT --enable-purge-protection true`  
C. Run `az keyvault update --name $VAULT --enable-soft-delete true` first, then retry  
D. Purge protection can only be enabled at vault creation time  

---

*End of exam — 50 questions*
