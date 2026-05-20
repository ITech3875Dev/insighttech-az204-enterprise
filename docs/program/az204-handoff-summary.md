# AZ-204 Handoff Summary

## Purpose
Use this file to continue AZ-204 repo work in a different VS Code window or a fresh Copilot Chat session.

## Current Repository
- Repo: `ITech3875Dev/insighttech-az204-enterprise`
- Local workspace folder: `insighttech-az204-enterprise`
- Current working branch: `feature/az204-taxonomy-lp02`
- Branch tracking: `origin/feature/az204-taxonomy-lp02`
- Current branch HEAD: `5386667` (`checkpoint: refine AZ-204 taxonomy and LP02 content`)

## Remote Setup
- `origin` points to the AZ-204 fork: `git@github.com:ITech3875Dev/insighttech-az204-enterprise.git`
- `upstream` points to the original source repo: `https://github.com/iginsighttech/insighttech-az104-enterprise.git`
- `main` tracks `origin/main`
- `develop` tracks `origin/develop`

## Completed Work

### Initial AZ-204 repo setup
- Forked/cloned the AZ-104 source into a dedicated AZ-204 repo
- Added `upstream` remote to the original source repo
- Created `develop` as the long-lived integration branch
- Set repo-local Git safety settings for Windows, including `core.filemode=false`

### Feature branch 1: buildout checklist
- Branch: `feature/az204-buildout-checklist`
- Added build plan file: `docs/program/az204-buildout-checklist.md`
- Scaffolded first AZ-204 learning path:
  - `learning-paths/az204-lp01-develop-azure-compute-solutions/`
- Merged intentionally through `upstream/main`
- Synced the AZ-204 fork so both `main` and `develop` point to commit `81490ad`
- Deleted the old feature branch from `origin`

### Feature branch 2: taxonomy and LP02
- Branch: `feature/az204-taxonomy-lp02`
- Added taxonomy definition file:
  - `docs/program/az204-taxonomy.md`
- Updated repo branding and curriculum direction:
  - `README.md`
  - `docs/program/curriculum-matrix.md`
  - `docs/program/az204-buildout-checklist.md`
- Scaffolded second AZ-204 learning path:
  - `learning-paths/az204-lp02-develop-for-azure-storage/`
- Refined the branch after initial LP02 scaffolding with a checkpoint commit that tightened taxonomy and LP02 content direction

### Local working tree enhancements after branch baseline
- Upgraded LP01 from scaffold to production-ready learning path content in the current working tree
- Upgraded LP02 from scaffold to production-ready learning path content in the current working tree
- Added reusable productionization playbook:
  - `docs/program/playbooks/az204-production-path-template.md`

## Recent Commits
- `5386667` `checkpoint: refine AZ-204 taxonomy and LP02 content`
- `b678cd5` `scaffold: add AZ-204 LP02 storage path templates`
- `1901d12` `docs: define AZ-204 taxonomy and curriculum baseline`
- `81490ad` merged baseline from earlier AZ-204 setup work

## Active AZ-204 Taxonomy
- `az204-lp01-develop-azure-compute-solutions`
- `az204-lp02-develop-for-azure-storage`
- `az204-lp03-implement-azure-security`
- `az204-lp04-monitor-troubleshoot-optimize`
- `az204-lp05-connect-consume-azure-services`

## Files to Review First
- `docs/program/az204-taxonomy.md`
- `docs/program/az204-buildout-checklist.md`
- `docs/program/curriculum-matrix.md`
- `learning-paths/az204-lp01-develop-azure-compute-solutions/README.md`
- `learning-paths/az204-lp02-develop-for-azure-storage/README.md`
- `docs/program/playbooks/az204-production-path-template.md`

## Current Scaffold Maturity
- LP01 is production-ready in the working tree with full path README, module docs, beginner/intermediate/advanced/capstone labs, assessment package, masterclass agenda, and real validation checks.
- LP02 is production-ready in the working tree with full path README, module docs, beginner/intermediate/advanced/capstone labs, assessment package, masterclass agenda, and real validation checks.
- LP01 validation script: `learning-paths/az204-lp01-develop-azure-compute-solutions/validation/az204-lp01-validate.ps1`
- LP02 validation script: `learning-paths/az204-lp02-develop-for-azure-storage/validation/az204-lp02-validate.ps1`
- The playbook `docs/program/playbooks/az204-production-path-template.md` defines the reusable production-ready contract for LP03-LP05.
- These LP01 and LP02 upgrades are currently local working tree changes and should be committed before treating them as the new branch baseline.

## Highest-Priority Remaining AZ-104-Oriented Docs
- `docs/program/curriculum-alignment.md` is still a full AZ-104 curriculum tracker and remains one of the biggest top-level mismatches.
- `docs/architecture/overall-lab-program-architecture.md` still describes the AZ-104 LP01-LP06 architecture model.
- `docs/program/enterprise-enhancements-domain1.md` is still AZ-104 domain-specific.
- `shared/templates/module/README.md` still carries AZ-104 wording, so new content generated from templates will inherit the wrong framing until it is updated.
- Legacy `learning-paths/lp01-*` through `lp06-*` remain intentionally as source material and should not be treated as accidental drift.

## Recommended Next Steps
1. Open a pull request for `feature/az204-taxonomy-lp02` if it has not been merged yet.
2. Replace the highest-priority top-level AZ-104 documents before broadening the AZ-204 surface area:
  - `docs/program/curriculum-alignment.md`
  - `docs/architecture/overall-lab-program-architecture.md`
  - `docs/program/enterprise-enhancements-domain1.md`
  - `shared/templates/module/README.md`
3. Commit the LP01 and LP02 production-ready changes so the branch baseline matches the current working tree.
4. Use `docs/program/playbooks/az204-production-path-template.md` to productionize `az204-lp03-implement-azure-security` next.

## Suggested Prompt For New Chat
Continue AZ-204 repo work from `docs/program/az204-handoff-summary.md`. Assume the repo already has LP01 and LP02 productionized in the working tree, AZ-204 taxonomy defined, `origin` is the AZ-204 fork, `upstream` is the AZ-104 source repo, the current branch head includes commit `5386667`, the reusable productionization blueprint lives at `docs/program/playbooks/az204-production-path-template.md`, and the next likely task is either top-level AZ-204 doc replacement or productionizing LP03 security using the same pattern.
