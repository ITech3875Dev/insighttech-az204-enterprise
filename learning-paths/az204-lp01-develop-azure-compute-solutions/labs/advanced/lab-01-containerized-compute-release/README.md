# Lab 01 (Advanced): Containerized Compute Release

## Scenario
You are releasing a containerized web workload to App Service with production guardrails. Build and push an image to Azure Container Registry (ACR), deploy to App Service, validate on staging, and promote via slot swap.

## Prerequisites
- Azure CLI and Docker installed.
- Contributor access to subscription.
- Existing resource group from LP01 or create a new one.

## Variables

```bash
SUBSCRIPTION_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az204-compute-dev-eastus2-01"
ACR_NAME="acr204computedev01"
PLAN_NAME="asp-az204-compute-dev-01"
WEBAPP_NAME="app-az204-cont-dev-01"
SLOT_NAME="staging"
IMAGE_NAME="compute-api"
IMAGE_TAG="v1"
```

## Task 1: Provision ACR and App Service resources

```bash
az account set --subscription "$SUBSCRIPTION_ID"
az group create --name "$RG_NAME" --location "$LOCATION" --tags env=dev workload=az204 owner=student

az acr create --resource-group "$RG_NAME" --name "$ACR_NAME" --sku Basic --admin-enabled false

az appservice plan create \
  --resource-group "$RG_NAME" \
  --name "$PLAN_NAME" \
  --location "$LOCATION" \
  --is-linux \
  --sku B1
```

## Task 2: Build and push container image

Create application source:

```bash
mkdir -p container-app
cat > container-app/Dockerfile << 'EOF'
FROM mcr.microsoft.com/azure-app-service/python:3.11
WORKDIR /home/site/wwwroot
RUN printf "<html><body><h1>LP01 Container App</h1><p>version=v1</p></body></html>" > index.html
EOF
```

Build and push:

```bash
az acr login --name "$ACR_NAME"

docker build -t "$ACR_NAME.azurecr.io/$IMAGE_NAME:$IMAGE_TAG" container-app

docker push "$ACR_NAME.azurecr.io/$IMAGE_NAME:$IMAGE_TAG"
```

## Task 3: Deploy containerized web app

```bash
az webapp create \
  --resource-group "$RG_NAME" \
  --plan "$PLAN_NAME" \
  --name "$WEBAPP_NAME" \
  --deployment-container-image-name "$ACR_NAME.azurecr.io/$IMAGE_NAME:$IMAGE_TAG"

az webapp identity assign --resource-group "$RG_NAME" --name "$WEBAPP_NAME"
```

Grant AcrPull to managed identity:

```bash
PRINCIPAL_ID=$(az webapp identity show -g "$RG_NAME" -n "$WEBAPP_NAME" --query principalId -o tsv)
ACR_ID=$(az acr show -g "$RG_NAME" -n "$ACR_NAME" --query id -o tsv)

az role assignment create --assignee-object-id "$PRINCIPAL_ID" --assignee-principal-type ServicePrincipal --role AcrPull --scope "$ACR_ID"
```

## Task 4: Create staging slot and deploy v2

```bash
az webapp deployment slot create --resource-group "$RG_NAME" --name "$WEBAPP_NAME" --slot "$SLOT_NAME"

az webapp config appsettings set \
  --resource-group "$RG_NAME" \
  --name "$WEBAPP_NAME" \
  --slot "$SLOT_NAME" \
  --settings RELEASE_RING=staging BUILD_VERSION=v2
```

Build and push v2 image:

```bash
echo "<html><body><h1>LP01 Container App</h1><p>version=v2</p></body></html>" > container-app/index.html

docker build -t "$ACR_NAME.azurecr.io/$IMAGE_NAME:v2" container-app

docker push "$ACR_NAME.azurecr.io/$IMAGE_NAME:v2"

az webapp config container set \
  --resource-group "$RG_NAME" \
  --name "$WEBAPP_NAME" \
  --slot "$SLOT_NAME" \
  --container-image-name "$ACR_NAME.azurecr.io/$IMAGE_NAME:v2"
```

## Task 5: Promote and rollback

```bash
az webapp deployment slot swap \
  --resource-group "$RG_NAME" \
  --name "$WEBAPP_NAME" \
  --slot "$SLOT_NAME" \
  --target-slot production
```

Verify production endpoint and then rollback:

```bash
PROD_URL="https://$(az webapp show -g "$RG_NAME" -n "$WEBAPP_NAME" --query defaultHostName -o tsv)"
curl "$PROD_URL"

az webapp deployment slot swap \
  --resource-group "$RG_NAME" \
  --name "$WEBAPP_NAME" \
  --slot "$SLOT_NAME" \
  --target-slot production
```

## Validation Checks
- ACR contains both v1 and v2 image tags.
- Web app has managed identity enabled.
- AcrPull role assignment exists.
- Staging slot exists and supports promotion.
- Swap and rollback both succeed.

## Evidence to Capture
- `az acr repository show-tags` output.
- Slot list output before and after swap.
- Production endpoint output after promotion and rollback.

## Cleanup

```bash
az group delete --name "$RG_NAME" --yes --no-wait
```
