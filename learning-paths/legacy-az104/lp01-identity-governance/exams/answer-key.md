# LP01 Answer Key — 50 Questions (with explanations + official references)

> References are Microsoft Learn/Docs only.

## 1–10
1. **C** — Assign Reader at the **resource group** scope to minimize blast radius.  
   Ref: Azure RBAC scopes & role assignments (learn)  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/overview  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal

2. **A** — Contributor can manage resources but **can’t grant access** (role assignments).  
   Ref: Built-in roles  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles  

3. **B** — RBAC changes can take time to propagate.  
   Ref: RBAC overview  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/overview

4. **B** — User Access Administrator at **RG scope** manages access at that scope without granting broad resource rights.  
   Ref: Built-in roles  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles  

5. **A, B, C, D** — RBAC supports MG, subscription, RG, and resource scopes.  
   Ref: RBAC overview  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/overview

6. **C** — Contributor deploys resources but can’t assign roles.  
   Ref: Built-in roles  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles  

7. **B** — CanNotDelete lock prevents deletion regardless of RBAC.  
   Ref: Resource locks  
   - https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources

8. **B** — Role assignments at parent scopes inherit to child scopes.  
   Ref: RBAC overview  
   - https://learn.microsoft.com/en-us/azure/role-based-access-control/overview

9. **B** — `az role assignment list --scope ...`  
   Ref: Azure CLI RBAC  
   - https://learn.microsoft.com/en-us/cli/azure/role/assignment

10. **B** — Role definitions list built-in/custom roles and permissions.  
    Ref: Role definitions  
    - https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions-list  

## 11–20
11. **B** — MGs let you apply RBAC/policy across subscriptions.  
    Ref: MG overview  
    - https://learn.microsoft.com/en-us/azure/governance/management-groups/overview  

12. **B** — `az account management-group subscription add ...`  
    Ref: CLI mg subscription add  
    - https://learn.microsoft.com/en-us/cli/azure/account/management-group/subscription?view=azure-cli-latest  

13. **C** — Centralize at MG scope for scale.  
    Ref: MG overview  
    - https://learn.microsoft.com/en-us/azure/governance/management-groups/overview  

14. **C** — Inherits to all children under MG.  
    Ref: MG overview  
    - https://learn.microsoft.com/en-us/azure/governance/management-groups/overview  

15. **B** — MG creation requires appropriate permissions at tenant/MG scope.  
    Ref: Manage management groups  
    - https://learn.microsoft.com/en-us/azure/governance/management-groups/manage  

16. **B** — Deny blocks non-compliant deployments.  
    Ref: Policy effects  
    - https://learn.microsoft.com/en-us/azure/governance/policy/concepts/effect-basics  

17. **B** — Audit first to measure impact.  
    Ref: Policy overview  
    - https://learn.microsoft.com/en-us/azure/governance/policy/overview  

18. **B** — Exemptions can exclude a scope/resource.  
    Ref: Exemptions  
    - https://learn.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure  

19. **C** — Locks prevent deletion/changes (per lock type).  
    Ref: Resource locks  
    - https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/lock-resources

20. **C** — Allowed locations policy.  
    Ref: Policy overview + built-ins  
    - https://learn.microsoft.com/en-us/azure/governance/policy/overview  

## 21–30
21. **B** — Missing/blank values or wrong scope/parameters.  
    Ref: Policy assignment structure  
    - https://learn.microsoft.com/en-us/azure/governance/policy/concepts/assignment-structure  

22. **B** — Exemptions provide justified waivers (often time-bound).  
    Ref: Exemptions  
    - https://learn.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure  

23. **B** — Audit → measure → enforce.  
    Ref: Policy overview  
    - https://learn.microsoft.com/en-us/azure/governance/policy/overview  

24. **B** — Wait or test with new deployments; policy evaluation timing applies.  
    Ref: Policy overview  
    - https://learn.microsoft.com/en-us/azure/governance/policy/overview  

25. **A** — Policy rules/parameters are JSON structures.  
    Ref: Policy definition structure basics  
    - https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure

26. **B** — Budgets track and alert.  
    Ref: Budgets tutorial  
    - https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/tutorial-acm-create-budgets  

27. **A** — Advisor provides recommendations.  
    Ref: Azure Advisor  
    - https://learn.microsoft.com/en-us/azure/advisor/advisor-overview

28. **B** — Investigate cost drivers using cost analysis.  
    Ref: Cost analysis  
    - https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/cost-analysis

29. **A** — Tag-based reporting requires consistent tags.  
    Ref: Tag resources  
    - https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/tag-resources

30. **A** — Needs correct permissions; billing model can affect visibility.  
    Ref: Cost Management access  
    - https://learn.microsoft.com/en-us/azure/cost-management-billing/costs/assign-access-acm

## 31–40
31. **B** — Wrong subscription/context is the fastest root cause.  
32. **B** — Evaluation timing/propagation.  
33. **B** — Lock blocks deletes.  
34. **A** — Policy assignment list at subscription scope.  
    Ref: Policy CLI  
    - https://learn.microsoft.com/en-us/cli/azure/policy/assignment

35. **B** — Exemption with justification/expiration.  
    Ref: Exemptions  
    - https://learn.microsoft.com/en-us/azure/governance/policy/concepts/exemption-structure  

36. **A** — `az role assignment list --scope ...`  
37. **C** — RG creation is subscription-scope deployment in Bicep.  
38. **A** — `Get-AzPolicyAssignment`  
39. **B** — Deterministic naming/guardrails around idempotency.  
    Ref: Role assignments via templates  
    - https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-template  
40. **B** — Governance as code + CI.

## 41–50
41. **A, B, D**  
42. **A, C**  
43. **A, B, C**  
44. **B, C, D**  
45. **A, B, D**  
46. **B**  
47. **B**  
48. **B**  
49. **A**  
50. **A**
