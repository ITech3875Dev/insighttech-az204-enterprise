# Lab 01 — Key Vault Secret Access (Beginner)

**Learning Path**: AZ-204 LP03 — Implement Azure Security
**Module**: M01 — Authentication and Authorization
**Tier**: Beginner
**Duration**: ~60 minutes
**Azure Services**: Azure Key Vault, Azure CLI, Python (`azure-keyvault-secrets`, `azure-identity`)

---

## Objectives
- Provision an Azure Key Vault using the Azure CLI.
- Store a secret in Key Vault.
- Retrieve the secret from Python using `SecretClient` with `DefaultAzureCredential`.
- Verify access is controlled by RBAC rather than a hardcoded credential.

---

## Prerequisites
- Active Azure subscription with Contributor rights in the target resource group.
- Azure CLI installed and authenticated (`az login`).
- Python 3.9+ with `pip`.
- Python packages: `azure-keyvault-secrets`, `azure-identity`.

---

## Variables

**Bash / Cloud Shell**
```bash
SUB_ID="<your-subscription-id>"
RG="rg-az204-lp03"
LOCATION="eastus"
VAULT_NAME="kv-az204-lp03-$RANDOM"
SECRET_NAME="db-connection-string"
SECRET_VALUE="Server=myserver;Database=mydb;User=app;Password=placeholder"
```

**PowerShell**
```powershell
$SUB_ID    = "<your-subscription-id>"
$RG        = "rg-az204-lp03"
$LOCATION  = "eastus"
$VAULT_NAME = "kv-az204-lp03-$(Get-Random -Maximum 9999)"
$SECRET_NAME  = "db-connection-string"
$SECRET_VALUE = "Server=myserver;Database=mydb;User=app;Password=placeholder"
```

---

## Task 1 — Create Resource Group and Key Vault

```bash
az group create --name $RG --location $LOCATION

az keyvault create \
  --name $VAULT_NAME \
  --resource-group $RG \
  --location $LOCATION \
  --enable-rbac-authorization true \
  --retention-days 7
```

**Verification:**
```bash
az keyvault show --name $VAULT_NAME --query "properties.enableRbacAuthorization"
# Expected: true
```

---

## Task 2 — Assign Key Vault Secrets Officer Role to Your Identity

```bash
MY_OID=$(az ad signed-in-user show --query id -o tsv)
VAULT_ID=$(az keyvault show --name $VAULT_NAME --query id -o tsv)

az role assignment create \
  --assignee-object-id $MY_OID \
  --assignee-principal-type User \
  --role "Key Vault Secrets Officer" \
  --scope $VAULT_ID
```

**Verification:**
```bash
az role assignment list --scope $VAULT_ID --query "[].{Principal:principalName, Role:roleDefinitionName}" -o table
```

---

## Task 3 — Store a Secret

```bash
az keyvault secret set \
  --vault-name $VAULT_NAME \
  --name $SECRET_NAME \
  --value "$SECRET_VALUE"
```

**Verification:**
```bash
az keyvault secret show \
  --vault-name $VAULT_NAME \
  --name $SECRET_NAME \
  --query "value" -o tsv
# Expected: the connection string value
```

---

## Task 4 — Retrieve the Secret via Python SDK

Create `keyvault_access.py`:

```python
import os
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

vault_url = os.environ["KEY_VAULT_URL"]
secret_name = os.environ["SECRET_NAME"]

credential = DefaultAzureCredential()
client = SecretClient(vault_url=vault_url, credential=credential)

secret = client.get_secret(secret_name)
print(f"Secret name : {secret.name}")
print(f"Secret value: {secret.value}")
```

Export variables and run:

```bash
export KEY_VAULT_URL="https://$VAULT_NAME.vault.azure.net"
export SECRET_NAME="$SECRET_NAME"
pip install azure-keyvault-secrets azure-identity
python keyvault_access.py
```

**Expected output:**
```
Secret name : db-connection-string
Secret value: Server=myserver;Database=mydb;User=app;Password=placeholder
```

---

## Task 5 — Validate No Hardcoded Credentials

Confirm the Python file contains no literal credential strings:

```bash
grep -i "password\|secret\|key" keyvault_access.py
# Should only match environment variable names — no literal values
```

---

## Cleanup

```bash
az group delete --name $RG --yes --no-wait
```

---

## Checklist
- [ ] Key Vault created with RBAC authorization enabled.
- [ ] Secrets Officer role assigned to your identity.
- [ ] Secret stored and confirmed via `az keyvault secret show`.
- [ ] Python script retrieved secret using `DefaultAzureCredential` with no hardcoded credential.
- [ ] Resource group deleted after completion.
