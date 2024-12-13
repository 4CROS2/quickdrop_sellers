part of 'orders_page_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => <Object>[];
}

final class OrdersPageInitial extends OrdersState {}
