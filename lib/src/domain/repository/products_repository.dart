import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/products_entity.dart';

abstract class ProductRepository {
  Future<List<ProductsEntity>> getProduts();
  Stream<String> saveNewProduct({
    required NewProductEntity product,
  });
  Future<bool> deleteProduct({required String productId});
}
