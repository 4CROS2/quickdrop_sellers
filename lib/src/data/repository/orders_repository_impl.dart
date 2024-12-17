import 'package:quickdrop_sellers/src/data/datasource/orders_datasource.dart';
import 'package:quickdrop_sellers/src/data/model/orders_model.dart';
import 'package:quickdrop_sellers/src/domain/repository/orders_respository.dart';

class IOrdersRepository extends OrdersRespository {
  IOrdersRepository({
    required OrdersDatasource datasource,
  }) : _datasource = datasource;
  final OrdersDatasource _datasource;

  @override
  Stream<List<OrdersModel>> getOrders() {
    final Stream<List<Map<String, dynamic>>> response = _datasource.getOrders();
    return response.map((List<Map<String, dynamic>> ordersList) {
      return ordersList.map((Map<String, dynamic> orderJson) {
        return OrdersModel.fromJson(json: orderJson);
      }).toList();
    });
  }
}
