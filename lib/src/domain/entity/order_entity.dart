class OrderEntity {
  OrderEntity({
    required this.orderId,
    required this.image,
    required this.productName,
    required this.orderTime,
  });
  final String orderId;
  final String image;
  final String productName;
  final String orderTime;
}
