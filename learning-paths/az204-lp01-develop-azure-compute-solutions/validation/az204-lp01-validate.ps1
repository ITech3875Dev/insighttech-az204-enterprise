param(
    [string]$ResourceGroupName,
    [string]$FunctionAppName,
    [string]$WebAppName
)

$errors = @()

if (-not $ResourceGroupName) {
    $errors += "ResourceGroupName is required."
}

if (-not $FunctionAppName) {
    $errors += "FunctionAppName is required."
}

if (-not $WebAppName) {
    $errors += "WebAppName is required."
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Host "[ERROR] $_" -ForegroundColor Red }
    exit 1
}

Write-Host "[INFO] AZ-204 LP01 validation started." -ForegroundColor Cyan
Write-Host "[INFO] Resource Group: $ResourceGroupName"
Write-Host "[INFO] Function App: $FunctionAppName"
Write-Host "[INFO] Web App: $WebAppName"

# Placeholder checks to be replaced with az/ARM queries as labs are finalized.
Write-Host "[WARN] Validation checks are scaffolding placeholders and must be implemented." -ForegroundColor Yellow
Write-Host "[PASS] Validation script executed." -ForegroundColor Green
