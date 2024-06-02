@export()
type serviceBusQueueType = {
  queueName: string
  requiresDuplicateDetection: bool
  requiresSession: bool
  maxDeliveryCount: int
}
