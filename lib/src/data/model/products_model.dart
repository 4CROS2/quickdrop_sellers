import 'package:quickdrop_sellers/src/domain/entity/products_entity.dart';

class ProductsModel extends ProductsEntity {
  ProductsModel({
    required super.productName,
    required super.price,
    required super.id,
    required super.image,
  });

  static ProductsModel fromJson({required Map<String, dynamic> json}) {
    final List<dynamic> jsonListImages = json['base_images'];
    return ProductsModel(
      productName: json['name'] ?? '',
      price: json['base_price'] ?? '',
      id: json['id'] ?? '',
      image: jsonListImages.first,
    );
  }
}
