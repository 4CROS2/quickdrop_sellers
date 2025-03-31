import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';

class NewProductModel extends NewProductEntity {
  const NewProductModel({
    required super.name,
    required super.price,
    required super.description,
    required super.images,
    required super.tags,
    required super.ngrams,
  });
  static NewProductModel fromEntity({required NewProductEntity entity}) {
    return NewProductModel(
        name: entity.name,
        price: entity.price,
        description: entity.description,
        images: entity.images,
        tags: entity.tags,
        ngrams: entity.ngrams,);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'base_price': price,
      'description': description,
      'tags': tags,
      'ngrams': ngrams,
    };
  }
}
