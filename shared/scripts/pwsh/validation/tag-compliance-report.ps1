<#
Enterprise script: Tag Compliance Report (Resource Groups)
- Enumerates resource groups in a subscription and validates required tags.
- Outputs CSV and JSON for audit-friendly evidence.
- Requires: PowerShell Az module, authenticated context.
#>

param(
  [Parameter(Mandatory=$true)]
  [string]$SubscriptionId,

  [Parameter(Mandatory=$false)]
  [string[]]$RequiredTags = @("Owner","CostCenter","Environment","Workload","DataClass","ExpirationDate"),

  [Parameter(Mandatory=$false)]
  [string]$OutputFolder = "./out"
)

$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force -Path $OutputFolder | Out-Null

Select-AzSubscription -SubscriptionId $SubscriptionId | Out-Null

$rows = @()
$rgs = Get-AzResourceGroup

foreach ($rg in $rgs) {
  $missing = @()
  foreach ($t in $RequiredTags) {
    if (-not $rg.Tags.ContainsKey($t) -or [string]::IsNullOrWhiteSpace($rg.Tags[$t])) {
      $missing += $t
    }
  }

  $rows += [pscustomobject]@{
    ResourceGroup = $rg.ResourceGroupName
    Location      = $rg.Location
    MissingTags   = ($missing -join ",")
    IsCompliant   = ($missing.Count -eq 0)
  }
}

$timestamp = (Get-Date).ToString("yyyyMMdd-HHmmss")
$csvPath = Join-Path $OutputFolder "tag-compliance-rg-$SubscriptionId-$timestamp.csv"
$jsonPath = Join-Path $OutputFolder "tag-compliance-rg-$SubscriptionId-$timestamp.json"

$rows | Sort-Object IsCompliant, ResourceGroup | Export-Csv -NoTypeInformation -Path $csvPath
$rows | Sort-Object IsCompliant, ResourceGroup | ConvertTo-Json -Depth 4 | Out-File -Encoding utf8 $jsonPath

Write-Host "Report written:"
Write-Host "CSV:  $csvPath"
Write-Host "JSON: $jsonPath"

if ($rows | Where-Object { -not $_.IsCompliant }) {
  Write-Host "FAIL: Non-compliant resource groups detected."
  exit 1
}

Write-Host "PASS: All resource groups are tag compliant."
exit 0
