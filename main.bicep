param location string = resourceGroup().location

resource uma 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'uma-1'
  location: location
}
