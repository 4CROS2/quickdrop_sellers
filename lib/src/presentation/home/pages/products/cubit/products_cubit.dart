import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(Loading()) {
    getProducts();
  }

  Future<void> getProducts() async {
    Future<void>.delayed(Constants.mainDuration * 10, () {
      emit(
        Success(
          products: <dynamic>['a', 'a'],
        ),
      );
    });
  }

  void hapticClickVibration() {
    HapticFeedback.selectionClick();
  }
}
