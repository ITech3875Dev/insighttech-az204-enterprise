# Az CLI Lab — M03 Policy, Locks, Tags (Beginner)

## Variables
```bash
export SUBSCRIPTION_ID="<your-subscription-id>"
export LOCATION="eastus2"
export RG="rg-az104-idgov-dev-eastus2-01"
export POLICY_NAME="require-env-tag-rg"
export ASSIGN_NAME="assign-require-env-tag-audit"
export EFFECT="Audit"   # change to Deny for enforcement test in a TEST scope
```

## 1) Create custom policy definition (require Environment tag on RGs)
```bash
az login
az account set --subscription "$SUBSCRIPTION_ID"

az policy definition create   --name "$POLICY_NAME"   --rules "learning-paths/lp01-identity-governance/modules/m03-policy-locks-tags/code/policy/require-environment-tag.json"   --mode All
```

## 2) Assign policy at subscription scope (Audit)
```bash
az policy assignment create   --name "$ASSIGN_NAME"   --policy "$POLICY_NAME"   --scope "/subscriptions/$SUBSCRIPTION_ID"   --params "{\"effect\":{\"value\":\"$EFFECT\"}}"
```

## 3) Assign allowed locations built-in policy
```bash
az policy assignment create   --name "assign-allowed-locations"   --policy "e56962a6-4747-49cd-b67b-bf8b01975c4c"   --scope "/subscriptions/$SUBSCRIPTION_ID"   --params @learning-paths/lp01-identity-governance/modules/m03-policy-locks-tags/code/policy/allowed-locations-parameters.json
```

## 4) Create CanNotDelete lock on RG
```bash
az lock create   --name "lock-rg-cannotdelete"   --lock-type CanNotDelete   --resource-group "$RG"   -o table
```

## Verify
```bash
az policy assignment list --scope "/subscriptions/$SUBSCRIPTION_ID" -o table
az lock list --resource-group "$RG" -o table
```

## Tag compliance report
```bash
chmod +x shared/scripts/cli/validation/tag-compliance-report.sh
shared/scripts/cli/validation/tag-compliance-report.sh "$SUBSCRIPTION_ID" "./out"
```
