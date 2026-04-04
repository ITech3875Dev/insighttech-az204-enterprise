# Advanced Lab: Cross-Tenant Governance & Guest Access

## Purpose
This advanced lab introduces **multi-tenant scenarios** and **guest user management** — patterns increasingly common in modern enterprises where organizations collaborate across tenant boundaries or manage external partners/consultants.

## Difficulty
- Advanced

## Time Estimate
- 2 to 3 hours

## Prerequisites
- M01, M02, M03 completion >=70%

## Scenario
MSP (Managed Service Provider) managing customer Azure resources across tenants.

---

## Business Context

**Scenario**: You work for "CloudBridge Solutions," an MSP that manages Azure resources for multiple customer tenants. Your responsibilities:

1. **Customer A** (Tenant A): Manufacturing company; you need read-only access to audit their resources
2. **Customer B** (Tenant B): Financial services firm; you need limited contributor access to specific resource groups
3. **Internal** (Your tenant): Maintain dashboards that aggregate data from both customer tenants

**Challenge**: Implement RBAC that grants appropriate access **without** creating accounts in customer tenants (use guest users).

---

## Learning Outcomes

You will:
- ✅ Create Microsoft Entra guest user invitations (cross-tenant)
- ✅ Assign RBAC roles to guest users (scope: remote tenant)
- ✅ Implement conditional access policies for guest access (if available)
- ✅ Delegate Azure AD admin tasks (PIM - if eligible)
- ✅ Troubleshoot cross-tenant RBAC issues
- ✅ Document security implications and best practices

---

## Lab Tasks

### Task 1: Invite Guest Users to Customer Tenant
**Goal**: Add your MSP account as a guest user to Customer A and B tenants

**Steps**:
1. **In Customer A tenant** (requires Owner or Tenant Administrator):
   - Navigate to Azure AD → Users → New guest user
   - Invite: `{your-msp-email}@{your-domain}.com`
   - Add message: "Granting read-only audit access to your Azure resources"
   - Send invitation
   - **Evidence**: Screenshot of guest creation confirmation

2. **Accept invitation from your MSP account**:
   - Check email for invitation link
   - Click "Accept invitation"
   - Verify you can now see Customer A's Entra directory
   - **Evidence**: Screenshot showing you are now a guest in Customer A

3. **Repeat for Customer B tenant** (Tenant B)
   - Invite to Tenant B
   - Accept invitation
   - Verify access

**Deliverables**:
- `task-01-guest-invitations.md`:
  - Screenshot: Guest user created in Customer A
  - Screenshot: Guest user listed in Azure AD (view from their admin account)
  - Screenshot: Acceptance confirmation
  - Commands used (if inviting via PowerShell/CLI)

---

### Task 2: Assign RBAC Roles to Guest Users
**Goal**: Grant appropriate roles to your guest account in customer tenants

**Scenario A: Customer A (Read-Only Audit Access)**
- Role: **Reader** on entire Subscription scope
- Scope: `/subscriptions/{customer-a-sub-id}`
- Rationale: Auditor can view all resources but not modify

**Scenario B: Customer B (Limited Contributor)**
- Role: **Contributor** on specific Resource Group only
- Scope: `/subscriptions/{customer-b-sub-id}/resourceGroups/{specific-rg}`
- Rationale: Managed services provider can manage resources in this specific RG only

**Steps** (perform as subscription/resource group owner):
1. **For Customer A**:
   ```powershell
   # Get guest user object ID
   $guestUser = Get-AzADUser -Mail "your-msp-email@{domain}.com"

   # Assign Reader role at subscription scope
   New-AzRoleAssignment `
       -ObjectId $guestUser.Id `
       -RoleDefinitionName "Reader" `
       -Scope "/subscriptions/{customer-a-sub-id}"
   ```

2. **For Customer B**:
   ```powershell
   # Assign Contributor at resource group scope
   New-AzRoleAssignment `
       -ObjectId $guestUser.Id `
       -RoleDefinitionName "Contributor" `
       -Scope "/subscriptions/{customer-b-sub-id}/resourceGroups/{specific-rg}"
   ```

**Deliverables**:
- `task-02-rbac-assignments.md`:
  - Role assignment commands (PowerShell or CLI)
  - Output: `az role assignment list` showing guest user assignments
  - Screenshot: Azure portal verification (Access Control → Role Assignments)

---

### Task 3: Verify Cross-Tenant Access
**Goal**: Confirm guest access works as intended (and respects scope)

**Tests**:
1. **Positive test**: Guest user logs into Azure portal with Customer A tenant
   - Can view resources in Customer A subscription ✅
   - Cannot modify resources (no Contributor/Owner) ✅

2. **Positive test**: Guest logs into Customer B tenant
   - Can view AND modify resources in the specific RG (Contributor role) ✅
   - Cannot modify resources outside the scoped RG ❌

3. **Negative test**: Guest attempts unauthorized action
   - Try to delete a resource in unscoped RG → 403 Forbidden ✅
   - Try to modify network security groups outside allowed RG → Denied ✅

**Deliverables**:
- `task-03-access-verification.txt`:
  - List commands run (e.g., `Get-AzResource`, `Get-AzRoleAssignment`)
  - Success outputs showing correct permissions
  - Failed attempt outputs (showing denial, not errors)

---

### Task 4: Multi-Tenant Dashboard (Aggregation Pattern)
**Goal**: Create a unified view of resources across multiple customer tenants

**Scenario**: Your MSP Dashboard (in your own Tenant C) aggregates cost and resource data from Customers A & B.

**Implementation** (High-level; actual dashboards vary):
1. **Create a Managed Identity** in Tenant C
2. **Grant cross-tenant RBAC** to this MI:
   - Tenant A: Reader on subscription
   - Tenant B: Reader on subscription
3. **Azure Lighthouse or Service Principal Delegation** (if supported):
   - Register Customer A + B subscriptions in your tenant's delegated resource management
   - Query resources via API/PowerShell across tenants

**Approach for lab** (simplified):
- Use `Get-AzSubscription` from each tenant (while authenticated as guest)
- Run `Get-AzResource` and `Get-AzResourceGroup` to enumerate resources across tenants
- Compile results into a summary CSV (simulating dashboard data)

**Deliverables**:
- `task-04-multi-tenant-aggregation.md`:
  - Diagram: MSP tenant (Tenant C) connecting to Customer A & B
  - PowerShell script or CLI commands showing cross-tenant queries
  - Sample CSV output: Resources from both customers aggregated
  - Security consideration: How would you secure this query automation?

---

### Task 5: Break-Glass & Emergency Access (Cross-Tenant)
**Goal**: Implement break-glass access procedure for emergency support scenarios

**Scenario**: Customer A experiences critical outage; you need temporary elevated access to troubleshoot.

**Procedure**:
1. **Request**: Customer A admin is contacted (out-of-band: phone/email)
2. **Grant**: Customer A admin temporarily elevates guest user to Owner role (1 hour)
3. **Usage**: Guest troubleshoots and fixes the issue
4. **Revoke**: After 1 hour or manual revocation, Owner role is removed
5. **Audit**: Activity log shows all actions taken during break-glass period

**Steps**:
```powershell
# Customer A admin: Grant temporary Owner role
$guestUser = Get-AzADUser -Mail "your-msp-email@{domain}.com"
$roleAssignment = New-AzRoleAssignment `
    -ObjectId $guestUser.Id `
    -RoleDefinitionName "Owner" `
    -Scope "/subscriptions/{customer-a-sub-id}"

# Capture the assignment object ID for later revocation
$roleAssignmentId = $roleAssignment.RoleAssignmentId

# After troubleshooting (note time):
Remove-AzRoleAssignment -RoleAssignmentId $roleAssignmentId

# Verify removal:
Get-AzRoleAssignment -ObjectId $guestUser.Id -Scope "/subscriptions/{customer-a-sub-id}"
```

**Deliverables**:
- `task-05-break-glass-cross-tenant.md`:
  - Break-glass request/approval process documented
  - PowerShell commands showing elevation + revocation
  - Activity log export showing:
    - Owner assignment timestamp
    - Resource modifications by guest user during break-glass period
    - Owner revocation timestamp
  - Audit trail interpretation (explain what each log entry shows)

---

### Task 6: Conditional Access & Security Policies
**Goal**: Implement conditional access controls for guest users (if Entra ID P1+ available)

**Challenges** (MSP security concerns):
- Guest user could be compromised; limit sign-in risk
- Require MFA for guest access to sensitive resources
- Block access from unusual locations

**Implementation** (if Entra ID premium available):
1. **Conditional Access Policy**:
   - **Target**: Guest users (filter)
   - **Condition**: Sign-in risk = High
   - **Action**: Block OR Require MFA
   - **Scope**: All cloud apps OR specific app registrations

2. **Named Locations** (optional):
   - Define "known MSP office" IP ranges
   - Block access from unknown locations for guest users

**Deliverables** (or SKIP if Entra ID P1+ not available):
- `task-06-conditional-access.md`:
  - Screenshot: Conditional Access policy creation
  - Policy summary (conditions, controls, exclusions)
  - Test results: Guest access blocked/allowed based on risk profile

---

### Task 7: Documentation & Lessons Learned
**Goal**: Summarize best practices for cross-tenant governance

**Deliverables**:
- `task-07-lessons-learned.md` (1—2 pages):
  - **Security implications**: What risks exist with guest user access?
  - **Best practices**:
    - Minimal scope principle (why we used Resource Group scope for Customer B)
    - Time-limited access (break-glass pattern)
    - Monitoring & audit trails
    - MFA requirements for guest accounts
  - **Troubleshooting common issues**:
    - Guest user can't see Customer tenant in Azure portal → (Solution: switch directory)
    - RBAC assignment fails for guest user → (Solution: Verify guest account exists in target tenant)
    - Break-glass access lingered too long → (Solution: Use PIM - Privileged Identity Management, set time-bound elevation)
  - **When to use cross-tenant RBAC** vs. alternative patterns (Azure Lighthouse, service principal delegation)

---

## Grading Rubric (100 points)

| Task | Points | Criteria |
|------|--------|----------|
| **Task 1: Guest Invitations** | 10 | Guests created in both tenants + invitation accepted + evidence provided |
| **Task 2: RBAC Assignments** | 15 | Reader role on Tenant A + Contributor on scoped RG in Tenant B + correct scope |
| **Task 3: Access Verification** | 15 | Positive & negative tests run; output shows correct permissions + denials |
| **Task 4: Multi-Tenant Dashboard** | 20 | Aggregation logic documented + cross-tenant data retrieval script + sample output |
| **Task 5: Break-Glass Access** | 20 | Procedure documented + temporary elevation + revocation + audit log analyzed |
| **Task 6: Conditional Access** | 10 | Conditional Access policy configured (or justified SKIP) |
| **Task 7: Documentation** | 10 | Lessons learned document comprehensive + best practices articulated |

**Passing**: ≥70 points

---

## Common Issues & Troubleshooting

| Issue | Diagnosis | Solution |
|-------|-----------|----------|
| Guest user can't see Customer A tenant | Guest hasn't switched directory in portal | Use "Switch directory" button (top-right); select Customer A tenant |
| Role assignment fails: "Principal not found" | Guest user principal ID is incorrect or from wrong tenant | Use `Get-AzADUser` to find correct object ID in customer's Entra |
| Guest sees resources they shouldn't | RBAC scope was too broad | Use `Get-AzRoleAssignment` to verify; re-assign to narrower scope |
| Break-glass access didn't revoke automatically | Manual removal forgotten or PIM not enabled | Check `Get-AzRoleAssignment`; manually `Remove-AzRoleAssignment` if needed |

---

## Advanced Extensions (If Time Permits)

1. **Azure Lighthouse Delegation**:
   - Register customers' subscriptions for delegated resource management
   - Query resources via your tenant's context (more streamlined than switching tenants)

2. **PIM (Privileged Identity Management)**:
   - Set customer's Owner role as `eligible` (not active)
   - Guest user requests JIT elevation (just-in-time)
   - Auto-expire after 2 hours with approval

3. **Service Principal with Federated Credentials**:
   - Alternative to guest user: Create service principal in each customer tenant
   - Issue workload identity token to your MSP's CI/CD pipeline
   - Deploy resources without human guest accounts

---

## Support & References

- **Cross-Tenant RBAC Docs**: https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin
- **Guest User Management**: https://learn.microsoft.com/en-us/azure/active-directory/external-identities/
- **Azure Lighthouse**: https://learn.microsoft.com/en-us/azure/lighthouse/
- **Troubleshooting**: See [playbooks/rbac-scope-troubleshooting.md](../../../docs/program/playbooks/rbac-scope-troubleshooting.md)

---

## Next Steps

After completing this lab, you:
- ✅ Understand cross-tenant identity patterns
- ✅ Can implement guest user access with RBAC
- ✅ Know how to implement break-glass emergency procedures
- ✅ Are ready for MSP/managed services roles
- ✅ Can tackle advanced AZ-104 identity scenarios

---

**Submission**: Push all task files to Git branch `lp02-advanced-storage-{yourname}`, open PR for instructor review.
