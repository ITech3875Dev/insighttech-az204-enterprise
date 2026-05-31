# AZ-204 Handoff Summary

## Purpose
Use this file to continue AZ-204 repo work in a new VS Code window or a fresh Copilot Chat session.

## Canonical Program Model
The repository now uses the canonical 11-path AZ-204 structure:
- `az204-lp01-implement-app-service-web-apps`
- `az204-lp02-implement-azure-functions`
- `az204-lp03-develop-solutions-blob-storage`
- `az204-lp04-develop-solutions-cosmos-db`
- `az204-lp05-implement-containerized-solutions`
- `az204-lp06-implement-user-authentication-authorization`
- `az204-lp07-implement-secure-azure-solutions`
- `az204-lp08-implement-api-management`
- `az204-lp09-develop-event-based-solutions`
- `az204-lp10-develop-message-based-solutions`
- `az204-lp11-troubleshoot-solutions-application-insights`

## Source-of-Truth Files
Review these first:
- `README.md`
- `docs/program/az204-taxonomy.md`
- `docs/program/curriculum-matrix.md`
- `docs/program/curriculum-alignment.md`
- `docs/architecture/overall-lab-program-architecture.md`
- `CODEOWNERS`

## Migration Notes
- Legacy AZ-104 content is archived under `learning-paths/legacy-az104/`.
- Earlier broad AZ-204 path folders are archived under `learning-paths/legacy-az204-broad/`.
- All new planning and delivery work must target the canonical LP01-LP11 folders.

## Current Delivery Status
- Canonical LP01-LP11 folders are scaffolded.
- Existing production-ready source material should be migrated into canonical folders in priority order.
- Validation convention remains `validation/az204-lpXX-validate.ps1` for each canonical path.

## Recommended Next Steps
1. Prioritize productionization of canonical LP01-LP03 from existing content.
2. Build LP04-LP11 using the same production quality bar and validation contract.
3. Keep docs and ownership mappings aligned to canonical LP01-LP11 names only.
4. Use `docs/program/playbooks/az204-production-path-template.md` for consistent build standards.


