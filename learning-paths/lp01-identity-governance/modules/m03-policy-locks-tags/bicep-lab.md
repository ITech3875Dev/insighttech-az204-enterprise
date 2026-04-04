# Bicep Lab — M03 Policy Assignments (Advanced)

## Goal
Deploy policy assignments and a lock via Bicep/ARM-compatible resources.

> Note: Some governance resources are better managed via Policy-as-Code patterns; use this lab to practice subscription-scope deployment.

## Files
- `code/bicep/policy-and-locks.bicep`

## Deploy
```bash
az account set --subscription <subId>
az deployment sub create   --name "az104-policy-locks"   --location eastus2   --template-file learning-paths/lp01-identity-governance/modules/m03-policy-locks-tags/code/bicep/policy-and-locks.bicep   --parameters rgName="rg-az104-idgov-dev-eastus2-01"
```
