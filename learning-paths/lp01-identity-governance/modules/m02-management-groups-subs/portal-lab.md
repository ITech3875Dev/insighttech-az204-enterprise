# Portal Lab — M02 Management Groups & Subscriptions (Beginner)

> If you cannot create management groups, perform the **verification steps** and use the instructor-provided structure.

## Task 1 — Create management group hierarchy
1. In the Azure Portal, search **Management groups**
2. If prompted, select your **tenant** and proceed
3. Create management groups:
   - `mg-az104-root`
   - `mg-az104-platform` (parent: mg-az104-root)
   - `mg-az104-workloads` (parent: mg-az104-root)
   - `mg-az104-sandbox` (parent: mg-az104-root)
4. Verify the tree view shows the correct parent/child relationships

## Task 2 — Move subscription into mg-az104-workloads
1. In **Management groups**, select `mg-az104-workloads`
2. Click **Add subscription**
3. Select your lab subscription → **Save**
4. Wait 1–3 minutes for propagation

## Task 3 — Assign RBAC at management group scope
Goal: Assign **Reader** to group `az104-rbac-readers` at `mg-az104-workloads` scope.

1. Select management group `mg-az104-workloads`
2. Click **Access control (IAM)**
3. **Add role assignment**
4. Role: **Reader**
5. Members: select `az104-rbac-readers`
6. **Review + assign**

## Verify
- Confirm subscription appears under `mg-az104-workloads`
- Confirm the role assignment exists at MG scope and is inherited to the subscription scope

## Troubleshoot
- Authorization errors: you likely lack tenant/MG permissions — use instructor-provided MGs
- Inheritance delays: wait 1–3 minutes and refresh
