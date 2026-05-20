# Lab 01 (Beginner): Blob SDK Workflows

## Scenario
Implement a simple application workflow that uploads, lists, and retrieves blobs using the Azure Storage SDK for Python and captures validation evidence.

## Prerequisites
- Azure subscription access.
- Azure CLI installed.
- Python 3.11 or later installed.

## Variables

Azure CLI (Bash):

```bash
SUBSCRIPTION_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az204-storage-dev-eastus2-01"
STORAGE_ACCOUNT="staz204blobdev01"
CONTAINER_NAME="appdata"
LOCAL_FILE="sample.txt"
```

PowerShell:

```powershell
$SubscriptionId = "<subscription-id>"
$Location = "eastus2"
$ResourceGroupName = "rg-az204-storage-dev-eastus2-01"
$StorageAccountName = "staz204blobdev01"
$ContainerName = "appdata"
$LocalFile = "sample.txt"
```

## Tasks
1. Set subscription context and create storage resources.
2. Create a blob container and sample file.
3. Install SDK and upload/list/download blobs with Python.
4. Validate content and container behavior.
5. Capture outputs for instructor review.

## Task 1: Create storage resources

Azure CLI:

```bash
az account set --subscription "$SUBSCRIPTION_ID"
az group create --name "$RG_NAME" --location "$LOCATION" --tags env=dev workload=az204 owner=student

az storage account create \
	--name "$STORAGE_ACCOUNT" \
	--resource-group "$RG_NAME" \
	--location "$LOCATION" \
	--sku Standard_LRS \
	--kind StorageV2 \
	--min-tls-version TLS1_2 \
	--allow-blob-public-access false
```

PowerShell:

```powershell
Set-AzContext -SubscriptionId $SubscriptionId
New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Tag @{env="dev";workload="az204";owner="student"}
New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName -Location $Location -SkuName Standard_LRS -Kind StorageV2 -MinimumTlsVersion TLS1_2 -AllowBlobPublicAccess $false
```

## Task 2: Create container and sample file

```bash
ACCOUNT_KEY=$(az storage account keys list -g "$RG_NAME" -n "$STORAGE_ACCOUNT" --query "[0].value" -o tsv)

az storage container create \
	--name "$CONTAINER_NAME" \
	--account-name "$STORAGE_ACCOUNT" \
	--account-key "$ACCOUNT_KEY"

echo "Hello from LP02 Blob Storage" > "$LOCAL_FILE"
```

## Task 3: Use Python SDK for upload/list/download

Install package:

```bash
python -m pip install azure-storage-blob
```

Create `blob_workflow.py`:

```python
from azure.storage.blob import BlobServiceClient

connection_string = "<replace-with-connection-string>"
container_name = "appdata"
blob_name = "sample.txt"

service = BlobServiceClient.from_connection_string(connection_string)
container = service.get_container_client(container_name)

with open("sample.txt", "rb") as data:
		container.upload_blob(name=blob_name, data=data, overwrite=True)

print("Uploaded", blob_name)

for blob in container.list_blobs():
		print("Listed", blob.name)

downloaded = container.download_blob(blob_name).readall().decode("utf-8")
print("Downloaded", downloaded)
```

Get connection string and run:

```bash
CONNECTION_STRING=$(az storage account show-connection-string -g "$RG_NAME" -n "$STORAGE_ACCOUNT" --query connectionString -o tsv)
python blob_workflow.py
```

Replace the placeholder connection string in the script before execution.

## Task 4: Validate storage behavior

```bash
az storage blob list \
	--container-name "$CONTAINER_NAME" \
	--account-name "$STORAGE_ACCOUNT" \
	--account-key "$ACCOUNT_KEY" \
	-o table
```

Confirm the uploaded blob exists and the downloaded content matches the source file.

## Task 5: Capture evidence

Record:
- Blob list output
- Python script output
- Storage account security configuration output

## Validation Checks
- Blob upload succeeds.
- Blob retrieval returns expected content.
- Storage account blocks public blob access.
- Container and blob inventory are visible in command output.

## Cleanup

```bash
az group delete --name "$RG_NAME" --yes --no-wait
```

Keep the resource group if continuing directly into the intermediate, advanced, or capstone LP02 labs.
