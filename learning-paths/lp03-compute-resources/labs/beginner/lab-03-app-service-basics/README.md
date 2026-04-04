# Beginner Lab 03 — Policy, Locks, and Tag Governance

## Goal
- Create tag and location governance with Azure Policy (Audit → Deny pattern)
- Apply a CanNotDelete lock
- Run tag compliance reports

## Use Module
- `modules/m03-policy-locks-tags/`

## Validation
Run:
```powershell
$SUBSCRIPTION_ID="<your-subscription-id>"
$RG_NAME="rg-az104-idgov-dev-eastus2-01"

pwsh -File learning-paths/lp03-compute-resources/modules/m03-policy-locks-tags/validation/validate.ps1 `
  -SubscriptionId $SUBSCRIPTION_ID `
  -ResourceGroupName $RG_NAME
```
