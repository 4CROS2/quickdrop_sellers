import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickdrop_sellers/src/domain/entity/order_entity.dart';

class OrdersModel extends OrderEntity {
  OrdersModel({
    required super.orderId,
    required super.image,
    required super.productName,
    required super.orderTime,
  });

  static OrdersModel fromJson({required Map<String, dynamic> json}) {
    final DateTime time = (json['created_at'] as Timestamp).toDate();
    final int hour = time.hour;
    final int minutes = time.minute;
    return OrdersModel(
      orderId: json['order_id'],
      image: json['image'],
      productName: json['product_name'],
      orderTime: '$hour:$minutes',
    );
  }

  // Método privado para formatear el timestamp a "HH:mm"
}
