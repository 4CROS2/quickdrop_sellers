part of 'orders_page_cubit.dart';

class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => <Object>[];
}

class Loading extends OrdersState {}

class Error extends OrdersState {
  const Error({
    required this.message,
  });
  final String message;
}

class Success extends OrdersState {
  const Success({
    required this.orders,
  });
  final List<OrderEntity> orders;
  @override
  List<Object> get props => <Object>[orders];
}
