import 'package:quickdrop_sellers/src/data/datasource/products_datasource.dart';
import 'package:quickdrop_sellers/src/data/model/new_product_model.dart';
import 'package:quickdrop_sellers/src/data/model/products_model.dart';
import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/products_repository.dart';

class IProductsRepository implements ProductRepository {
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

  @override
  Future<NewProductStatus> saveNewProduct({
    required NewProductEntity product,
  }) async {
    final NewProductModel data = NewProductModel.fromEntity(
      entity: product,
    );
    final NewProductStatus response = await _datasource.saveNewProduct(
      product: data,
    );
    return response;
  }
}
