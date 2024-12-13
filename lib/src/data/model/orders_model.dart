import 'package:quickdrop_sellers/src/domain/entity/order_entity.dart';

class OrdersModel extends OrderEntity {
  OrdersModel({
    required super.image,
    required super.productName,
    required super.orderTime,
  });

  static OrdersModel fromJson({required Map<String, dynamic> json}) {
    return OrdersModel(
      image: json['image'],
      productName: json['product_name'],
      orderTime: json['order_time'],
    );
  }
}
