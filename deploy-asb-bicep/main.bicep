param location string = resourceGroup().location

var prefix = 'ak'
var serviceBusNamespaceName = '${prefix}-service-bus-namespace'

var serviceBusQueueName = '${prefix}-report-generation'

module serviceBusModule 'modules/azure-serbice.bicep' = {
  name: serviceBusNamespaceName
  params:{
    location: location
    serviceBusNamespaceName: serviceBusNamespaceName
    serviceBusQueueConfigs: [
      {
        maxDeliveryCount: 4
        queueName: serviceBusQueueName
        requiresDuplicateDetection: true
        requiresSession: false
      }
    ]
    skuConfig: {
      name: 'Basic'
    }
  }
}
