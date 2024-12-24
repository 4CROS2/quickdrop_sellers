import 'package:quickdrop_sellers/src/domain/entity/products_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/products_repository.dart';

class ProductsUsecase {
  ProductsUsecase({
    required ProductsRepository reposity,
  }) : _repository = reposity;
  final ProductsRepository _repository;

  Future<List<ProductsEntity>> getProduts() => _repository.getProduts();
}
