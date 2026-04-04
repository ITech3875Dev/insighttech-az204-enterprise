# LP01 Practice Exam — 50 Questions (Identity & Governance)

**Domain:** Manage Azure Identities & Governance (AZ-104)  
**Format:** Mixed (single-choice, multi-select, scenario/troubleshooting)  
**Rules:** Unless stated otherwise, assume **least privilege** and **enterprise guardrails** (naming/tags, scope discipline).

> Students: Answer in `exams/submissions/<yourname>-lp01.md` (create the folder if needed).  
> Instructors: Use `answer-key.md` and `instructor-notes.md`.

---

## Questions

### RBAC, Identity, and Access

1. You must give a group read-only access to **only** one resource group. What should you assign?
   - A. Reader at subscription scope
   - B. Reader at management group scope
   - C. Reader at resource group scope
   - D. Contributor at resource group scope

2. A user can create resources in a resource group but cannot assign role assignments. Which built-in role most likely explains this?
   - A. Contributor
   - B. Owner
   - C. User Access Administrator
   - D. Reader

3. You assigned a user the Reader role at subscription scope. They still cannot see a newly created resource group. What is the most likely cause?
   - A. Resource group has a delete lock
   - B. RBAC propagation delay
   - C. Policy denied the role assignment
   - D. The Reader role doesn’t include read permissions

4. You need to grant a service principal permission to manage role assignments within a single resource group (but not create resources). What is the best approach?
   - A. Contributor at subscription scope
   - B. User Access Administrator at resource group scope
   - C. Owner at resource group scope
   - D. Reader at resource group scope

5. Which scope supports role assignments in Azure RBAC? (Select all that apply)
   - A. Management group
   - B. Subscription
   - C. Resource group
   - D. Resource

6. Your team needs to deploy VMs, but must not be able to assign roles. Which role should you use?
   - A. Owner
   - B. User Access Administrator
   - C. Contributor
   - D. Reader

7. A group has Contributor at subscription scope, but you want to prevent them from deleting a specific resource group. What is the most appropriate control?
   - A. Assign Reader at RG scope
   - B. Apply a CanNotDelete lock to the RG
   - C. Add a deny policy to block deletes for that RG
   - D. Remove tags from the RG

8. Which statement about Azure RBAC inheritance is true?
   - A. Role assignments do not inherit to child scopes
   - B. A role assignment at a parent scope applies to child scopes
   - C. Role assignments only apply to resources, not RGs
   - D. Role assignments apply only to the subscription scope

9. You need to verify role assignments using Azure CLI for a specific scope. Which command is correct?
   - A. `az role definition show --scope <scope>`
   - B. `az role assignment list --scope <scope>`
   - C. `az ad group list --scope <scope>`
   - D. `az group list --scope <scope>`

10. You need a list of built-in roles and their permissions. Where should you look?
   - A. Azure Policy
   - B. Azure RBAC role definitions
   - C. Azure Advisor
   - D. Cost Management

### Management Groups & Subscription Organization

11. Why use management groups?
   - A. To create VNets across subscriptions
   - B. To apply RBAC and policy across multiple subscriptions
   - C. To deploy resources into multiple tenants
   - D. To store budgets centrally

12. Which command moves a subscription into a management group using Azure CLI?
   - A. `az account set --subscription <id>`
   - B. `az account management-group subscription add --name <mg> --subscription <id>`
   - C. `az management-group move --subscription <id>`
   - D. `az group move --subscription <id>`

13. You need to apply a policy across 20 subscriptions. What is the best approach?
   - A. Assign the policy to each resource group
   - B. Assign the policy to each subscription individually
   - C. Put subscriptions under a management group and assign policy to the management group
   - D. Use a lock on each subscription

14. A role assignment at a management group scope will apply to:
   - A. Only the management group
   - B. Only subscriptions directly under the management group
   - C. The management group and all subscriptions and resources beneath it
   - D. Only resources created after the assignment

15. You try to create a management group but receive an authorization error. What is the most likely issue?
   - A. You are not Owner on the subscription
   - B. You lack permissions at the tenant root / management group scope
   - C. You need a policy exemption
   - D. You must enable budgets first

### Azure Policy, Locks, and Tag Governance

16. Which Azure Policy effect will **block** a non-compliant deployment?
   - A. Audit
   - B. Deny
   - C. Append
   - D. Disabled

17. You want to require the tag `Environment` on all resource groups. What is the best first step?
   - A. Create a deny policy at subscription scope
   - B. Create an audit policy and validate compliance results
   - C. Use an RG delete lock
   - D. Use Azure Advisor

18. You assigned a policy at subscription scope, but it doesn’t apply to a specific resource group. What feature might explain this?
   - A. RBAC inheritance
   - B. Policy exemption
   - C. Resource lock
   - D. Budget alert

19. Which feature prevents accidental deletion of resources regardless of RBAC role?
   - A. Azure Policy (Audit)
   - B. Azure Policy (Deny)
   - C. Resource locks
   - D. Cost budgets

20. You need to prevent resource creation outside East US 2. What is the best control?
   - A. RBAC at RG scope
   - B. Resource locks
   - C. Azure Policy allowed locations assignment
   - D. Azure Advisor recommendation

21. A student reports: “Policy denied my deployment, but I added the tag.” What is a common reason?
   - A. Tags are case-insensitive; any tag works
   - B. The tag value is blank or whitespace
   - C. RBAC overrides policy
   - D. Locks override policy

22. When should you use a policy exemption?
   - A. To permanently ignore governance rules
   - B. To temporarily waive evaluation with justification and expiration
   - C. To override RBAC assignments
   - D. To bypass tenant-wide security settings

23. Which is the best practice order for governance rollout?
   - A. Deny everything first, then test
   - B. Audit → measure impact → Deny/Modify where appropriate
   - C. Locks first, then RBAC
   - D. Budgets first, then policy

24. A policy assignment exists, but compliance results are not yet visible. What should you do?
   - A. Delete the policy
   - B. Wait for evaluation cycle and/or test with a new resource creation
   - C. Remove locks
   - D. Change subscription

25. Which files are typically used to define a custom policy?
   - A. A policy rule JSON and parameter JSON
   - B. A CSV file
   - C. A PowerPoint file
   - D. A DNS zone file

### Cost Management, Budgets, and Advisor

26. What is the main purpose of an Azure budget?
   - A. Block all deployments above a threshold
   - B. Track and alert on spending thresholds
   - C. Replace tags
   - D. Assign RBAC

27. Which tool provides cost optimization recommendations?
   - A. Azure Advisor
   - B. Azure Policy
   - C. Azure Resource Locks
   - D. Management Groups

28. Your budget alert triggers at 80%. What should you do first?
   - A. Delete the subscription
   - B. Review cost analysis by resource group and tag
   - C. Add a delete lock to the subscription
   - D. Assign Reader to everyone

29. You want to see costs by `CostCenter` tag. What must be true?
   - A. The tag exists and is consistently applied to resources
   - B. The subscription is under a management group
   - C. Policy is disabled
   - D. Locks are removed

30. You create a budget but it doesn’t appear for a student. What’s likely missing?
   - A. The student needs Reader role at subscription scope (or billing permissions, depending on billing model)
   - B. The student needs Contributor at RG scope only
   - C. The student needs a policy exemption
   - D. The student needs a CanNotDelete lock

### Troubleshooting Scenarios

31. A group has Reader on RG A and Reader on RG B, but can only see RG A in Portal. What do you check first?
   - A. Tag values
   - B. Subscription context
   - C. Budget thresholds
   - D. VM size

32. After moving a subscription into a management group, a policy assigned at that MG doesn’t show compliance. What is most likely?
   - A. Policy only works at resource scope
   - B. Evaluation timing/propagation
   - C. Budget conflicts
   - D. Locks remove policy

33. A Contributor tries to delete an RG and is blocked. What explains this?
   - A. RBAC is broken
   - B. An RG lock exists
   - C. The Contributor role cannot delete RGs
   - D. Policy Audit blocks deletes

34. You need to confirm which policies are assigned to a subscription using Azure CLI. What is a valid approach?
   - A. `az policy assignment list --scope /subscriptions/<id>`
   - B. `az role assignment list --scope /subscriptions/<id>`
   - C. `az group show --name <rg>`
   - D. `az budget list --scope /subscriptions/<id>`

35. A policy denies deployments in an RG, but business requires an exception for 7 days. What should you do?
   - A. Remove the policy assignment
   - B. Create a policy exemption with justification and expiration
   - C. Give Owner to the app team
   - D. Apply a delete lock

### CLI / PowerShell / Bicep

36. Which Azure CLI command lists role assignments at an RG scope?
   - A. `az role assignment list --scope /subscriptions/<id>/resourceGroups/<rg>`
   - B. `az role definition list --scope /subscriptions/<id>/resourceGroups/<rg>`
   - C. `az account show --scope ...`
   - D. `az group list --scope ...`

37. In Bicep, which targetScope is used to create a resource group?
   - A. `tenant`
   - B. `managementGroup`
   - C. `subscription`
   - D. `resourceGroup`

38. Which PowerShell cmdlet lists policy assignments at a subscription scope? *(assume Az.Resources module)*
   - A. `Get-AzPolicyAssignment`
   - B. `Get-AzRoleAssignment`
   - C. `Get-AzConsumptionBudget`
   - D. `Get-AzAdvisorRecommendation`

39. A Bicep role assignment deployment fails with “roleAssignment already exists.” What is a good enterprise approach?
   - A. Delete all role assignments
   - B. Change the GUID deterministic name (guid()) design or pre-check before deployment
   - C. Stop using Bicep
   - D. Move the subscription

40. Which is the best way to enforce consistent governance at scale?
   - A. Manual portal clicks only
   - B. Policy-as-code + standards + CI validation
   - C. Rely on individual memory
   - D. Turn off policy

### Multi-select & Advanced Reasoning

41. Which actions help enforce least privilege? (Select all that apply)
   - A. Assign roles at lowest scope
   - B. Use built-in roles before custom
   - C. Prefer Owner for convenience
   - D. Regularly review role assignments

42. Which controls are primarily **preventive**? (Select all that apply)
   - A. Policy Deny
   - B. Policy Audit
   - C. Resource locks
   - D. Budgets

43. Which artifacts should be included in an enterprise change package for a policy rollout? (Select all that apply)
   - A. Impact analysis
   - B. Rollback plan
   - C. Validation evidence
   - D. Random blog references

44. In a break-glass model, which is recommended? (Select all that apply)
   - A. Permanent daily use of break-glass account
   - B. Strong monitoring and alerting
   - C. Documented approval workflow
   - D. Minimal number of break-glass accounts

45. Which items best demonstrate “governance maturity”? (Select all that apply)
   - A. Tag compliance reports
   - B. Policy exemptions with justification and expiration
   - C. Role assignments without documentation
   - D. Management group hierarchy aligned to org structure

### Case Study

46. You are asked to design management groups for: Platform, Workloads, Sandbox. Which design is best?
   - A. Put everything at root and assign policies individually
   - B. Create MGs and apply policy/RBAC at MG scope with inheritance
   - C. Use only resource groups
   - D. Use only budgets

47. A workload must deploy only in East US 2 and must always have required tags. Which solution is best?
   - A. Contributor role at subscription scope
   - B. Two policies: allowed locations + required tags (Audit first, then Deny)
   - C. A delete lock on the subscription
   - D. Azure Advisor alone

48. You need to produce an audit report of tag compliance for all RGs weekly. What is the best approach?
   - A. Manual portal checks
   - B. Automated script producing CSV/JSON outputs
   - C. Disable tags
   - D. Use a VM size recommendation

49. A student can’t see Cost Management in portal. Which is a likely explanation?
   - A. They don’t have correct RBAC/billing permissions for that view
   - B. Locks are enabled
   - C. Policy Audit is enabled
   - D. They used East US 2

50. You want to prevent deletion of the “shared services” RG, but still allow resource updates. Best control?
   - A. Delete lock on the RG (CanNotDelete)
   - B. Reader role on the RG
   - C. Budget at subscription scope
   - D. Policy Audit

