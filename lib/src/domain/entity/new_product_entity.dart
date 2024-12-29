import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum NewProductStatus { initial, error, success, loading }

class NewProductEntity extends Equatable {
  const NewProductEntity({
    required this.name,
    required this.price,
    required this.description,
    required this.images,
    required this.tags,
  });

  final String name;
  final int price;
  final String description;
  final List<XFile> images;
  final List<String> tags;

  NewProductEntity copyWith({
    String? name,
    int? price,
    String? description,
    List<XFile>? images,
    List<String>? tags,
  }) {
    return NewProductEntity(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      images: images ?? this.images,
      tags: tags ?? this.tags,
    );
  }

  factory NewProductEntity.empty() => NewProductEntity(
        description: '',
        price: 0,
        name: '',
        images: <XFile>[],
        tags: <String>[],
      );

  @override
  List<Object?> get props => <Object?>[
        name,
        price,
        description,
        images,
        tags,
      ];

  @override
  bool? get stringify => true;
}
