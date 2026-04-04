# Bicep Lab — M02 (Management Groups) — Instructor-led / Advanced

> Management group deployments often require tenant-level permissions. Use this lab when those permissions are available.

## Goal
Deploy a management group hierarchy as code.

## Files
- `code/bicep/mg-hierarchy.bicep`

## Steps
```bash
az deployment tenant create   --name "az104-mg-hierarchy"   --location eastus2   --template-file learning-paths/lp01-identity-governance/modules/m02-management-groups-subs/code/bicep/mg-hierarchy.bicep
```

## Evidence
- Deployment success output
- Portal screenshot of MG hierarchy (Beginner only)
