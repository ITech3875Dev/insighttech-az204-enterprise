#!/usr/bin/env bash
# Enterprise script: Tag Compliance Report (RG scope)
# Requires: Azure CLI authenticated (`az login`) and jq installed.

set -euo pipefail

SUBSCRIPTION_ID="${1:-}"
OUT_DIR="${2:-./out}"

if [[ -z "$SUBSCRIPTION_ID" ]]; then
  echo "Usage: $0 <subscriptionId> [outputFolder]"
  exit 2
fi

mkdir -p "$OUT_DIR"

az account set --subscription "$SUBSCRIPTION_ID" >/dev/null

required_tags=("Owner" "CostCenter" "Environment" "Workload" "DataClass" "ExpirationDate")

timestamp="$(date +%Y%m%d-%H%M%S)"
json_out="$OUT_DIR/tag-compliance-rg-${SUBSCRIPTION_ID}-${timestamp}.json"
csv_out="$OUT_DIR/tag-compliance-rg-${SUBSCRIPTION_ID}-${timestamp}.csv"

rgs_json="$(az group list --query "[].{name:name,location:location,tags:tags}" -o json)"

echo "ResourceGroup,Location,MissingTags,IsCompliant" > "$csv_out"
echo "[]" > "$json_out"

non_compliant=0

echo "$rgs_json" | jq -c '.[]' | while read -r rg; do
  name="$(echo "$rg" | jq -r '.name')"
  location="$(echo "$rg" | jq -r '.location')"
  tags="$(echo "$rg" | jq -c '.tags // {}')"

  missing=()
  for t in "${required_tags[@]}"; do
    val="$(echo "$tags" | jq -r --arg k "$t" '.[$k] // ""')"
    if [[ -z "$val" ]]; then
      missing+=("$t")
    fi
  done

  if [[ "${#missing[@]}" -gt 0 ]]; then
    is_compliant="false"
    non_compliant=1
  else
    is_compliant="true"
  fi

  missing_joined="$(IFS=";"; echo "${missing[*]}")"
  echo "${name},${location},"${missing_joined}",${is_compliant}" >> "$csv_out"

  tmp="$(mktemp)"
  jq --arg name "$name" --arg location "$location" --arg missing "$missing_joined" --argjson compliant $( [[ "$is_compliant" == "true" ]] && echo true || echo false )     '. + [{ResourceGroup:$name,Location:$location,MissingTags:$missing,IsCompliant:$compliant}]' "$json_out" > "$tmp"
  mv "$tmp" "$json_out"
done

echo "Report written:"
echo "CSV:  $csv_out"
echo "JSON: $json_out"

if [[ "$non_compliant" -eq 1 ]]; then
  echo "FAIL: Non-compliant resource groups detected."
  exit 1
fi

echo "PASS: All resource groups are tag compliant."
exit 0
