param location string
param prefix string
param vNetName string

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-10-01' = {
  name: '${prefix}-la-workspace'
  location: location
  properties: {
    sku: {
       name: 'PerGB2018'
    }
  }
}

resource env 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: '${prefix}-container-env'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspace.properties.customerId
        sharedKey: logAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
    vnetConfiguration:{
      runtimeSubnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vNetName,'acaAppSubnet')
      infrastructureSubnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vNetName,'acaControlPlaneSubnet')
    }
  }
}
