# Portal Lab - M04 Storage Security and Governance

## Variables
- Subscription: your lab subscription.
- Resource group: `rg-az104-storage-dev-eastus2-01`.
- Storage account: `<storage-account-name>`.

## Task 1 - Baseline secure transfer and protocol settings
1. Open the storage account.
2. Go to **Configuration**.
3. Set **Secure transfer required** to **Enabled**.
4. Set **Minimum TLS version** to **Version 1.2**.
5. Set **Allow Blob anonymous access** to **Disabled**.

## Task 2 - Network restrictions
1. Go to **Networking**.
2. Set **Public network access** to **Enabled from selected virtual networks and IP addresses**.
3. Add one allowed IP rule for your current public IP.
4. Save and verify access behavior.

## Task 3 - Encryption and key management review
1. Go to **Encryption**.
2. Confirm infrastructure encryption setting and key source.
3. Document whether Microsoft-managed keys or customer-managed keys are configured.

## Verify
- Configuration shows secure transfer and TLS 1.2 baseline.
- Anonymous access is disabled.
- Networking is restricted to selected networks/IP rules.
- Encryption settings match design intent.
