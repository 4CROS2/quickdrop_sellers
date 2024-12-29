part of 'newproduct_cubit.dart';

class NewProductState extends Equatable {
  const NewProductState._({
    required this.status,
    required this.newProduct,
    required this.message,
  });

  factory NewProductState({
    NewProductStatus? status,
    List<XFile>? images,
    NewProductEntity? newProduct,
    String? message,
  }) {
    return NewProductState._(
      status: status ?? NewProductStatus.initial,
      newProduct: newProduct ?? NewProductEntity.empty(),
      message: message ?? '',
    );
  }

  final NewProductStatus status;
  final NewProductEntity newProduct;
  final String message;

  NewProductState copyWith({
    NewProductStatus? status,
    NewProductEntity? newProduct,
    String? message,
  }) {
    return NewProductState._(
      status: status ?? this.status,
      newProduct: newProduct ?? this.newProduct,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => <Object>[
        status,
        message,
        newProduct,
      ];
}
