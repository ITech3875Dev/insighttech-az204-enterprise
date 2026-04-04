# Intermediate Lab 04 — Deny-by-Policy + Remediation/Exemption

## Time Estimate
- 75 to 105 minutes

## Prerequisites
- M03 completed
- Rights to assign policy at RG or subscription scope
- Non-production RG for safe failure testing

## Scenario
Enforce governance with Azure Policy:
- Require tags
- Restrict locations (e.g., East US 2 only)

## Objective
1. Assign policy that denies non-compliant deployments (or Audit if Deny is restricted)
2. Demonstrate:
   - A failed deployment due to policy
   - A corrected deployment that passes policy
3. Implement either:
   - Remediation (for Modify/DeployIfNotExists) OR
   - Exemption workflow (document justification and expiration)

## Variables

```bash
SUB_ID="<subscription-id>"
RG_NAME="rg-az104-policyrem-dev-eastus2-01"
LOCATION_ALLOWED="eastus2"
LOCATION_BLOCKED="westus"
```

## Step 1 - Prepare Test Scope

```bash
az account set --subscription "$SUB_ID"

az group create \
   --name "$RG_NAME" \
   --location "$LOCATION_ALLOWED" \
   --tags Owner="student" CostCenter="IT-104" Environment="dev" Workload="policy-remediation" DataClass="internal" ExpirationDate="2026-12-31"
```

## Step 2 - Assign Required-Tag and Allowed-Location Policies
Use either built-in policy definitions or your parameterized policy-as-code artifacts.

Examples with built-in policies:

```bash
RG_SCOPE=$(az group show --name "$RG_NAME" --query id -o tsv)

REQ_TAG_DEF_ID=$(az policy definition list --query "[?displayName=='Require a tag and its value on resources'].id | [0]" -o tsv)
ALLOWED_LOC_DEF_ID=$(az policy definition list --query "[?displayName=='Allowed locations'].id | [0]" -o tsv)

az policy assignment create \
   --name "pa-require-owner-tag" \
   --scope "$RG_SCOPE" \
   --policy "$REQ_TAG_DEF_ID" \
   --params '{"tagName":{"value":"Owner"}}'

az policy assignment create \
   --name "pa-allowed-location-eastus2" \
   --scope "$RG_SCOPE" \
   --policy "$ALLOWED_LOC_DEF_ID" \
   --params '{"listOfAllowedLocations":{"value":["eastus2"]}}'
```

## Step 3 - Demonstrate Failed Deployment
Attempt one non-compliant deployment:
- missing required tag, or
- blocked location

```bash
az storage account create \
   --name "st$RANDOM$RANDOM" \
   --resource-group "$RG_NAME" \
   --location "$LOCATION_BLOCKED" \
   --sku Standard_LRS \
   --kind StorageV2
```

Capture output in evidence-failed-deployment.txt.

## Step 4 - Demonstrate Corrected Deployment
Deploy compliant resource:

```bash
az storage account create \
   --name "st$RANDOM$RANDOM" \
   --resource-group "$RG_NAME" \
   --location "$LOCATION_ALLOWED" \
   --sku Standard_LRS \
   --kind StorageV2 \
   --tags Owner="student" CostCenter="IT-104" Environment="dev" Workload="policy-remediation"
```

Capture output in evidence-successful-deployment.txt.

## Step 5 - Execute Remediation or Exemption Path

### Path A - Remediation
If your policy supports remediation tasks, create and run remediation.

```bash
az policy remediation create \
   --name "remediate-missing-owner" \
   --policy-assignment "pa-require-owner-tag" \
   --scope "$RG_SCOPE"
```

### Path B - Exemption
Use time-bound exemption with business justification.

```bash
ASSIGNMENT_ID=$(az policy assignment show --name "pa-require-owner-tag" --scope "$RG_SCOPE" --query id -o tsv)

az policy exemption create \
   --name "ex-temp-owner-tag-waiver" \
   --scope "$RG_SCOPE" \
   --policy-assignment "$ASSIGNMENT_ID" \
   --exemption-category Waiver \
   --expires-on "2026-12-31T23:59:00Z" \
   --display-name "Temporary migration waiver"
```

## Step 6 - Gather Evidence and Explain Design
Collect:

```bash
az policy assignment list --scope "$RG_SCOPE" -o json > evidence-policy-assignments.json
az policy state summarize --resource-group "$RG_NAME" -o json > evidence-policy-state-summary.json
az policy exemption list --scope "$RG_SCOPE" -o json > evidence-policy-exemptions.json
```

Write explanation.md with:
1. Why Deny or why Audit
2. Why this scope was chosen
3. Blast radius analysis
4. Rollback commands

## Required Deliverables
- Policy definition/assignment evidence (Portal + CLI)
- Short explanation:
  - Why Deny (or why Audit)
  - Scope selection to control blast radius

## Acceptance Criteria
- Non-compliant deployment failed as expected
- Corrected deployment succeeded
- Remediation or exemption implemented and documented
- Policy evidence files are complete
- Blast radius and rollback are explicitly documented

## Troubleshooting
- Policy does not trigger: verify assignment scope and enforcement mode
- Deployment passes unexpectedly: confirm you tested blocked location or missing required tag
- Exemption create fails: verify policy assignment ID and scope are exact matches
