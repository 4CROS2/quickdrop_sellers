import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum NewProductStatus { initial, error, success, loading }

class NewProductEntity extends Equatable {
  const NewProductEntity(
      {required this.name,
      required this.price,
      required this.description,
      required this.images,
      required this.tags,
      required this.ngrams});

  final String name;
  final int price;
  final String description;
  final List<XFile> images;
  final List<String> tags;
  final Set<String> ngrams;

  NewProductEntity copyWith({
    String? name,
    int? price,
    String? description,
    List<XFile>? images,
    List<String>? tags,
    Set<String>? ngrams,
  }) {
    return NewProductEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      ngrams: ngrams ?? this.ngrams,
    );
  }

  factory NewProductEntity.empty() => const NewProductEntity(
        description: '',
        price: 0,
        name: '',
        images: <XFile>[],
        tags: <String>[],
        ngrams: <String>{},
      );

  @override
  List<Object?> get props =>
      <Object?>[name, price, description, images, tags, ngrams];

  @override
  bool? get stringify => true;
}
