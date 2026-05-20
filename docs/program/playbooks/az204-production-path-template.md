# AZ-204 Production Learning Path Template

## Purpose
Use this template to convert a scaffolded AZ-204 learning path into production-ready curriculum with consistent quality and validation standards.

## Production-Ready Definition
A path is production-ready when all items below are complete:
- Path README includes outcomes, audience, delivery model, and definition of done.
- At least two modules have concrete objectives and deliverables.
- Lab chain exists across beginner, intermediate, advanced, and capstone levels.
- Validation script performs real resource/config assertions.
- Practice exam includes 50 questions and a maintained answer key.
- Masterclass artifact provides executable instructor workflow.

## Required Folder Contract
- `modules/m01-<topic>/README.md`
- `modules/m02-<topic>/README.md`
- `labs/beginner/lab-01-<scenario>/README.md`
- `labs/intermediate/lab-01-<scenario>/README.md`
- `labs/advanced/lab-01-<scenario>/README.md`
- `labs/capstone/lab-01-<scenario>/README.md`
- `masterclass/<track>/README.md`
- `exams/practice-50q.md`
- `exams/answer-key.md`
- `validation/<path>-validate.ps1`

## Implementation Pattern
1. Build path-level README first.
2. Define two modules with explicit deliverables.
3. Implement beginner and intermediate labs as guided execution docs.
4. Implement advanced and capstone as release/hardening exercises.
5. Implement validation script with helper functions and pass/fail summary.
6. Fill 50-question exam and answer map.
7. Add a masterclass agenda using the same commands and checks.

## Validation Script Standards
- Required parameter checks.
- Azure context check (`az account show`).
- Resource existence checks.
- Runtime/config checks.
- Security checks (identity enabled, least-privilege role assignment where applicable).
- Human-readable summary with explicit pass/fail result.

## Assessment Standards
- 50 questions per path.
- Mix of conceptual, scenario, troubleshooting, and governance questions.
- Answer key with objective coverage map.
- Scoring guidance bands for remediation.

## Reuse from LP01
When upgrading LP02-LP05, copy structure and quality expectations from:
- `learning-paths/az204-lp01-develop-azure-compute-solutions/README.md`
- `learning-paths/az204-lp01-develop-azure-compute-solutions/validation/az204-lp01-validate.ps1`
- `learning-paths/az204-lp01-develop-azure-compute-solutions/labs/`
- `learning-paths/az204-lp01-develop-azure-compute-solutions/exams/`

## Quality Gate Checklist
- [ ] Every lab has tasks, verification, and cleanup.
- [ ] Every module has outcomes and deliverables.
- [ ] Validation script fails correctly for missing resources.
- [ ] Practice exam and answer key are aligned.
- [ ] Path README reflects final module/lab structure.
- [ ] Instructor can run end-to-end delivery without placeholder content.
