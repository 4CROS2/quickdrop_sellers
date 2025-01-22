part of 'order_detail_cubit.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

final class OrderDetailInitial extends OrderDetailState {}
