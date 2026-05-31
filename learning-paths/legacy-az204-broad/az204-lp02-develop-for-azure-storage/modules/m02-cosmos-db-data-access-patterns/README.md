# Module M02: Cosmos DB Data Access Patterns

## Module Overview
| Item | Details |
|------|---------|
| Duration | 3 to 4 hours |
| Difficulty | Intermediate to Advanced |
| Primary services | Azure Cosmos DB for NoSQL |
| Labs | Intermediate and Capstone |

## Learning Objectives
- Model data around partition-aware reads and writes.
- Implement Cosmos DB inserts, point reads, and query patterns.
- Evaluate throughput, consistency, and troubleshooting tradeoffs.

## Module Flow
1. Create Cosmos DB account, SQL database, and container.
2. Define item model and partition key selection.
3. Insert sample items and execute partition-aware queries.
4. Capture evidence and validate container configuration.

## Required Deliverables
- Documented item model and partition key rationale.
- Query output showing expected records.
- Throughput and configuration review notes.
- Validation output from LP02 script.

## Associated Labs
- `labs/intermediate/lab-01-cosmos-db-query-patterns/README.md`
- `labs/capstone/lab-01-storage-solutions-production-readiness/README.md`

## Exit Criteria
- Learner can justify partition strategy for a simple workload.
- Learner can execute and verify Cosmos DB query operations.
- Learner can interpret validation failures tied to configuration drift.
