import 'package:quickdrop_sellers/src/domain/entity/order_entity.dart';

abstract class OrdersRespository {
  Stream<List<OrderEntity>> getOrders();
}
