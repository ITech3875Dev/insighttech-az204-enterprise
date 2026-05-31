# Masterclass — CLI Track: Key Vault and Managed Identity

**Learning Path**: AZ-204 LP03 — Implement Azure Security
**Format**: Instructor-led CLI session
**Duration**: 120 minutes
**Audience**: Developers who have completed LP03 labs; comfort with the Azure CLI assumed

---

## Session Outcomes
By the end of this masterclass, students will be able to:
- Deploy a hardened Key Vault from the CLI with RBAC authorization, soft-delete, and purge protection.
- Retrieve secrets in Python using `DefaultAzureCredential` without any stored credential.
- Assign a managed identity to a compute resource and authorize vault access via a scoped role assignment.
- Implement a stored access policy for Azure Storage and demonstrate SAS revocation.
- Explain the OAuth 2.0 client credentials flow from first principles.

---

## Agenda

| Time | Segment | Description |
|------|---------|-------------|
| 0:00–0:20 | Key Vault architecture | Vault model, RBAC vs. access policies, secret lifecycle, soft-delete |
| 0:20–0:45 | Live demo: Vault + Python SDK | Provision vault, store secret, retrieve via `DefaultAzureCredential` |
| 0:45–1:05 | Managed identity deep dive | System vs. user-assigned, IMDS token chain, role assignment scoping |
| 1:05–1:30 | Workshop: credential-free app | Students reproduce managed-identity-to-vault access end-to-end |
| 1:30–1:50 | OAuth 2.0 and SAS | Client credentials flow, stored access policies, SAS revocation demo |
| 1:50–2:00 | Q&A and exam tips | Top AZ-204 security domain question patterns |

---

## Core Commands Reference

```bash
# Provision Key Vault (RBAC mode, production-hardened)
az keyvault create \
  --name $VAULT_NAME \
  --resource-group $RG \
  --location eastus \
  --enable-rbac-authorization true \
  --enable-purge-protection true

# Store a secret
az keyvault secret set --vault-name $VAULT_NAME --name mySecret --value "myValue"

# Assign Key Vault Secrets User to a managed identity
az role assignment create \
  --assignee-object-id $MI_PRINCIPAL \
  --assignee-principal-type ServicePrincipal \
  --role "Key Vault Secrets User" \
  --scope $(az keyvault show --name $VAULT_NAME --query id -o tsv)

# Check soft-delete + purge protection
az keyvault show --name $VAULT_NAME \
  --query "{softDelete:properties.enableSoftDelete, purgeProtect:properties.enablePurgeProtection}"

# Deploy ACI with managed identity
az container create \
  --resource-group $RG \
  --name $ACI_NAME \
  --image mcr.microsoft.com/azure-cli \
  --assign-identity \
  --command-line "tail -f /dev/null"

# Read identity principal ID
az container show --resource-group $RG --name $ACI_NAME \
  --query "identity.principalId" -o tsv

# Stored access policy creation
az storage container policy create \
  --name read-policy \
  --container-name $CONTAINER \
  --permissions r \
  --expiry $(date -u -d "+1 day" +"%Y-%m-%dT%H:%MZ") \
  --connection-string "$CONN_STR"

# SAS from stored policy
az storage container generate-sas \
  --name $CONTAINER \
  --policy-name read-policy \
  --connection-string "$CONN_STR"
```

---

## Workshop Deliverables
Each student must produce:
1. Terminal output showing secret retrieved via managed identity (no stored credential).
2. Role assignment list output confirming Key Vault Secrets User assignment.
3. SAS revocation test: 200 before policy delete, 403 after.
