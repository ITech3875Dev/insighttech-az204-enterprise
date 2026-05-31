# InSight Technologies - AZ-204 Enterprise Training

This repository is the enterprise training workspace for Microsoft **AZ-204: Developing Solutions for Microsoft Azure**.

## Program focus
- Developer-first, exam-aligned AZ-204 learning paths
- Modular learning path model aligned to Microsoft Learn path granularity
- Repeatable labs with validation, remediation, and instructor-ready guidance
- Shared templates, scripts, and infrastructure assets reused across paths

## Canonical AZ-204 learning paths
1. `az204-lp01-implement-app-service-web-apps`
2. `az204-lp02-implement-azure-functions`
3. `az204-lp03-develop-solutions-blob-storage`
4. `az204-lp04-develop-solutions-cosmos-db`
5. `az204-lp05-implement-containerized-solutions`
6. `az204-lp06-implement-user-authentication-authorization`
7. `az204-lp07-implement-secure-azure-solutions`
8. `az204-lp08-implement-api-management`
9. `az204-lp09-develop-event-based-solutions`
10. `az204-lp10-develop-message-based-solutions`
11. `az204-lp11-troubleshoot-solutions-application-insights`

See `docs/program/az204-taxonomy.md` for the canonical structure.

## Migration status
- LP01-LP03 canonical tracks are being aligned from current production-ready material
- LP04-LP11 canonical tracks are scaffolded and queued for productionization
- Archived AZ-104 source material remains under `learning-paths/legacy-az104/`
- Archived broad-path AZ-204 source material remains under `learning-paths/legacy-az204-broad/`

## Student workflow (high-level)
1. Read `docs/program/cohort-guide.md`
2. Work in feature branches; do not push directly to `main`
3. Build modules and labs from `shared/templates/`
4. Submit pull requests with validation evidence and instructor notes

## Security
- No secrets in this repository
- Use interactive auth (`az login`, `Connect-AzAccount`) for student labs
- Instructor automation should use OIDC or secure secret storage

## Repo layout
- `docs/program/` governance, taxonomy, curriculum planning
- `docs/architecture/` architecture and delivery model
- `shared/` reusable templates, scripts, and infra assets
- `learning-paths/` canonical AZ-204 paths + legacy archive
