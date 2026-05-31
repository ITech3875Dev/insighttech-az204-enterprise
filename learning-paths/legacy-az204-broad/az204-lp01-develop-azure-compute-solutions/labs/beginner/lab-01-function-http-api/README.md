# Lab 01 (Beginner): Function HTTP API

## Scenario
Build and deploy a minimal HTTP-triggered Azure Function that returns a structured JSON response for health checks and service metadata.

## Prerequisites
- Azure subscription access.
- Azure CLI and Functions Core Tools installed.
- PowerShell 7 or Bash shell.

## Variables

Azure CLI (Bash):

```bash
SUBSCRIPTION_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az204-compute-dev-eastus2-01"
STORAGE_NAME="staz204funcdev01"
FUNCTION_APP_NAME="func-az204-compute-dev-01"
FUNCTION_NAME="GetServiceStatus"
```

PowerShell:

```powershell
$SubscriptionId = "<subscription-id>"
$Location = "eastus2"
$ResourceGroupName = "rg-az204-compute-dev-eastus2-01"
$StorageAccountName = "staz204funcdev01"
$FunctionAppName = "func-az204-compute-dev-01"
$FunctionName = "GetServiceStatus"
```

## Tasks
1. Set subscription context.
2. Create resource group and storage account.
3. Create Function App with system-assigned identity.
4. Create HTTP function endpoint code locally.
5. Publish function and validate endpoint response.
6. Capture run evidence and invocation logs.

## Task 1: Set subscription context

Azure CLI:

```bash
az account set --subscription "$SUBSCRIPTION_ID"
az account show --query "{name:name,id:id}" -o table
```

PowerShell:

```powershell
Set-AzContext -SubscriptionId $SubscriptionId
Get-AzContext | Select-Object Name, Subscription
```

## Task 2: Create resource group and storage account

Azure CLI:

```bash
az group create --name "$RG_NAME" --location "$LOCATION" --tags env=dev workload=az204 owner=student
az storage account create \
	--name "$STORAGE_NAME" \
	--resource-group "$RG_NAME" \
	--location "$LOCATION" \
	--sku Standard_LRS \
	--min-tls-version TLS1_2 \
	--allow-blob-public-access false
```

PowerShell:

```powershell
New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Tag @{env="dev";workload="az204";owner="student"}
New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -Location $Location -SkuName Standard_LRS -MinimumTlsVersion TLS1_2 -AllowBlobPublicAccess $false
```

## Task 3: Create Function App with managed identity

Azure CLI:

```bash
az functionapp create \
	--name "$FUNCTION_APP_NAME" \
	--resource-group "$RG_NAME" \
	--storage-account "$STORAGE_NAME" \
	--consumption-plan-location "$LOCATION" \
	--runtime powershell \
	--runtime-version 7.4 \
	--functions-version 4

az functionapp identity assign --name "$FUNCTION_APP_NAME" --resource-group "$RG_NAME"
```

PowerShell:

```powershell
New-AzFunctionApp -Name $FunctionAppName -ResourceGroupName $ResourceGroupName -StorageAccountName $StorageAccountName -Runtime PowerShell -FunctionsVersion 4 -Location $Location -OSType Linux
Update-AzFunctionApp -Name $FunctionAppName -ResourceGroupName $ResourceGroupName -IdentityType SystemAssigned
```

## Task 4: Create and publish HTTP function code

Create local project and function:

```bash
mkdir lp01-lab01 && cd lp01-lab01
func init --worker-runtime powershell
func new --name "$FUNCTION_NAME" --template "HTTP trigger"
```

Replace `run.ps1` content for the generated function with:

```powershell
using namespace System.Net

param($Request, $TriggerMetadata)

$body = @{
	service = "lp01-compute-api"
	status = "ok"
	timestamp = (Get-Date).ToUniversalTime().ToString("o")
	source = "azure-function"
}

Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
	StatusCode = [HttpStatusCode]::OK
	Body = $body
})
```

Publish:

```bash
func azure functionapp publish "$FUNCTION_APP_NAME"
```

## Task 5: Validate function response

```bash
FUNCTION_URL=$(az functionapp function show \
	--resource-group "$RG_NAME" \
	--name "$FUNCTION_APP_NAME" \
	--function-name "$FUNCTION_NAME" \
	--query "invokeUrlTemplate" -o tsv)

curl "$FUNCTION_URL"
```

Expected response should include `service`, `status`, `timestamp`, and `source` values.

## Task 6: Capture logs and evidence

```bash
az functionapp log tail --name "$FUNCTION_APP_NAME" --resource-group "$RG_NAME"
```

Record:
- Function URL
- Sample response payload
- Log snippet from successful invocation

## Validation Checks
- Function App exists and is in running state.
- System-assigned managed identity is enabled.
- HTTP endpoint returns successful JSON payload.
- Invocation logs show successful execution.

## Cleanup
```bash
az group delete --name "$RG_NAME" --yes --no-wait
```

Keep the resource group if you are proceeding directly to the intermediate and advanced LP01 labs.
