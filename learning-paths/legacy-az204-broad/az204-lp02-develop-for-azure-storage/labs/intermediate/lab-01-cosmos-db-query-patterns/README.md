# Lab 01 (Intermediate): Cosmos DB Query Patterns

## Scenario
Design and test a Cosmos DB-backed application workflow with partition-aware writes, point reads, and filtered queries using the Azure Cosmos SDK for Python.

## Prerequisites
- Azure subscription access.
- Azure CLI installed.
- Python 3.11 or later installed.

## Variables

```bash
SUBSCRIPTION_ID="<subscription-id>"
LOCATION="eastus2"
RG_NAME="rg-az204-storage-dev-eastus2-01"
COSMOS_ACCOUNT="cosmos-az204-dev-01"
DATABASE_NAME="OrdersDb"
CONTAINER_NAME="Orders"
PARTITION_KEY="/customerId"
```

## Tasks
1. Create Cosmos DB account, database, and container.
2. Install SDK and create sample items.
3. Execute point reads and filtered queries.
4. Review partitioning and throughput behavior.
5. Capture evidence for validation.

## Task 1: Create Cosmos DB resources

```bash
az account set --subscription "$SUBSCRIPTION_ID"

az cosmosdb create \
	--name "$COSMOS_ACCOUNT" \
	--resource-group "$RG_NAME" \
	--locations regionName="$LOCATION" failoverPriority=0 isZoneRedundant=False \
	--default-consistency-level Session

az cosmosdb sql database create \
	--account-name "$COSMOS_ACCOUNT" \
	--resource-group "$RG_NAME" \
	--name "$DATABASE_NAME"

az cosmosdb sql container create \
	--account-name "$COSMOS_ACCOUNT" \
	--resource-group "$RG_NAME" \
	--database-name "$DATABASE_NAME" \
	--name "$CONTAINER_NAME" \
	--partition-key-path "$PARTITION_KEY" \
	--throughput 400
```

## Task 2: Install SDK and write sample items

```bash
python -m pip install azure-cosmos
```

Create `cosmos_workflow.py`:

```python
from azure.cosmos import CosmosClient

endpoint = "<replace-endpoint>"
key = "<replace-key>"
database_name = "OrdersDb"
container_name = "Orders"

client = CosmosClient(endpoint, credential=key)
database = client.get_database_client(database_name)
container = database.get_container_client(container_name)

items = [
		{"id": "1", "customerId": "cust-100", "status": "open", "total": 125.50},
		{"id": "2", "customerId": "cust-100", "status": "closed", "total": 20.00},
		{"id": "3", "customerId": "cust-200", "status": "open", "total": 87.25},
]

for item in items:
		container.upsert_item(item)

print("Inserted", len(items), "items")

point = container.read_item(item="1", partition_key="cust-100")
print("PointRead", point)

query = "SELECT * FROM c WHERE c.customerId = @customerId AND c.status = @status"
params = [
		{"name": "@customerId", "value": "cust-100"},
		{"name": "@status", "value": "open"},
]

results = list(container.query_items(query=query, parameters=params, enable_cross_partition_query=False))
print("QueryResults", results)
```

Get endpoint and key:

```bash
ENDPOINT=$(az cosmosdb show -g "$RG_NAME" -n "$COSMOS_ACCOUNT" --query documentEndpoint -o tsv)
KEY=$(az cosmosdb keys list -g "$RG_NAME" -n "$COSMOS_ACCOUNT" --query primaryMasterKey -o tsv)
python cosmos_workflow.py
```

Replace placeholder values in the script before execution.

## Task 3: Review configuration and query behavior

```bash
az cosmosdb sql container show \
	--account-name "$COSMOS_ACCOUNT" \
	--resource-group "$RG_NAME" \
	--database-name "$DATABASE_NAME" \
	--name "$CONTAINER_NAME" \
	-o json
```

Confirm the partition key path is `/customerId` and throughput is `400` RU/s.

## Task 4: Capture evidence

Record:
- Insert and query output from Python script
- Container definition output
- Partition key rationale for the chosen item model

## Validation Checks
- Data inserts succeed.
- Point reads and filtered queries return expected results.
- Container partition key path is correct.
- Throughput baseline and consistency settings are visible in command output.

## Cleanup

```bash
az group delete --name "$RG_NAME" --yes --no-wait
```
