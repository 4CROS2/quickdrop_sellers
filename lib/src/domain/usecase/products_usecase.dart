import 'package:quickdrop_sellers/src/domain/entity/products_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/products_repository.dart';

class ProductsUsecase {
  ProductsUsecase({
    required ProductRepository reposity,
  }) : _repository = reposity;
  final ProductRepository _repository;

  Future<List<ProductsEntity>> getProduts() => _repository.getProduts();
  Future<bool> deleteProduct({
    required String productId,
  }) =>
      _repository.deleteProduct(
        productId: productId,
      );
}
