import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/order_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/orders_usecase.dart';

part 'orders_page_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required OrdersUsecase usecase,
  })  : _usecase = usecase,
        super(OrdersState());
  final OrdersUsecase _usecase;
  StreamSubscription<List<OrderEntity>>? _streamSubscription;

  void getOrders() {
    emit(Loading());
    _streamSubscription = _usecase.getOrders().listen(
          (List<OrderEntity> orders) => _setOrders(orders: orders),
          onError: _setError,
        );
  }

  void _setOrders({required List<OrderEntity> orders}) {
    emit(
      Success(
        orders: orders,
      ),
    );
  }

  void _setError(Object? message) {
    emit(
      Error(
        message: message.toString(),
      ),
    );
  }

  @override
  Future<void> close() {
    _streamSubscription!.cancel();
    return super.close();
  }
}
