# LP01 Capstone Lab: Enterprise Governance Architecture

## Overview
This capstone lab **synthesizes all four LP01 modules** (M01–M04) into one integrated enterprise governance scenario. You will design and implement complete Azure governance for a multi-team organization with competing requirements.

**Difficulty**: Advanced
**Duration**: 2–3 hours
**Prerequisite**: Successful completion of M01, M02, M03, M04 (≥70% on post-module checks) or instructor approval

---

## Business Scenario

**Organization**: InSight DataCorp (fictional enterprise)
- **Current state**: 5 Azure subscriptions, growing from 100 to 500 resources over next 6 months
- **Teams**:
  1. **Infrastructure (Infra)**: Deploys VMs, networks, storage; high cost variance
  2. **Application Development (AppDev)**: Deploys App Services, databases; needs cost visibility but cannot delete production resources
  3. **Finance & Compliance**: Must audit costs, enforce tagging, ensure no non-compliant resources exist
  4. **Security**: Reviews policies; ensures no public access to storage

**Governance goals**:
- ✅ Minimize privilege: Each team has access only to what they need
- ✅ Enforce compliance: All resources must be tagged with Owner, CostCenter, Environment, Workload
- ✅ Cost visibility: Finance can slice costs by team (tag: CostCenter) and track budgets
- ✅ Prevent data exposure: Azure Policy blocks unencrypted storage accounts and requires allowed locations
- ✅ Maintain auditability: All actions logged; break-glass access procedure in place

---

## Your Deliverables

### Part A: RBAC Architecture Design
**Objective**: Design an RBAC hierarchy (management groups, subscriptions, scope assignments) to meet team needs with least privilege.

**Requirements**:
- 3 subscriptions (Infra, AppDev, Shared)
- 1 Management Group for governance policies
- Role assignments for each team:
  - **Infra**: Contributor on Infra sub (deploy/manage resources)
  - **AppDev**: Contributor on AppDev sub + Reader on Shared (consume shared resources, cannot deploy to shared)
  - **Infra leads**: Owner on Infra sub (troubleshoot, reassign roles)
  - **Finance**: Reader on all 3 subs (cost analysis), User Access Administrator on MG (audit role assignments)
  - **Security**: Reader on all 3 subs, Policy Insights Reader (audit policies)

**Deliverables**:
1. Architecture diagram (PowerPoint, Visio, or ASCII art) showing:
   - MG hierarchy
   - Subscriptions placement
   - RBAC assignments with scope
   - **Diagram placement**: `capstone/diagrams/rbac-architecture.md` (embed PNG or ASCII-art)

2. Implementation evidence:
   - `capstone/evidence/rbac-assignments.json` — Output from `az role assignment list --scope /subscriptions/{sub-id}` for each subscription
   - `capstone/evidence/rbac-validation.txt` — Output from validation script confirming all role assignments exist
   - **Rationale document**: `capstone/rationale/rbac-design-rationale.md` (why each role assignment meets the requirement)

---

### Part B: Policy & Compliance Design
**Objective**: Design an Azure Policy framework (Assignment, Audit/Deny). Demonstrate compliance and remediation.

**Requirements**:
- **Tag Policies**:
  - Audit: Missing Owner, CostCenter, Environment tags
  - Deny: New resources without all 4 required tags (Owner, CostCenter, Environment, Workload)
  - **Exemptions**: Allow Managed Identity service principal to avoid tags (common exception)

- **Location Policy**:
  - Deny: Resources outside East US 2 (centralize for compliance)
  - **Exemptions**: Shared subscription can deploy to West US 2 (for DR purposes)

- **Storage Policy** (Advanced):
  - Audit: Unencrypted storage accounts
  - Deny: Creation of storage without HTTPS-only enforcement

**Deliverables**:
1. Policy definitions & assignments:
   - `capstone/policies/tag-policy-definitions.json` — Azure Policy JSON (parameterized)
   - `capstone/policies/location-policy.json` — Location deny policy
   - `capstone/policies/storage-policy.json` — Storage security policy
   - Deployment evidence: `capstone/evidence/policy-assignments.txt` — Output from `az policy assignment list`

2. Compliance report:
   - `capstone/evidence/compliance-report.json` — Non-compliant resources before remediation (from `az policy state summarize`)
   - `capstone/evidence/compliance-remediation-log.txt` — Actions taken to fix non-compliance (re-tagging, exemptions, or deprovisioning)
   - `capstone/rationale/policy-exemption-justification.md` — Document explaining each policy exemption

3. Remediation workflow:
   - Demonstrate one complete remediation: Create a non-compliant resource → Fail policy check → Apply exemption OR fix tags → Pass policy check
   - Screenshot/CLI output sequence: `capstone/evidence/remediation-workflow.txt`

---

### Part C: Cost Management & Budget Design
**Objective**: Design cost allocation, budgets, and monitoring for Finance team (M04 integration).

**Requirements**:
- Budget #1: **Infra team monthly budget** = $500/month (Alert at 80%, 100%)
- Budget #2: **AppDev team monthly budget** = $300/month (Alert at 80%, 100%)
- **Visibility**: Finance must be able to slice costs by CostCenter tag (should see Infra, AppDev, Overhead)
- **Advisor**: Document 3 Azure Advisor recommendations and recommended actions

**Deliverables**:
1. Budget evidence:
   - `capstone/evidence/budgets-created.txt` — Output from `az costmanagement budget list`
   - `capstone/evidence/budget-alerts-configured.txt` — Confirmation alerts are set

2. Cost analysis exports:
   - `capstone/evidence/cost-analysis-by-costcenter-tag.csv` — Exported from Cost Management UI (or CLI JSON) showing costs grouped by CostCenter tag
   - `capstone/evidence/cost-forecast.txt` — CLI output from cost forecasting (if available in your subscription)

3. Advisor recommendations:
   - `capstone/rationale/advisor-recommendations.md` — Document 3 recommendations, categorize by impact (High/Medium/Low) and cost savings estimate
   - Decision: For each recommendation, state: **Accepted** (implement now), **Deferred** (plan to implement Q2), or **Rejected** (reason why)

---

### Part D: Break-Glass Access & Incident Response
**Objective**: Design and test an emergency-access procedure (M02 advanced pattern).

**Requirements**:
- Document: Who can request break-glass access? (e.g., VP of Engineering)
- Procedure: What happens when granted? (e.g., temporary Owner assignment for 2 hours, logged, auto-revoked)
- Testing: Simulate an emergency (e.g., AppDev lead needs to delete a stuck deployment) and walk through the break-glass process

**Deliverables**:
1. Break-glass runbook:
   - `capstone/runbooks/break-glass-access-procedure.md` — Step-by-step runbook
   - **Format**: Goal → Prerequisites → Request flow → Approval → Grant → Usage → Auto-revoke → Audit

2. Audit evidence:
   - `capstone/evidence/break-glass-activity-log.txt` — Activity Log entries showing:
     - Temporary role assignment creation
     - Actions taken during access (e.g., resource deletion)
     - Auto-revoke or manual removal via PowerShell/CLI

---

### Part E: End-to-End Validation & Self-Assessment
**Objective**: Validate all components work together; document learnings.

**Deliverables**:
1. Validation script:
   - `capstone/validation/validate-capstone.ps1` — PowerShell script that runs all checks and reports PASS/FAIL
   - **Checks**:
     - All RBAC assignments exist and have correct roles/scopes
     - All policies are assigned and not disabled
     - Budgets exist and have alerts
     - Non-compliant resources have exemptions or fixes
     - At least one break-glass event is audit-logged

2. Capstone checksheet:
   - `capstone/evidence/capstone-completion-checklist.md` — Self-assessment checklist
     - [ ] RBAC architecture verified (all 6 role assignments present)
     - [ ] Policies assigned (tag audit + deny, location deny, storage policy)
     - [ ] Compliance report generated and remediated
     - [ ] Budgets created and alerts configured
     - [ ] Cost analysis by CostCenter available
     - [ ] Break-glass procedure documented and tested (with audit log)
     - [ ] Validation script passes with all checks GREEN

3. Capstone reflection:
   - `capstone/reflection/learnings.md` — 300—500 words
     - What was the most complex design decision and why?
     - Which module (M01/M02/M03/M04) was hardest to integrate and why?
     - What would you do differently in a real enterprise?
     - How would this architecture scale to 100+ subscriptions?

---

## Grading Rubric (100 points)

| Component | Points | Criteria |
|-----------|--------|----------|
| **RBAC Architecture** | 20 | Clear diagram + all role assignments correct + rationale explains least-privilege principle |
| **Policy Design** | 20 | All 3 policies assigned + exemptions justified + remediation workflow evidenced |
| **Cost Management** | 15 | Budgets created + cost slice by CostCenter + 3 Advisor recommendations categorized |
| **Break-Glass Procedure** | 15 | Runbook clear + audit logged + demonstrates emergency access pattern |
| **Validation & Automation** | 15 | Script runs and reports PASS/FAIL + meaningful assertions |
| **Documentation Quality** | 10 | Diagrams clear, rationales well-reasoned, reflection thoughtful, no secrets in files |
| **Completion & Checksheet** | 5 | All deliverables present + checksheet fully marked |

**Passing Score**: ≥70 points (need at least 3 of 5 main components complete and correct)

---

## Time Estimates by Experience Level

| Level | Duration |
|-------|----------|
| **First attempt** (following checklist closely) | 3 hours |
| **Experienced** (M01-M04 > 85% scores) | 2 hours |
| **Expert** (prior enterprise Azure experience) | 1.5 hours |

---

## Tips for Success

1. **Start with the diagram**: Sketch your RBAC and policy hierarchy on paper before implementing
2. **Pair with a classmate**: Capstone involves trade-off decisions; discussion helps
3. **Use validation script early**: Run it frequently to catch missing assignments
4. **Document as you go**: Easier than backtilling explanations at the end
5. **Test remediation end-to-end**: Create resources → trigger policy → fix → validate
6. **Leverage shared scripts**: Use tag-compliance-report.ps1 and other shared tools to speed up reporting

---

## Submission & Review

- **Submission format**: Push capstone folder to Git branch: `lp01-capstone-{firstname}`, open PR
- **PR checklist**: All deliverable files present, validation script passes, no hardcoded secrets
- **Instructor review**: 3-5 business days; feedback on rationales and architectural choices
- **Revisions**: If <70%, instructor will note gaps; resubmit revised components

---

## Next Steps After Capstone

After completing LP01 capstone, you are eligible to:
- ✅ Attempt **AZ-104 practice exam** (50 questions)
- ✅ Begin **LP02** (Networking) if available
- ✅ Present governance architecture to your team (great resume addendum!)

---

## Support & Resources

- **Playbooks**: [rbac-scope-troubleshooting.md](../../../docs/program/playbooks/rbac-scope-troubleshooting.md), [policy-compliance-troubleshooting.md](../../../docs/program/playbooks/policy-compliance-troubleshooting.md)
- **Shared scripts**: [tag-compliance-report.ps1](../../../shared/scripts/pwsh/validation/tag-compliance-report.ps1), [tag-compliance-report.sh](../../../shared/scripts/cli/validation/tag-compliance-report.sh)
- **Bicep modules**: [shared/bicep/modules/](../../../shared/bicep/modules/)
- **Office hours**: Schedule 1:1 with instructor if stuck on Part D (break-glass) or Part C (cost data visibility)
