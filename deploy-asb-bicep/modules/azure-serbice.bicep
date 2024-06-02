import { serviceBusQueueType } from '../exports/exports.bicep'

@description('Name of the Service Bus namespace')
param serviceBusNamespaceName string

@description('Queues Configuration')
param serviceBusQueueConfigs serviceBusQueueType[]

@description('Location for all resources.')
param location string

@description('Sku Confgiguration for Service Bus')
param skuConfig skuConfiguration

type skuConfiguration = {
  name: serviceBusPlan
  capacity: int?
  tier: serviceBusPlan?
}

type serviceBusPlan = 'Basic' | 'Premium' | 'Standard'

resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: serviceBusNamespaceName
  location: location
  sku: {
    name: skuConfig.name
    capacity: skuConfig.capacity
    tier: skuConfig.tier
  }
}

resource serviceBusQueues 'Microsoft.ServiceBus/namespaces/queues@2022-10-01-preview' = [for serviceBusQueueConfig in serviceBusQueueConfigs: {
  name: serviceBusQueueConfig.queueName
  parent: serviceBusNamespace
  properties: {
    requiresDuplicateDetection: serviceBusQueueConfig.requiresDuplicateDetection
    requiresSession: serviceBusQueueConfig.requiresSession
    maxDeliveryCount: serviceBusQueueConfig.maxDeliveryCount
  }
}]
