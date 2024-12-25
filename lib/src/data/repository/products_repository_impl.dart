import 'package:quickdrop_sellers/src/data/datasource/products_datasource.dart';
import 'package:quickdrop_sellers/src/data/model/products_model.dart';
import 'package:quickdrop_sellers/src/domain/repository/products_repository.dart';

class IProductsRepository implements ProductsRepository {
  IProductsRepository({required ProductsDatasource datasource})
      : _datasource = datasource;
  final ProductsDatasource _datasource;

  @override
  Future<List<ProductsModel>> getProduts() async {
    final Map<String, dynamic> data = await _datasource.getProducts();
    final List<ProductsModel> response = data.entries.map(
      (MapEntry<String, dynamic> product) {
        final Map<String, dynamic> productData = product.value;
        productData['id'] = product.key;
        return ProductsModel.fromJson(json: productData);
      },
    ).toList();
    return response;
  }
}
