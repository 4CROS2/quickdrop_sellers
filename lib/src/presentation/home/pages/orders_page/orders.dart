import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/domain/entity/order_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/orders_usecase.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/cubit/orders_page_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/widgets/order_header.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/widgets/order_tile.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with AutomaticKeepAliveClientMixin {
  late final User _user;
  @override
  void initState() {
    super.initState();
    _user = (sl<AppCubit>().state as Authenticated).user;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<OrdersCubit>(
      create: (BuildContext context) => OrdersCubit(
        usecase: sl<OrdersUsecase>(),
      )..getOrders(sellerId: _user.uid),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (BuildContext context, OrdersState state) {
          return AnimatedSwitcher(
            duration: Constants.mainDuration * 2,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: switch (state) {
              Loading _ => Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              Error _ => Center(
                  child: Text(state.message),
                ),
              Success _ => _OrdersList(
                  orders: state.orders,
                ),
              _ => SizedBox.shrink()
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _OrdersList extends StatelessWidget {
  const _OrdersList({required List<OrderEntity> orders}) : _orders = orders;
  final List<OrderEntity> _orders;

  @override
  Widget build(BuildContext context) {
    if (_orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Constants.borderValue,
          children: <Widget>[
            Icon(
              Icons.inbox_rounded,
              size: 100,
            ),
            Text(
              'no tienes ordenes pendientes'.capitalize(),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: Constants.mainPadding,
        child: CustomScrollView(
          physics: Constants.mainPhysics,
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: OrdersHeader(
                label: 'tus pedidos',
              ),
            ),
            SliverList.builder(
              itemCount: _orders.length,
              itemBuilder: (BuildContext context, int index) {
                return OrderTile(
                  onTap: () {},
                  order: _orders[index],
                );
              },
            )
          ],
        ),
      );
    }
  }
}
