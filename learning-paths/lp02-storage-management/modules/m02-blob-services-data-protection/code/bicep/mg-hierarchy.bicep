targetScope = 'tenant'

@description('Root management group name.')
param rootMgName string = 'mg-az104-root'

@description('Child management groups.')
param childMgs array = [
  'mg-az104-platform'
  'mg-az104-workloads'
  'mg-az104-sandbox'
]

resource root 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: rootMgName
}

resource children 'Microsoft.Management/managementGroups@2021-04-01' = [for mg in childMgs: {
  name: mg
  properties: {
    details: {
      parent: {
        id: root.id
      }
    }
  }
}]
