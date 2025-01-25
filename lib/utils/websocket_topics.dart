enum WebSocketTopics {
  TOPIC_ORDERS_PAYED('/topic/orders-payed/'),
  TOPIC_ORDERS_PREPARING('/topic/orders-preparing/'),
  TOPIC_ORDERS_COMPLETED('/topic/orders-completed/');

  final String name;

  const WebSocketTopics(this.name);
}
