# Lab 01 — OAuth 2.0 and App Registration (Advanced)

**Learning Path**: AZ-204 LP03 — Implement Azure Security  
**Module**: M02 — Key Vault and Managed Identity  
**Tier**: Advanced  
**Duration**: ~90 minutes  
**Azure Services**: Microsoft Entra ID, MSAL for Python, Azure Key Vault, Azure Storage (SAS)

---

## Objectives
- Register an application in Entra ID with a client secret.
- Acquire an access token using the OAuth 2.0 client credentials flow.
- Decode and inspect token claims (`aud`, `iss`, `appid`, `roles`).
- Create a user delegation SAS token for Azure Storage using an OAuth identity.
- Apply a stored access policy to a container and reference it from a service SAS.

---

## Prerequisites
- `rg-az204-lp03` resource group and Key Vault from prior labs.
- Azure Storage Account from LP02 (or create a new one in `rg-az204-lp03`).
- Entra ID permissions to register applications (`Application.ReadWrite.OwnedBy` or Global Admin).
- Python packages: `msal`, `azure-identity`, `azure-storage-blob`, `PyJWT`.

---

## Variables

```bash
RG="rg-az204-lp03"
VAULT_NAME="<your-vault-name>"
TENANT_ID=$(az account show --query tenantId -o tsv)
STORAGE_ACCOUNT="<your-storage-account-name>"
CONTAINER_NAME="secure-container"
```

---

## Task 1 — Register an Entra ID Application

```bash
APP_NAME="az204-lp03-app"
APP_ID=$(az ad app create --display-name $APP_NAME --query appId -o tsv)
SP_ID=$(az ad sp create --id $APP_ID --query id -o tsv)

echo "App (client) ID: $APP_ID"
echo "Service principal object ID: $SP_ID"
```

Create a client secret:

```bash
CLIENT_SECRET=$(az ad app credential reset \
  --id $APP_ID \
  --years 1 \
  --query password -o tsv)

echo "Client secret: $CLIENT_SECRET"
# Store this — it will not be shown again
```

Store the secret in Key Vault instead of keeping it in the shell:

```bash
az keyvault secret set \
  --vault-name $VAULT_NAME \
  --name "app-client-secret" \
  --value "$CLIENT_SECRET"
```

---

## Task 2 — Acquire an Access Token (Client Credentials Flow)

Create `acquire_token.py`:

```python
import msal, os, json

tenant_id = os.environ["TENANT_ID"]
client_id = os.environ["APP_CLIENT_ID"]
client_secret = os.environ["APP_CLIENT_SECRET"]
scope = ["https://management.azure.com/.default"]

app = msal.ConfidentialClientApplication(
    client_id=client_id,
    client_credential=client_secret,
    authority=f"https://login.microsoftonline.com/{tenant_id}"
)

result = app.acquire_token_for_client(scopes=scope)

if "access_token" in result:
    print("Token acquired successfully.")
    # Decode header and payload (no signature validation — demo only)
    import base64
    parts = result["access_token"].split(".")
    payload = json.loads(base64.b64decode(parts[1] + "==").decode())
    print(f"  aud : {payload.get('aud')}")
    print(f"  iss : {payload.get('iss')}")
    print(f"  appid: {payload.get('appid')}")
else:
    print(f"Error: {result.get('error_description')}")
```

```bash
export TENANT_ID=$TENANT_ID
export APP_CLIENT_ID=$APP_ID
export APP_CLIENT_SECRET=$(az keyvault secret show \
  --vault-name $VAULT_NAME --name app-client-secret --query value -o tsv)

pip install msal PyJWT
python acquire_token.py
```

**Expected output:**
```
Token acquired successfully.
  aud : https://management.azure.com/
  iss : https://sts.windows.net/<tenant-id>/
  appid: <app-id>
```

---

## Task 3 — Create a Storage Container and Stored Access Policy

```bash
CONN_STR=$(az storage account show-connection-string \
  --name $STORAGE_ACCOUNT --resource-group $RG --query connectionString -o tsv)

az storage container create \
  --name $CONTAINER_NAME \
  --connection-string "$CONN_STR"

# Create a stored access policy valid for 24 hours
az storage container policy create \
  --name "read-policy" \
  --container-name $CONTAINER_NAME \
  --permissions r \
  --expiry $(date -u -d "+1 day" +"%Y-%m-%dT%H:%MZ") \
  --connection-string "$CONN_STR"
```

Generate a service SAS using the stored policy:

```bash
SAS_TOKEN=$(az storage container generate-sas \
  --name $CONTAINER_NAME \
  --policy-name "read-policy" \
  --connection-string "$CONN_STR" \
  --output tsv)

echo "SAS token: $SAS_TOKEN"
```

---

## Task 4 — Validate SAS Access and Revocation

Upload a test blob and verify SAS read access:

```bash
echo "test content" > test.txt
az storage blob upload \
  --container-name $CONTAINER_NAME \
  --name test.txt \
  --file test.txt \
  --connection-string "$CONN_STR"

ACCOUNT_URL="https://${STORAGE_ACCOUNT}.blob.core.windows.net"
curl -s "${ACCOUNT_URL}/${CONTAINER_NAME}/test.txt?${SAS_TOKEN}" 
# Expected: "test content"
```

Revoke by deleting the stored access policy:

```bash
az storage container policy delete \
  --name "read-policy" \
  --container-name $CONTAINER_NAME \
  --connection-string "$CONN_STR"

curl -s "${ACCOUNT_URL}/${CONTAINER_NAME}/test.txt?${SAS_TOKEN}"
# Expected: 403 AuthorizationPermissionMismatch
```

---

## Cleanup

```bash
az ad app delete --id $APP_ID
az storage container delete --name $CONTAINER_NAME --connection-string "$CONN_STR"
# Retain resource group and Key Vault for capstone
```

---

## Checklist
- [ ] App registered in Entra ID; client secret stored in Key Vault (not in shell history).
- [ ] MSAL client credentials flow acquired token; claims decoded and inspected.
- [ ] Storage container created with a stored access policy; SAS token generated referencing the policy.
- [ ] SAS revoked by deleting the policy; subsequent request returns 403.
- [ ] App registration deleted after lab; resource group retained.
