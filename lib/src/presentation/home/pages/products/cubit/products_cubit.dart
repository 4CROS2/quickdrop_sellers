import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/products_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/products_usecase.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({
    required ProductsUsecase usecase,
  })  : _usecase = usecase,
        super(Loading()) {
    getProducts();
  }
  final ProductsUsecase _usecase;

  Future<void> getProducts() async {
    emit(Loading());
    try {
      final List<ProductsEntity> response = await _usecase.getProduts();
      emit(Success(products: response));
    } catch (e) {
      emit(
        Error(
          message: e.toString(),
        ),
      );
    }
  }

  void hapticClickVibration() {
    HapticFeedback.selectionClick();
  }

  Future<void> deleteProduct({required String productId}) async {
    try {
      await _usecase.deleteProduct(productId: productId);
      await getProducts();
    } catch (e) {
      print(e);
    }
  }
}
