import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/cubit/orders_page_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/widgets/order_tile.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int item = 1000;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>(
      create: (BuildContext context) => sl<OrdersCubit>(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (BuildContext context, OrdersState state) {
          return Padding(
            padding: Constants.mainPadding,
            child: RefreshIndicator(
              onRefresh: () async {
                await Future<void>.delayed(
                  Durations.long1,
                  () {},
                );
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: _OrdersHeader(
                      label: 'tus pedidos',
                    ),
                  ),
                  SliverList.builder(
                    itemCount: 200,
                    itemBuilder: (BuildContext context, int index) {
                      return OrderTile(
                        onTap: () {},
                        label: 'pedido ${index + 1}',
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrdersHeader extends SliverPersistentHeaderDelegate {
  _OrdersHeader({
    String label = '',
  }) : _label = label;

  final String _label;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.transparent,
      child: Text(
        _label.capitalize(),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  final double maxExtent = 50.0;

  @override
  final double minExtent = 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
