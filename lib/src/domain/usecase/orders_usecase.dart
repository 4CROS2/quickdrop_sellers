import 'package:quickdrop_sellers/src/domain/entity/order_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/orders_respository.dart';

class OrdersUsecase {
  OrdersUsecase({
    required OrdersRespository repository,
  }) : _respository = repository;
  final OrdersRespository _respository;

  Stream<List<OrderEntity>> getOrders({
    required String sellerId,
  }) =>
      _respository.getOrders(
        sellerId: sellerId,
      );
}
