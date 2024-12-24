part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => <Object>[];
}

class Loading extends ProductsState {}

class Error extends ProductsState {
  const Error({
    required this.message,
  });
  final String message;
  @override
  List<Object> get props => <Object>[message];
}

class Success extends ProductsState {
  const Success({required this.products});

  final List<ProductsEntity> products;

  @override
  List<Object> get props => <Object>[products];
}
