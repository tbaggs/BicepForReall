//To run: 
//az group deployment create --template-file .\resource-group\resource-group.bicep --parameters .\configurations\dev.json

targetScope = 'subscription'

param rgName string
param location string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}
