// Resource Group module (subscription scope)
targetScope = 'subscription'

@description('Resource group name.')
param name string

@description('Azure region for the RG.')
param location string

@description('Tags to apply.')
param tags object = {}

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: name
  location: location
  tags: tags
}

output id string = rg.id
output rgName string = rg.name
