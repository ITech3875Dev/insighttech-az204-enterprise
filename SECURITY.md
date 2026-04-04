# Security Policy

## Reporting
Report security issues to the instructor team. Do not open public issues for security concerns.

## Secrets
- Do not commit secrets (keys, tokens, certificates, connection strings, credentials).
- Students must use interactive auth: `az login` / `Connect-AzAccount`.
- Instructor automation should use **GitHub OIDC** (preferred) or GitHub Secrets (instructor-only).

## Data handling
- Use **non-production** lab tenants/subscriptions only.
- Do not store customer data, PII, or regulated datasets in this repo.

## Supply chain hygiene
- CI includes secret scanning.
- PR review is required; shared components require lead/instructor review.
