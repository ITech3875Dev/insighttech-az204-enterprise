# Lab 01 — Managed Identity and RBAC (Intermediate)

**Learning Path**: AZ-204 LP03 — Implement Azure Security  
**Module**: M01 — Authentication and Authorization  
**Tier**: Intermediate  
**Duration**: ~75 minutes  
**Azure Services**: Azure Container Instances (or Azure Functions), Managed Identity, Azure Key Vault, Azure RBAC

---

## Objectives
- Enable a system-assigned managed identity on a compute resource.
- Assign the Key Vault Secrets User role to the managed identity at vault scope.
- Deploy a containerized Python application that reads a Key Vault secret without any stored credential.
- Verify the managed identity token chain from resource → Entra ID → Key Vault.

---

## Prerequisites
- Completed Beginner Lab 01 (Key Vault provisioned in `rg-az204-lp03`).
- Docker or Azure Container Registry (ACR) not required — uses Azure Container Instances with a public image.
- `az` CLI authenticated with Contributor + User Access Administrator rights (or Owner) in the resource group.

---

## Variables

```bash
RG="rg-az204-lp03"
VAULT_NAME="<your-vault-name-from-beginner-lab>"
LOCATION="eastus"
ACI_NAME="aci-az204-lp03"
SECRET_NAME="db-connection-string"
```

---

## Task 1 — Deploy a Container Instance with System-Assigned Managed Identity

```bash
az container create \
  --resource-group $RG \
  --name $ACI_NAME \
  --image mcr.microsoft.com/azure-cli \
  --command-line "tail -f /dev/null" \
  --assign-identity \
  --location $LOCATION

MI_PRINCIPAL=$(az container show \
  --resource-group $RG \
  --name $ACI_NAME \
  --query "identity.principalId" -o tsv)
echo "Managed identity principal: $MI_PRINCIPAL"
```

**Verification:**
```bash
az container show \
  --resource-group $RG \
  --name $ACI_NAME \
  --query "identity.type"
# Expected: "SystemAssigned"
```

---

## Task 2 — Assign Key Vault Secrets User to the Managed Identity

```bash
VAULT_ID=$(az keyvault show --name $VAULT_NAME --query id -o tsv)

az role assignment create \
  --assignee-object-id $MI_PRINCIPAL \
  --assignee-principal-type ServicePrincipal \
  --role "Key Vault Secrets User" \
  --scope $VAULT_ID
```

**Verification:**
```bash
az role assignment list \
  --scope $VAULT_ID \
  --query "[?principalId=='$MI_PRINCIPAL'].{Role:roleDefinitionName}" -o table
# Expected: Key Vault Secrets User
```

---

## Task 3 — Read Secret from Container Using Managed Identity

Exec into the container and use the Azure CLI (already installed in the mcr.microsoft.com/azure-cli image):

```bash
az container exec \
  --resource-group $RG \
  --name $ACI_NAME \
  --exec-command "bash"
```

Inside the container shell:

```bash
# The container authenticates via IMDS using its managed identity
az login --identity

az keyvault secret show \
  --vault-name <VAULT_NAME> \
  --name db-connection-string \
  --query value -o tsv
# Expected: the connection string — no password entered, no key stored
```

Exit the container shell.

---

## Task 4 — Confirm No Stored Credentials Were Used

```bash
# Verify the ACI has no environment variables containing secrets
az container show \
  --resource-group $RG \
  --name $ACI_NAME \
  --query "containers[0].environmentVariables"
# Expected: null or empty — no plaintext credentials injected
```

---

## Task 5 — Attempt Unauthorized Secret Read (Negative Test)

Run a second ACI without managed identity and verify access is denied:

```bash
az container create \
  --resource-group $RG \
  --name aci-unauthorized \
  --image mcr.microsoft.com/azure-cli \
  --command-line "tail -f /dev/null" \
  --location $LOCATION
# No --assign-identity flag

az container exec \
  --resource-group $RG \
  --name aci-unauthorized \
  --exec-command "bash"
```

Inside:
```bash
az login --identity
# Expected: AADSTS error — no managed identity on this container
# OR: az login returns but subsequent keyvault secret show fails with 403
exit
```

Cleanup the unauthorized test container:
```bash
az container delete --resource-group $RG --name aci-unauthorized --yes
```

---

## Cleanup

```bash
az container delete --resource-group $RG --name $ACI_NAME --yes
# Keep the Key Vault and resource group for advanced lab
```

---

## Checklist
- [ ] Container instance created with system-assigned managed identity.
- [ ] Key Vault Secrets User role assigned to managed identity principal ID.
- [ ] Secret retrieved from Key Vault inside container using `az login --identity` — no credential stored.
- [ ] Unauthorized container denied access (negative test).
- [ ] ACI deleted; resource group retained for advanced lab.
