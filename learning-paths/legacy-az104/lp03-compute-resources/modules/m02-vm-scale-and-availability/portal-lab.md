# Portal Lab - M02 Blob Services and Data Protection

## Goal
Configure blob storage for lifecycle, retention, and secure access.

## Task 1 - Create blob containers
1. Open your storage account.
2. Create containers `raw`, `curated`, and `archive`.
3. Set each container access level to Private.

## Task 2 - Enable blob data protection
1. Open Data protection for Blob service.
2. Enable Blob versioning.
3. Enable Blob soft delete.
4. Set retention period per class standard (for example, 14 days).

## Task 3 - Configure lifecycle management
1. Open Lifecycle management.
2. Create a rule to move blobs to cool tier after 30 days.
3. Add archive transition after 90 days.
4. Save and enable the rule.

## Task 4 - Validate secure access pattern
1. Generate a short-lived read-only SAS for one container.
2. Validate access with SAS URL.
3. Confirm no public container access is enabled.

## Verify
- Containers are private.
- Versioning and soft delete are enabled.
- Lifecycle policy is enabled.
- SAS access works within the expiry window.

## Troubleshooting
- Lifecycle rule unavailable: confirm account kind is StorageV2.
- Soft delete options missing: verify Blob service context.
- SAS access denied: verify permissions and expiry time.
