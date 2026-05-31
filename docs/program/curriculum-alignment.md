# Curriculum Alignment Tracker — AZ-204 (2026)

## Purpose
This document tracks how the InSight Technologies AZ-204 training aligns with the current Microsoft exam.
Updated after each LP release and following any Microsoft exam refresh.

---

## AZ-204 Exam Composition

| Domain | Weight | LP Coverage |
|--------|--------|-------------|
| Develop Azure compute solutions | ~25% | LP01 (App Service, Azure Functions) |
| Develop for Azure storage | ~15% | LP02 (Blob Storage, Cosmos DB) |
| Implement Azure security | ~20% | LP03 (Key Vault, managed identity, MSAL, SAS) |
| Monitor, troubleshoot, and optimize Azure solutions | ~15% | LP04 (App Insights, Log Analytics, caching) |
| Connect to and consume Azure services and third-party services | ~15% | LP05 (API Management, Service Bus, Event Grid) |

> Note: Exam weights are approximate and subject to Microsoft refresh cycles.
> Always verify against the latest study guide: https://aka.ms/AZ204-StudyGuide

---

## LP Coverage Matrix

| Learning Path | Exam Domain | Modules | Status |
|---------------|-------------|---------|--------|
| LP01 — Develop Azure Compute Solutions | Compute (~25%) | App Service, Azure Functions | ✅ Production-ready |
| LP02 — Develop for Azure Storage | Storage (~15%) | Blob SDK, Cosmos DB | ✅ Production-ready |
| LP03 — Implement Azure Security | Security (~20%) | Authentication & Authorization, Key Vault & Managed Identity | ✅ Production-ready |
| LP04 — Monitor and Optimize | Monitor (~15%) | Application Insights, caching & CDN | ⏳ Planned |
| LP05 — Connect and Consume Services | Connect/Consume (~15%) | API Management, messaging (Service Bus, Event Grid) | ⏳ Planned |

---

## Detailed Coverage — LP01 (Compute)

| Exam Skill | InSight Coverage | Evidence |
|------------|-----------------|----------|
| Create Azure App Service web apps | M01: App Service | Beginner + Intermediate labs |
| Enable diagnostics logging | M01: App Service | Advanced lab |
| Deploy code to a web app | M01: App Service | Deployment slots lab |
| Configure web app settings | M01: App Service | All lab tiers |
| Implement Azure Functions | M01: Azure Functions | Function trigger labs |
| Implement input and output bindings | M01: Azure Functions | Intermediate lab |
| Implement durable functions | M01: Azure Functions | Advanced lab |

---

## Detailed Coverage — LP02 (Storage)

| Exam Skill | InSight Coverage | Evidence |
|------------|-----------------|----------|
| Move items in Blob Storage between containers | M01: Blob Storage | Beginner lab |
| Set and retrieve properties and metadata | M01: Blob Storage | Intermediate lab |
| Perform operations on data by using appropriate SDK | M01: Blob Storage | All lab tiers |
| Create a Cosmos DB database | M02: Cosmos DB | Beginner lab |
| Implement time-to-live (TTL) for data | M02: Cosmos DB | Intermediate lab |
| Write stored procedures, triggers, UDFs | M02: Cosmos DB | Advanced lab |

---

## Detailed Coverage — LP03 (Security)

| Exam Skill | InSight Coverage | Evidence |
|------------|-----------------|----------|
| Implement user authentication and authorization (MSAL, Microsoft Identity Platform) | M01: Authentication & Authorization | Advanced lab, masterclass |
| Implement delegated permissions | M01: Authentication & Authorization | Advanced lab |
| Create and implement shared access signatures | M01: Authentication & Authorization | Advanced + capstone lab |
| Implement solutions that interact with Microsoft Graph | M01: Authentication & Authorization | Advanced lab extension |
| Implement managed identities for Azure resources | M02: Key Vault & Managed Identity | Intermediate + capstone lab |
| Set and retrieve a secret from Azure Key Vault | M02: Key Vault & Managed Identity | Beginner + capstone lab |
| Configure and implement Key Vault (RBAC, purge protection, rotation) | M02: Key Vault & Managed Identity | All lab tiers |
| Implement App Configuration references to Key Vault | M02: Key Vault & Managed Identity | Capstone lab |

---

## Coverage Gaps and Roadmap

### 🔴 Not Yet Delivered

| Gap | Domain | Target LP |
|-----|--------|-----------|
| Application Insights SDK integration | Monitor | LP04 |
| Log Analytics KQL queries | Monitor | LP04 |
| Redis Cache (Azure Cache for Redis) | Monitor/Optimize | LP04 |
| Azure CDN configuration | Monitor/Optimize | LP04 |
| API Management policies | Connect/Consume | LP05 |
| Service Bus queues and topics | Connect/Consume | LP05 |
| Event Grid routing and filtering | Connect/Consume | LP05 |
| Webhook and notification hub integration | Connect/Consume | LP05 |

### 🟢 Covered — No Gaps

- ✅ App Service deployment and configuration
- ✅ Azure Functions (all trigger types, durable functions)
- ✅ Blob Storage SDK operations
- ✅ Cosmos DB data access patterns
- ✅ Microsoft Identity Platform (OAuth 2.0, MSAL)
- ✅ Key Vault (RBAC auth, soft-delete, purge protection, SDK)
- ✅ Managed identity (system + user-assigned, ACI)
- ✅ Shared Access Signatures (account, service, stored policy)
- ✅ App Configuration Key Vault references

---

## Student Pass Rate Tracking

| Cohort | Start Date | Students | LP Completion ≥70% | Attempted AZ-204 | Pass Rate | Notes |
|--------|-----------|----------|--------------------|-----------------|-----------|-------|
| Cohort 1 | 2026 | TBD | TBD | TBD | TBD | Program launch |
| **Target** | — | — | ≥85% | — | ≥85% | |

---

## Scoring Bands (All LPs)

| Score | Band | Recommendation |
|-------|------|----------------|
| 90–100% | Mastery | Ready for exam |
| 76–89% | Proficient | Review missed areas; re-run validation |
| 70–75% | Passing | Retake relevant module before exam |
| <70% | Needs Work | Full LP review required |

---

## AZ-204 Certification Progression

| Certification | Prerequisite | Overlap |
|---------------|-------------|---------|
| AZ-900 (Fundamentals) | None | Pre-req or equivalent experience |
| **AZ-204 (Developer Associate)** | AZ-900 or equivalent | **TARGET** — 100% |
| AZ-400 (DevOps Engineer Expert) | AZ-204 + AZ-104 | High overlap: CI/CD, security |
| AZ-305 (Solutions Architect Expert) | AZ-104 recommended | High overlap: architecture patterns |

---

## Related Resources

- **AZ-204 Study Guide**: https://aka.ms/AZ204-StudyGuide
- **AZ-204 Learning Path (MS Learn)**: https://learn.microsoft.com/training/paths/create-azure-app-service-web-apps/
- **Practice Assessment**: https://learn.microsoft.com/credentials/certifications/azure-developer/practice/
- [Standards and Guardrails](standards-and-guardrails.md)
- [Grading Rubrics](grading-rubrics.md)
- [Cohort Guide](cohort-guide.md)

---

**Last Updated**: 2026  
**Next Review**: After LP04 delivery
