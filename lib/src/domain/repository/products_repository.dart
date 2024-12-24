import 'package:quickdrop_sellers/src/domain/entity/products_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductsEntity>> getProduts();
}
