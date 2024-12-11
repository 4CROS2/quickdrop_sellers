import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page.dart/cubit/orders_page_cubit.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>(
      create: (BuildContext context) => sl<OrdersCubit>(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (BuildContext context, OrdersState state) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile();
            },
          );
        },
      ),
    );
  }
}
