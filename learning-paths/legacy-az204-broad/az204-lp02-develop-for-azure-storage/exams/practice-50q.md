# AZ-204 LP02 Practice Questions (50)

## Instructions
- Select one best answer (A, B, C, or D) for each question.
- Target time: 60 minutes.
- Focus areas: Blob Storage, Cosmos DB, storage SDK usage, lifecycle controls, partitioning, and secure access.

1. Which Azure service is best suited for storing unstructured objects such as images and logs?
A. Azure Files
B. Blob Storage
C. Cosmos DB
D. Azure SQL Database

2. Which Blob Storage access level allows full anonymous public read access to blobs and container metadata?
A. Private
B. Blob
C. Container
D. Archive

3. What is the recommended minimum TLS setting for a production Azure Storage account?
A. TLS1_0
B. TLS1_1
C. TLS1_2
D. SSL3

4. Which Python package is used in LP02 for Blob SDK workflows?
A. azure-cosmos
B. azure-storage-blob
C. boto3
D. requests-azure

5. Which storage account setting should generally be disabled for production application storage?
A. Secure transfer required
B. Blob public access
C. TLS 1.2
D. StorageV2 kind

6. What is the best reason to use a container to organize blobs?
A. To define VM scale sets
B. To group and control access to related objects
C. To change subscription boundaries
D. To configure Cosmos partitioning

7. Which command creates a Blob container?
A. az storage blob create
B. az storage container create
C. az storage account container add
D. az blob container new

8. Which LP02 validation check confirms secure Blob access posture?
A. Storage account exists
B. Public blob access is disabled
C. Container has three blobs
D. Account is Premium

9. What does overwrite=True do in Blob upload logic?
A. Prevents retries
B. Replaces an existing blob with the same name
C. Enables soft delete
D. Switches container tier

10. Which operation is best for verifying Blob content integrity in a beginner lab?
A. Delete blob immediately
B. Download and compare content with source
C. Change subscription
D. Disable TLS

11. Which Azure database is designed for globally distributed, low-latency NoSQL workloads?
A. Azure Database for MySQL
B. Azure SQL Database
C. Azure Cosmos DB
D. Azure Cache for Redis

12. In Cosmos DB, what is the primary purpose of a partition key?
A. Define RBAC scope
B. Distribute data and route operations efficiently
C. Encrypt container contents
D. Set TLS version

13. Which partition key path is used in the LP02 intermediate lab?
A. /status
B. /id
C. /customerId
D. /region

14. Why are point reads preferred when possible in Cosmos DB?
A. They always use cross-partition queries
B. They are typically more efficient and predictable than queries
C. They require no partition key
D. They disable RU consumption

15. Which consistency level is configured in LP02 validation for Cosmos DB?
A. Strong
B. Eventual
C. Session
D. BoundedStaleness

16. Which Azure CLI command creates a Cosmos SQL container?
A. az cosmosdb sql container create
B. az cosmosdb container add
C. az cosmosdb nosql create-container
D. az sql cosmos create

17. What is the main risk of choosing a poor partition key?
A. Reduced blob durability
B. Hot partitions and inefficient scaling
C. Loss of TLS enforcement
D. Invalid storage account names

18. What is the default throughput baseline used in the LP02 intermediate Cosmos lab?
A. 100 RU/s
B. 400 RU/s
C. 1000 RU/s
D. Autoscale only

19. Why should lifecycle rules be part of a production-ready storage path?
A. They increase SQL indexing speed
B. They automate cost and retention controls
C. They replace RBAC
D. They create containers automatically

20. Which command applies a lifecycle management policy to a storage account?
A. az storage account policy apply
B. az storage blob lifecycle set
C. az storage account management-policy create
D. az storage lifecycle create

21. Which storage design choice best supports application retrieval by customer in Cosmos DB?
A. Partition by random GUID only
B. Partition by customer identifier when access is customer-centric
C. Partition by file extension
D. Avoid partitioning entirely

22. Which operation confirms a Blob container exists in validation?
A. az storage container show
B. az storage blob check
C. az storage account show
D. az storage filesystem list

23. Which item is most appropriate to store in Cosmos DB instead of Blob Storage?
A. Large video archive
B. Structured JSON order records for query operations
C. Static image backups
D. VM boot diagnostics files

24. Why capture both blob and Cosmos evidence in the capstone?
A. To duplicate work unnecessarily
B. To prove integrated storage behavior across services
C. To avoid cleanup
D. To remove need for validation scripts

25. Which action best reduces accidental data exposure in Blob Storage?
A. Enable public blob access
B. Disable public blob access and use least privilege access paths
C. Store account key in README
D. Use anonymous SAS by default

26. Which SDK operation supports listing available blobs in a container?
A. list_blobs()
B. get_partitions()
C. enumerate_filesystems()
D. show_documents()

27. What should be recorded as evidence after a successful Blob SDK run?
A. Only the subscription name
B. Upload, list, and download output
C. Only browser history
D. Only the local file name

28. Which Cosmos DB read pattern is most efficient when id and partition key are known?
A. Cross-partition query
B. Point read
C. Full container scan
D. Change feed iterator only

29. Which command retrieves the Cosmos DB document endpoint?
A. az cosmosdb show --query documentEndpoint
B. az cosmosdb endpoint get
C. az cosmos query endpoint
D. az sql server show endpoint

30. Which LP02 validation check verifies Cosmos container structure?
A. Region is East US only
B. Partition key path is /customerId
C. Container contains 100 items
D. Container is public

31. What is the best reason to keep Blob Storage and Cosmos DB in the same path?
A. They are identical services
B. Many application designs use object storage plus queryable metadata together
C. Cosmos DB requires Blob Storage for writes
D. Blob Storage requires partition keys

32. Which artifact best supports storage troubleshooting after lab completion?
A. Timestamped script output and validation results
B. Empty markdown headings
C. Browser favorites
D. VM screenshots only

33. Which setting helps prevent insecure transport to Azure Storage?
A. allowBlobPublicAccess=true
B. minimumTlsVersion=TLS1_2
C. crossTenantReplication=true
D. localUserEnabled=true

34. Which step belongs before deleting lab resources?
A. Remove all output evidence
B. Archive validation and workflow outputs
C. Disable logging permanently
D. Rename the resource group

35. Which statement about Blob Storage containers is correct?
A. A storage account can only have one container
B. Containers help segment data inside a storage account
C. Containers replace storage accounts
D. Containers are only for static websites

36. Which query style is preferable when the workload can avoid cross-partition scans?
A. Query without filters
B. Query with known partition key filters
C. Delete and recreate container
D. Use anonymous reads

37. Why include secure storage defaults in beginner labs?
A. To delay learning outcomes
B. To establish good production habits from the start
C. To avoid using SDKs
D. To eliminate need for validation

38. Which command returns storage account connection information for SDK usage?
A. az storage blob keys list
B. az storage account show-connection-string
C. az storage sdk config show
D. az keyvault secret get

39. Which operational concern is addressed by lifecycle policies?
A. Partition key hot spotting
B. Retention and tier transition over time
C. Container query syntax
D. Web app slot swaps

40. Which LP02 artifact should define pass/fail criteria for the full path?
A. README overview only
B. Validation script
C. Billing report
D. Issue template

41. What is the best use of Cosmos DB for LP02 scenarios?
A. Hosting static site images
B. Modeling queryable application records with partition-aware access
C. Replacing all blob storage workloads
D. Running VM backups

42. Which check most directly validates that a Blob upload succeeded?
A. Storage account exists
B. Blob appears in container listing
C. Cosmos DB account exists
D. App Service plan exists

43. Which design choice should a learner be able to defend at the end of LP02?
A. Why one browser was used over another
B. Why the selected partition key matches access patterns
C. Why no validation was needed
D. Why public access was enabled

44. Which operation best demonstrates integrated storage behavior in capstone?
A. Create resource group only
B. Upload a blob and store/query related metadata in Cosmos DB
C. Restart web app slots
D. Create a VM scale set

45. Which principle should guide storage role assignment?
A. Broadest access possible
B. Least privilege
C. Shared root keys in source code
D. Anonymous read first

46. What should happen if validation cannot find the Blob container?
A. Mark pass anyway
B. Return explicit failure
C. Delete storage account
D. Skip remaining checks automatically

47. Why include both conceptual and troubleshooting questions in LP02 assessment?
A. To inflate question count only
B. To measure understanding and operational readiness
C. To avoid storage service details
D. To remove the need for labs

48. Which item best standardizes quality between LP01 and LP02?
A. Identical service names
B. Shared production-ready path contract and validation style
C. Same exact commands in every lab
D. Removing advanced labs

49. Which command confirms a Cosmos SQL database exists?
A. az cosmosdb sql database show
B. az cosmosdb database verify
C. az cosmosdb show-database
D. az sql db cosmos show

50. What is the best final checkpoint before marking LP02 complete?
A. Delete resources immediately
B. Validate resources, review assessment results, and archive evidence
C. Rename containers only
D. Skip the capstone if beginner lab passed
