# PowerShell Lab — M04 Budgets + Advisor (Beginner/Intermediate)

> Budget cmdlets vary by Az module/version and billing model. If your environment lacks budget cmdlets, use Portal steps and focus PowerShell on evidence collection.

## Variables
```powershell
$SUBSCRIPTION_ID="<your-subscription-id>"
```

## Advisor evidence (works broadly)
```powershell
Connect-AzAccount
Set-AzContext -Subscription $SUBSCRIPTION_ID

# List recommendations (may be empty)
Get-AzAdvisorRecommendation | Select-Object Category, Impact, ShortDescription | Format-Table -AutoSize
```
