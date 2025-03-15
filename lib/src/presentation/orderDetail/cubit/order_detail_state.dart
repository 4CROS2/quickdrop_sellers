part of 'order_detail_cubit.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => <Object>[];
}

final class OrderDetailInitial extends OrderDetailState {}
