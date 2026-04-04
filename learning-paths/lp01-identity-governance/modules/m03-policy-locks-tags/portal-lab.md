# Portal Lab — M03 Policy, Locks, Tags (Beginner)

## Variables
- Subscription: your lab subscription
- Region allowed: East US 2
- Target RG: `rg-az104-idgov-dev-eastus2-01` (from M01)

---

## Task 1 — Assign “require tags” policy (Audit first)
1. Search **Policy**
2. Click **Assignments** → **Assign policy**
3. Scope: your subscription (or `mg-az104-workloads` if using MG)
4. Policy definition: search for **Require a tag on resources** (or resource groups)
5. Parameters:
   - Tag Name: `Environment`
6. Set **Effect** to **Audit** (if available) or use built-in behavior
7. **Review + create**

## Task 2 — Verify non-compliance (Audit)
1. Create a new RG without the `Environment` tag (test RG)
2. In Policy → Compliance, confirm it becomes non-compliant

## Task 3 — Enforce (Deny) in a controlled scope
1. Create a new policy assignment scoped to a **test RG** (not the whole subscription)  
2. Assign a “require tag” policy with **Deny** effect (if policy supports parameters)  
3. Attempt to create a resource without required tags → confirm denial  
4. Correct the tags → confirm successful creation

## Task 4 — Allowed locations policy
1. Assign **Allowed locations** policy to the subscription or MG
2. Set allowed locations to **East US 2**
3. Attempt to create a resource in another region → confirm denial

## Task 5 — Apply CanNotDelete lock to shared RG
1. Open RG `rg-az104-idgov-dev-eastus2-01`
2. **Locks** → **Add**
3. Name: `lock-rg-cannotdelete`
4. Type: **CanNotDelete**
5. Save

## Task 6 — Exemption workflow (concept)
1. Policy → **Exemptions**
2. Document when an exemption is appropriate (justification + expiration)

## Verify
- Policy assignments exist at expected scope(s)
- Lock prevents deletion attempts
