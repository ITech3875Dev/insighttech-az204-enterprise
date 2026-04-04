// Shared Bicep entry (scaffold)
// Purpose: prove compilation in CI and provide a place to aggregate shared modules.
targetScope = 'subscription'

@description('Deployment location for subscription-scoped resources (not all resources use this).')
param location string = 'eastus2'

// No resources deployed by default in scaffold.
output scaffold string = 'shared bicep scaffold ok'
