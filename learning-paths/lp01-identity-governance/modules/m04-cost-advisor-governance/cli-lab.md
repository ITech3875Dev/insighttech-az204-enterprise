# Az CLI Lab — M04 Budgets (Beginner)

## Variables
```bash
export SUBSCRIPTION_ID="<your-subscription-id>"
export BUDGET_NAME="az104-lab-budget"
export AMOUNT="100"
export START_DATE="2026-01-01"
export END_DATE="2026-12-31"
export EMAIL="<your-email-or-instructor-email>"
```

## Create budget
```bash
az login
az account set --subscription "$SUBSCRIPTION_ID"

az consumption budget create   --budget-name "$BUDGET_NAME"   --category cost   --amount "$AMOUNT"   --time-grain monthly   --time-period start-date="$START_DATE" end-date="$END_DATE"   --notifications enabled=true operator=GreaterThan threshold=50 contactEmails="$EMAIL"
```

## Verify
```bash
az consumption budget show --budget-name "$BUDGET_NAME" -o jsonc
```

## Notes
- Availability depends on billing model and CLI extension maturity; if this fails, use Portal lab and record the error.
