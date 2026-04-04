# InSight Technologies — AZ-104 Enterprise Training (Enterprise Repo Scaffold)

This repository contains enterprise-grade, exam-aligned training for Microsoft **AZ-104**.

**Included in this scaffold**
- Governance & contribution controls (CODEOWNERS, SECURITY, PR/Issue templates)
- CI gates (Markdown lint, Bicep compile, secret scanning)
- Shared templates (module + lab)
- Shared skeleton (Bicep modules + scripts + naming/tagging standards)
- **LP01 (Identity & Governance)** skeleton
- **M01 module pre-filled**
- **Beginner Lab-01 populated** (step-by-step Portal + Az CLI + PowerShell + Bicep guidance + validation)

## Student workflow (high-level)
1. Read: `docs/program/cohort-guide.md`
2. Work in branches (no direct pushes to `main`)
3. Copy templates from `shared/templates/` when building new modules/labs
4. Submit PR with evidence (validation output + command output + screenshots where required)

## Security
- **No secrets in this repo. Ever.**
- Students should use interactive auth (`az login`, `Connect-AzAccount`).
- Instructor automation should use GitHub OIDC or GitHub Secrets (instructor-only).

## Repo layout
- `docs/program/` — program governance, rubrics, standards
- `docs/architecture/` — overall program architecture model and integration views
- `shared/` — reusable templates, scripts, and Bicep module skeleton
- `learning-paths/` — learning paths, modules, labs, exams
