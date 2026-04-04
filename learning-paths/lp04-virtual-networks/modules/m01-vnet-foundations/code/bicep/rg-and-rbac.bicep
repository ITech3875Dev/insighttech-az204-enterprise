targetScope = 'subscription'

param location string = 'eastus2'
param rgName string
param groupObjectId string

param tags object = {
  Owner: 'student01'
  CostCenter: 'training'
  Environment: 'dev'
  Workload: 'az104'
  DataClass: 'training'
  ExpirationDate: '2026-12-31'
}

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
  tags: tags
}

var readerRoleDefinitionId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')

resource rgReaderAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(rg.id, groupObjectId, 'Reader')
  scope: rg
  properties: {
    principalId: groupObjectId
    roleDefinitionId: readerRoleDefinitionId
    principalType: 'Group'
  }
}

output resourceGroupId string = rg.id
output roleAssignmentId string = rgReaderAssignment.id
