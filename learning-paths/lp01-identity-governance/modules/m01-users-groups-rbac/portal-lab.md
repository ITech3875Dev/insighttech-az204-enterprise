# Portal Lab — M01 Users, Groups, RBAC

## Task 1 — Create the resource group with required tags
1. Search: **Resource groups**
2. Click **Create**
3. Resource group name: `rg-az104-idgov-dev-eastus2-01`
4. Region: **East US 2**
5. Click **Next: Tags**
6. Add tags:
   - Owner = student01
   - CostCenter = training
   - Environment = dev
   - Workload = az104
   - DataClass = training
   - ExpirationDate = 2026-12-31
7. Click **Review + create** → **Create**

## Task 2 — Create Entra group (or record provided group Object ID)
1. Search: **Microsoft Entra ID**
2. Click **Groups** → **New group**
3. Group type: **Security**
4. Name: `az104-rbac-readers`
5. Create and copy the **Object ID**

## Task 3 — Assign Reader to the group at RG scope
1. Open the RG
2. Click **Access control (IAM)** → **Add role assignment**
3. Role: **Reader**
4. Select group: `az104-rbac-readers`
5. **Review + assign**
