# Masterclass (CLI): Compute Delivery Workflow

## Focus
Advanced CLI-driven workflow for repeatable compute deployments and operational checks.

## Topics
- Resource provisioning and naming conventions.
- Deployment automation patterns.
- Slot-based release workflow.
- Validation and rollback checks.

## Duration
120 minutes

## Session Outcomes
By the end of this masterclass, participants can:
- Deploy Function App and App Service resources from CLI only.
- Automate staging deployment and slot swaps.
- Implement and validate rollback checkpoints.
- Produce evidence suitable for instructor or release gate review.

## Suggested Agenda
1. Baseline environment provisioning (20 min)
2. Function and web app deployment pipeline (25 min)
3. Staging, smoke tests, and slot swap (25 min)
4. Rollback simulation and failure handling (20 min)
5. Validation script walk-through and evidence packaging (30 min)

## Core Commands Reference

```bash
az functionapp create
az functionapp identity assign
az webapp create
az webapp deployment slot create
az webapp deploy
az webapp deployment slot swap
az webapp config appsettings list
```

## Workshop Deliverables
- CLI command transcript or script file.
- Swap and rollback proof output.
- Final LP01 validation output with passing checks.
