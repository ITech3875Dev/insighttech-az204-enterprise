# Playbook — Policy Compliance Troubleshooting

## Step 1 — Confirm the scope
- MG vs Subscription vs RG
- Ensure you are viewing compliance at the correct scope

## Step 2 — Confirm effect and parameters
- Effect: Audit / Deny / Modify / DeployIfNotExists / Append
- Parameters: allowed locations, required tags, etc.

## Step 3 — Evaluate/trigger testing
- Create a new resource to test Deny behavior
- Wait for compliance evaluation if needed

## Step 4 — Review compliance results
- Identify non-compliant resources
- Record the specific reason and policy definition used

## Step 5 — Remediation or exemption workflow
- Confirm remediation identity permissions (if used)
- Confirm scope alignment
- If exemption is used, document justification and expiration

## Evidence
- Assignment details + parameters
- Compliance results
- CLI/PowerShell output verifying assignment exists
