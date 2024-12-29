import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/products_repository.dart';

class NewProductUsecase {
  NewProductUsecase({
    required ProductRepository repository,
  }) : _repository = repository;
  final ProductRepository _repository;

  Future<NewProductStatus> saveNewProduct({
    required NewProductEntity product,
  }) =>
      _repository.saveNewProduct(
        product: product,
      );
}
