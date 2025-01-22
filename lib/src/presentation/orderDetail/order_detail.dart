import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/orderDetail/cubit/order_detail_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/custom_app_bar.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({required String orderId, super.key}) : _orderId = orderId;
  final String _orderId;
  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocProvider<OrderDetailCubit>(
        create: (BuildContext context) => sl<OrderDetailCubit>(),
        child: Center(
          child: Text(
            widget._orderId,
          ),
        ),
      ),
    );
  }
}
