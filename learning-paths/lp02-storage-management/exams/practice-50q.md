# LP02 Practice Exam — 50 Questions (Implement and manage storage in Azure)

**Domain:** Implement and manage storage in Azure (AZ-104)
**Format:** Mixed (single-choice, multi-select, scenario/troubleshooting)
**Rules:** Unless stated otherwise, assume least privilege and enterprise naming/tagging guardrails.

> Students: Answer in `exams/submissions/<yourname>-lp02.md`.
> Instructors: Use `answer-key.md` and `instructor-notes.md`.

---

## Questions

### Storage Accounts and Core Configuration

1. You need a storage account that supports blob and Azure Files in East US 2. Which account type is recommended?
   - A. Premium BlockBlobStorage
   - B. Premium FileStorage
   - C. StorageV2 (general purpose v2)
   - D. Classic Storage

2. Which setting enforces encrypted transport to Azure Storage endpoints?
   - A. Minimum TLS version
   - B. Secure transfer required
   - C. Infrastructure encryption
   - D. Blob soft delete

3. You must block clients using TLS 1.0 and TLS 1.1. What should you configure?
   - A. Require secure transfer only
   - B. Minimum TLS version = TLS1_2
   - C. Enable versioning
   - D. Disable public network access

4. Which replication option keeps three copies in one Azure region?
   - A. LRS
   - B. GRS
   - C. RA-GRS
   - D. GZRS

5. You need read access to data in the paired region after a regional outage. Which replication option supports this?
   - A. LRS
   - B. ZRS
   - C. RA-GRS
   - D. Premium_LRS

6. What is the primary purpose of storage account tags in enterprise environments?
   - A. Improve latency
   - B. Enable cost/governance filtering and ownership metadata
   - C. Increase throughput
   - D. Replace RBAC

7. A workload requires immutable object storage for legal hold scenarios. Which feature family should you use?
   - A. Blob lifecycle rules
   - B. Blob index tags
   - C. Immutable storage policies (WORM)
   - D. Access tiers

8. Which endpoint suffix is used for Azure Blob Storage in public Azure?
   - A. `.database.windows.net`
   - B. `.blob.core.windows.net`
   - C. `.vault.azure.net`
   - D. `.servicebus.windows.net`

9. Which scope is best for granting a team access to only one storage account?
   - A. Management group
   - B. Subscription
   - C. Resource group
   - D. Storage account resource

10. A deployment fails because the storage account name is unavailable. What is the most likely cause?
   - A. Name already exists globally
   - B. Name includes uppercase letters
   - C. Name is too long
   - D. Any of the above

### Blob Services and Data Protection

11. Which feature creates a new copy of a blob when it is modified?
   - A. Snapshots
   - B. Versioning
   - C. Soft delete
   - D. Change feed

12. Blob soft delete primarily protects against:
   - A. Region-wide outages
   - B. Accidental deletion and overwrite operations
   - C. Unauthorized network access
   - D. Slow uploads

13. You need to automatically move blobs to Cool after 30 days and Archive after 180 days. What should you configure?
   - A. Lifecycle management policy
   - B. SAS token
   - C. Immutability policy
   - D. File share quota

14. Which SAS type is signed with Microsoft Entra credentials instead of an account key?
   - A. Account SAS
   - B. Service SAS
   - C. User delegation SAS
   - D. Stored access policy SAS

15. What is the best practice for SAS token lifetime?
   - A. No expiration
   - B. Short expiry, least privilege permissions
   - C. Full permissions always
   - D. Reuse one token for all workloads

16. You enable blob versioning. Which statement is true?
   - A. It disables soft delete
   - B. It is available only for premium accounts
   - C. It helps recover previous blob states
   - D. It replaces backups

17. Which operation helps validate lifecycle policy execution?
   - A. `az storage account show`
   - B. `az storage account blob-service-properties show`
   - C. `az monitor metrics list`
   - D. `az vm list`

18. Container public access should be disabled in most enterprise scenarios because:
   - A. It increases storage cost
   - B. It can expose data anonymously
   - C. It reduces throughput
   - D. It blocks lifecycle policies

19. You need temporary read-only download access for a partner. Best option:
   - A. Storage account key
   - B. Contributor role assignment
   - C. Read-only SAS with short expiration
   - D. Public container access

20. Which two settings together provide stronger delete protection for blobs?
   - A. Versioning and soft delete
   - B. ZRS and lifecycle policy
   - C. NFS and SMB
   - D. LRS and tags

### Azure Files, Sync, and Data Movement

21. Which protocol is supported by Azure Files for standard Windows file access?
   - A. FTP
   - B. SMB
   - C. NTP
   - D. IMAP

22. Azure File Sync is used to:
   - A. Replicate blobs across tenants
   - B. Sync Azure file shares with Windows Servers
   - C. Replace Key Vault
   - D. Encrypt storage accounts

23. In Azure File Sync, which component defines the relationship between cloud and server endpoints?
   - A. Sync group
   - B. Lifecycle policy
   - C. Management group
   - D. Snapshot policy

24. What is cloud tiering in Azure File Sync?
   - A. Moving blobs to archive automatically
   - B. Keeping frequently used files on-prem and tiering cold files to Azure
   - C. Converting HDD to SSD
   - D. Compressing files in Azure Files

25. Which tool is optimized for high-performance data transfer to and from Azure Storage?
   - A. AzCopy
   - B. Notepad
   - C. Azure Advisor
   - D. Resource Graph

26. A team needs to migrate large file datasets with resume capability. Preferred approach:
   - A. Manual portal uploads
   - B. AzCopy jobs
   - C. Azure Policy
   - D. ARM tags

27. Which command lists files in an Azure file share using CLI?
   - A. `az storage blob list`
   - B. `az storage file list`
   - C. `az storage account list`
   - D. `az storage queue list`

28. You need separate quotas per team share. Where do you configure this?
   - A. At subscription scope
   - B. On each file share
   - C. In Azure Policy only
   - D. In Key Vault

29. A copied folder is missing files in the destination share. First troubleshooting step:
   - A. Delete the source data
   - B. Review transfer logs and rerun with recursive flag
   - C. Disable secure transfer
   - D. Change replication type

30. Which statement about Azure Files identity-based access is true?
   - A. It is unrelated to RBAC and ACLs
   - B. It can integrate with AD DS/Azure AD DS scenarios for SMB auth
   - C. It requires public access enabled
   - D. It works only with NFS

### Storage Security and Governance

31. Which configuration reduces exposure to anonymous blob reads?
   - A. Enable blob public access
   - B. Disable blob public access at account level
   - C. Use LRS
   - D. Increase quota

32. You want only selected networks to access the storage account. What should be set as default action?
   - A. Allow
   - B. Deny
   - C. Audit
   - D. Disabled

33. Private endpoints for storage primarily provide:
   - A. Public internet acceleration
   - B. Private IP connectivity from a VNet
   - C. Automatic SAS rotation
   - D. Built-in lifecycle policies

34. Customer-managed keys (CMK) for storage encryption are stored in:
   - A. Azure Policy
   - B. Azure Key Vault or Managed HSM
   - C. Azure Monitor
   - D. Recovery Services vault

35. Which action is part of defense in depth for storage security?
   - A. Use account keys everywhere
   - B. Disable logging
   - C. Restrict network access and use least-privilege identities
   - D. Enable anonymous read

36. Which command helps verify secure transfer and TLS settings via CLI?
   - A. `az storage account show --query "{httpsOnly:httpsTrafficOnly,minTls:minTlsVersion}"`
   - B. `az role assignment list`
   - C. `az vm show`
   - D. `az monitor action-group list`

37. If public network access is disabled, what must clients use?
   - A. Any internet path
   - B. Private endpoint or trusted private path
   - C. SAS token only
   - D. Storage Explorer only

38. Why should shared key access be limited when possible?
   - A. It is slower than RBAC
   - B. It grants broad data-plane authority and is harder to govern
   - C. It prevents lifecycle policies
   - D. It disables encryption

39. Which storage governance control best validates baseline posture continuously?
   - A. One-time portal screenshot
   - B. Scripted validation checks in pipeline or scheduled jobs
   - C. Manual memory checks
   - D. Random sampling once a year

40. A storage account allows TLS1_0. What is the immediate remediation?
   - A. Enable versioning
   - B. Set minimum TLS to TLS1_2
   - C. Increase quota
   - D. Switch to LRS

### Multi-select and Scenario Reasoning

41. Which practices improve storage data protection? (Select all that apply)
   - A. Enable blob versioning
   - B. Enable blob soft delete
   - C. Keep unlimited long-lived SAS tokens
   - D. Apply lifecycle policies

42. Which controls are primarily network-security focused? (Select all that apply)
   - A. Firewall IP rules
   - B. Private endpoints
   - C. Blob versioning
   - D. Public network access restrictions

43. Which evidence artifacts are appropriate for LP02 lab validation? (Select all that apply)
   - A. CLI/PowerShell command output showing configured settings
   - B. List of created containers/shares
   - C. Transfer summary/logs from data movement tool
   - D. Unrelated VM sizing notes

44. Which statements about SAS are correct? (Select all that apply)
   - A. Permissions should be minimal
   - B. Expiration should be short
   - C. SAS should be shared in plain chat without controls
   - D. User delegation SAS can be preferable to key-signed SAS

45. Which actions support secure operations for Azure Storage? (Select all that apply)
   - A. Enforce HTTPS only
   - B. Set minimum TLS 1.2
   - C. Enable anonymous public blob access globally
   - D. Restrict network access

### Case Studies

46. A media app needs cheap long-term retention for old files but fast access for new content. Best design?
   - A. Store everything in Hot tier forever
   - B. Use lifecycle policy to transition old blobs to Cool/Archive
   - C. Disable versioning and soft delete
   - D. Use public containers for faster reads

47. A partner needs 24-hour upload access to one container path. Best solution?
   - A. Share storage account key
   - B. Assign Owner at subscription
   - C. Issue path-scoped SAS with write permissions and expiry
   - D. Enable anonymous blob upload

48. Your security team requires private connectivity from app subnet to storage. What should you deploy?
   - A. Public endpoint with Allow all networks
   - B. Private endpoint and DNS integration
   - C. Only lifecycle rules
   - D. Only additional tags

49. A File Sync deployment shows stale files on a branch server. Most likely next action:
   - A. Ignore because eventual consistency is unlimited
   - B. Check sync health, endpoint status, and server agent connectivity
   - C. Disable the sync group
   - D. Delete cloud endpoint immediately

50. You must prove LP02 baseline compliance weekly across environments. Best enterprise approach?
   - A. Manual portal checks by interns
   - B. Scheduled validation scripts + artifact retention + exception workflow
   - C. Disable security controls to reduce false positives
   - D. Review only after incidents

