# Lab 01 (Intermediate): App Service Deployment Slots

## Scenario
Deploy a production and staging workflow for an App Service web app, then execute a controlled swap and verify zero-risk rollback capability.

## Prerequisites
- Existing LP01 resource group or equivalent access.
- Azure CLI installed.
- `zip` utility available for deployment package creation.

## Variables

```bash
SUBSCRIPTION_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az204-compute-dev-eastus2-01"
PLAN_NAME="asp-az204-compute-dev-01"
WEBAPP_NAME="app-az204-compute-dev-01"
SLOT_NAME="staging"
RUNTIME="PYTHON:3.11"
```

## Tasks
1. Create App Service plan and production app.
2. Deploy baseline build to production.
3. Create and configure staging slot.
4. Deploy release candidate to staging and warm it up.
5. Swap staging to production and verify health.
6. Execute rollback swap simulation.

## Task 1: Create plan and web app

```bash
az account set --subscription "$SUBSCRIPTION_ID"

az appservice plan create \
	--resource-group "$RG_NAME" \
	--name "$PLAN_NAME" \
	--location "$LOCATION" \
	--is-linux \
	--sku B1

az webapp create \
	--resource-group "$RG_NAME" \
	--plan "$PLAN_NAME" \
	--name "$WEBAPP_NAME" \
	--runtime "$RUNTIME"
```

## Task 2: Deploy baseline build (production)

Create a minimal version file:

```bash
mkdir -p app-v1
cat > app-v1/index.html << 'EOF'
<html><body><h1>LP01 Compute App</h1><p>version=v1</p></body></html>
EOF

(cd app-v1 && zip -r ../app-v1.zip .)

az webapp deploy \
	--resource-group "$RG_NAME" \
	--name "$WEBAPP_NAME" \
	--src-path app-v1.zip \
	--type zip
```

Verify:

```bash
PROD_URL="https://$(az webapp show -g "$RG_NAME" -n "$WEBAPP_NAME" --query defaultHostName -o tsv)"
curl "$PROD_URL"
```

## Task 3: Create and configure staging slot

```bash
az webapp deployment slot create \
	--resource-group "$RG_NAME" \
	--name "$WEBAPP_NAME" \
	--slot "$SLOT_NAME"

az webapp config appsettings set \
	--resource-group "$RG_NAME" \
	--name "$WEBAPP_NAME" \
	--slot "$SLOT_NAME" \
	--settings RELEASE_RING="staging" BUILD_VERSION="v2"
```

## Task 4: Deploy release candidate to staging

```bash
mkdir -p app-v2
cat > app-v2/index.html << 'EOF'
<html><body><h1>LP01 Compute App</h1><p>version=v2</p></body></html>
EOF

(cd app-v2 && zip -r ../app-v2.zip .)

az webapp deploy \
	--resource-group "$RG_NAME" \
	--name "$WEBAPP_NAME" \
	--slot "$SLOT_NAME" \
	--src-path app-v2.zip \
	--type zip
```

Warm-up and verify staging endpoint:

```bash
STAGE_URL="https://$(az webapp show -g "$RG_NAME" -n "$WEBAPP_NAME" --slot "$SLOT_NAME" --query defaultHostName -o tsv)"
curl "$STAGE_URL"
```

## Task 5: Swap staging into production

```bash
az webapp deployment slot swap \
	--resource-group "$RG_NAME" \
	--name "$WEBAPP_NAME" \
	--slot "$SLOT_NAME" \
	--target-slot production
```

Post-swap checks:

```bash
curl "$PROD_URL"
az webapp deployment slot list -g "$RG_NAME" -n "$WEBAPP_NAME" -o table
```

Production should now serve `version=v2`.

## Task 6: Rollback simulation

Perform a reverse swap to confirm rollback readiness:

```bash
az webapp deployment slot swap \
	--resource-group "$RG_NAME" \
	--name "$WEBAPP_NAME" \
	--slot "$SLOT_NAME" \
	--target-slot production
```

Verify production serves the prior version (`version=v1`) and document rollback decision criteria.

## Validation Checks
- App Service plan exists and web app is running.
- Staging slot exists.
- Swap and rollback operations complete successfully.
- Production and staging responses show expected version transitions.
- Slot app settings remain isolated after swap.

## Cleanup
```bash
az group delete --name "$RG_NAME" --yes --no-wait
```

If continuing to advanced or capstone labs, keep resources and proceed.
