# Beginner Lab 04 — Cost Management + Advisor

## Goal
- Create a monthly budget with alerts
- Use cost analysis filters (RG + tags)
- Review Azure Advisor

## Use Module
- `modules/m04-cost-advisor-governance/`

## Validation
```powershell
$SUBSCRIPTION_ID="<your-subscription-id>"
$BUDGET_NAME="az204-lab-budget"

pwsh -File learning-paths/az204-lp05-connect-consume-azure-services/modules/m04-cost-advisor-governance/validation/validate.ps1 `
  -SubscriptionId $SUBSCRIPTION_ID `
  -BudgetName $BUDGET_NAME
```


