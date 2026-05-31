# Curriculum Alignment Tracker - AZ-204 (2026)

## Purpose
Track how the InSight Technologies AZ-204 curriculum aligns to Microsoft exam skills using the canonical 11-path model.

## AZ-204 Exam Composition

| Domain | Weight | Canonical LP Coverage |
|--------|--------|-----------------------|
| Develop Azure compute solutions | ~25% | LP01, LP02, LP05 |
| Develop for Azure storage | ~15% | LP03, LP04 |
| Implement Azure security | ~20% | LP06, LP07 |
| Monitor, troubleshoot, and optimize Azure solutions | ~15% | LP11 |
| Connect to and consume Azure services and third-party services | ~15% | LP08, LP09, LP10 |

> Note: Exam weights are approximate and can change. Always verify against the latest Microsoft study guide.

## Canonical LP Coverage Matrix

| Learning Path | Folder | Primary Domain | Status |
|---------------|--------|----------------|--------|
| LP01 - Implement Azure App Service web apps | `learning-paths/az204-lp01-implement-app-service-web-apps` | Compute | In progress |
| LP02 - Implement Azure Functions | `learning-paths/az204-lp02-implement-azure-functions` | Compute | In progress |
| LP03 - Develop solutions that use Blob storage | `learning-paths/az204-lp03-develop-solutions-blob-storage` | Storage | In progress |
| LP04 - Develop solutions that use Azure Cosmos DB | `learning-paths/az204-lp04-develop-solutions-cosmos-db` | Storage | Planned |
| LP05 - Implement containerized solutions | `learning-paths/az204-lp05-implement-containerized-solutions` | Compute | Planned |
| LP06 - Implement user authentication and authorization | `learning-paths/az204-lp06-implement-user-authentication-authorization` | Security | In progress |
| LP07 - Implement secure Azure solutions | `learning-paths/az204-lp07-implement-secure-azure-solutions` | Security | In progress |
| LP08 - Implement API Management | `learning-paths/az204-lp08-implement-api-management` | Connect/Consume | Planned |
| LP09 - Develop event-based solutions | `learning-paths/az204-lp09-develop-event-based-solutions` | Connect/Consume | Planned |
| LP10 - Develop message-based solutions | `learning-paths/az204-lp10-develop-message-based-solutions` | Connect/Consume | Planned |
| LP11 - Troubleshoot solutions by using Application Insights | `learning-paths/az204-lp11-troubleshoot-solutions-application-insights` | Monitor/Troubleshoot | Planned |

## Domain-to-LP Skill Mapping

| Skill Area | Canonical LP |
|------------|--------------|
| App Service app deployment and configuration | LP01 |
| Function triggers, bindings, and durable workflows | LP02 |
| Blob SDK operations and lifecycle patterns | LP03 |
| Cosmos DB data modeling and SDK access patterns | LP04 |
| Container Apps and container lifecycle workflows | LP05 |
| Identity platform, OAuth, and app authorization | LP06 |
| Managed identity, Key Vault, and secure configuration | LP07 |
| API gateway policy and API lifecycle controls | LP08 |
| Event Grid publish/subscribe integration | LP09 |
| Service Bus and queue/topic processing | LP10 |
| Application Insights diagnostics and telemetry troubleshooting | LP11 |

## Coverage Gaps and Roadmap

| Gap | Domain | Target LP |
|-----|--------|-----------|
| Cosmos DB advanced data access labs | Storage | LP04 |
| Container deployment hardening labs | Compute | LP05 |
| API Management policy labs | Connect/Consume | LP08 |
| Event routing and filter labs | Connect/Consume | LP09 |
| Service Bus reliability labs | Connect/Consume | LP10 |
| End-to-end observability and incident workflows | Monitor/Troubleshoot | LP11 |

## Student Pass Rate Tracking

| Cohort | Start Date | Students | LP Completion >=70% | Attempted AZ-204 | Pass Rate | Notes |
|--------|-----------|----------|---------------------|------------------|-----------|-------|
| Cohort 1 | 2026 | TBD | TBD | TBD | TBD | Program launch |
| Target | - | - | >=85% | - | >=85% | |

## Scoring Bands

| Score | Band | Recommendation |
|-------|------|----------------|
| 90-100% | Mastery | Ready for exam |
| 76-89% | Proficient | Review misses and rerun validation |
| 70-75% | Passing | Retake weak modules before exam |
| <70% | Needs Work | Full LP remediation required |

## Related Resources

- AZ-204 Study Guide: https://aka.ms/AZ204-StudyGuide
- AZ-204 Practice Assessment: https://learn.microsoft.com/credentials/certifications/azure-developer/practice/
- `docs/program/az204-taxonomy.md`
- `docs/program/curriculum-matrix.md`
- `docs/program/standards-and-guardrails.md`

Last Updated: 2026
Next Review: After LP11 baseline delivery



