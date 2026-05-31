# Lab 01 — Security Solutions Production Readiness (Capstone)

**Learning Path**: AZ-204 LP03 — Implement Azure Security
**Module**: M02 — Key Vault and Managed Identity
**Tier**: Capstone
**Duration**: ~90 minutes
**Azure Services**: Azure Key Vault, Managed Identity, App Configuration, Azure Container Instances

---

## Objectives
Integrate all LP03 security controls into a single credential-free application deployment:
- Key Vault for secret storage with soft-delete and purge protection enabled.
- System-assigned managed identity for compute-to-Key Vault authentication.
- App Configuration store with a Key Vault reference (indirect secret access).
- Zero hardcoded credentials in code, environment variables, or container config.
- LP03 validation script exits `[RESULT] PASS`.

---

## Prerequisites
- Completed all three prior LP03 labs.
- `rg-az204-lp03` resource group, Key Vault, and Storage Account in place.
- Entra ID app registration deleted (from advanced lab cleanup).

---

## Execution Plan

### Phase 1 — Harden Key Vault
Enable soft-delete (already default on new vaults) and purge protection:

```bash
VAULT_NAME="<your-vault-name>"
RG="rg-az204-lp03"

az keyvault update \
  --name $VAULT_NAME \
  --resource-group $RG \
  --enable-purge-protection true

az keyvault show \
  --name $VAULT_NAME \
  --query "{softDelete:properties.enableSoftDelete, purgeProtection:properties.enablePurgeProtection}"
# Expected: both true
```

### Phase 2 — Provision App Configuration with Key Vault Reference

```bash
APPCONFIG_NAME="appconfig-az204-lp03"
az appconfig create \
  --name $APPCONFIG_NAME \
  --resource-group $RG \
  --location eastus \
  --sku Free

SECRET_ID=$(az keyvault secret show \
  --vault-name $VAULT_NAME \
  --name db-connection-string \
  --query id -o tsv)

az appconfig kv set-keyvault \
  --name $APPCONFIG_NAME \
  --key "ConnectionStrings:Database" \
  --secret-identifier $SECRET_ID \
  --yes
```

**Verification:**
```bash
az appconfig kv show \
  --name $APPCONFIG_NAME \
  --key "ConnectionStrings:Database"
# contentType should be application/vnd.microsoft.appconfig.keyvaultref+json
```

### Phase 3 — Deploy Container with Managed Identity and App Config Reference

```bash
ACI_NAME="aci-az204-capstone"

az container create \
  --resource-group $RG \
  --name $ACI_NAME \
  --image mcr.microsoft.com/azure-cli \
  --command-line "tail -f /dev/null" \
  --assign-identity \
  --location eastus

MI_PRINCIPAL=$(az container show \
  --resource-group $RG \
  --name $ACI_NAME \
  --query "identity.principalId" -o tsv)

VAULT_ID=$(az keyvault show --name $VAULT_NAME --query id -o tsv)
APPCONFIG_ID=$(az appconfig show --name $APPCONFIG_NAME --query id -o tsv)

# Grant Key Vault Secrets User on vault
az role assignment create \
  --assignee-object-id $MI_PRINCIPAL \
  --assignee-principal-type ServicePrincipal \
  --role "Key Vault Secrets User" \
  --scope $VAULT_ID

# Grant App Configuration Data Reader on app config
az role assignment create \
  --assignee-object-id $MI_PRINCIPAL \
  --assignee-principal-type ServicePrincipal \
  --role "App Configuration Data Reader" \
  --scope $APPCONFIG_ID
```

### Phase 4 — End-to-End Validation

Exec into the container and confirm credential-free access through the full chain:

```bash
az container exec --resource-group $RG --name $ACI_NAME --exec-command "bash"
```

Inside:
```bash
az login --identity

# Read secret directly from Key Vault
az keyvault secret show \
  --vault-name <VAULT_NAME> \
  --name db-connection-string \
  --query value -o tsv

# Read Key Vault reference through App Configuration
az appconfig kv show \
  --name <APPCONFIG_NAME> \
  --key "ConnectionStrings:Database" \
  --resolve-keyvault \
  --auth-mode login
exit
```

---

## Run LP03 Validation Script

```powershell
.\validation\az204-lp03-validate.ps1 `
  -SubscriptionId "<your-sub-id>" `
  -ResourceGroupName "rg-az204-lp03" `
  -KeyVaultName "<your-vault-name>" `
  -SecretName "db-connection-string" `
  -AppConfigName "appconfig-az204-lp03"
```

Expected: `[RESULT] PASS`

---

## Pass Criteria
- [ ] Key Vault has soft-delete and purge-protection both enabled.
- [ ] App Configuration store contains a Key Vault reference; `contentType` verified.
- [ ] Container has system-assigned managed identity.
- [ ] Managed identity holds Key Vault Secrets User + App Configuration Data Reader.
- [ ] Secret read end-to-end from inside container with no stored credential.
- [ ] LP03 validation script exits `[RESULT] PASS`.

## Evidence Package
Capture the following outputs as your submission evidence:
1. `az keyvault show` output showing purge protection enabled.
2. `az role assignment list --scope <vault-id>` showing managed identity role.
3. Screenshot or terminal output of secret value printed inside the container.
4. LP03 validation script terminal output (full `[RESULT] PASS` block).
5. One-paragraph written summary: explain how managed identity eliminates the credential rotation problem compared to a service principal with a client secret.
