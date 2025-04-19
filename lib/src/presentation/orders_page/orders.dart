import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:quickdrop_sellers/src/domain/usecase/orders_usecase.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/orders_page/cubit/orders_page_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/orders_page/widgets/order_tile.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/product_list_builder.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersCubit>(
      create: (BuildContext context) => OrdersCubit(
        usecase: sl<OrdersUsecase>(),
      )..getOrders(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (BuildContext context, OrdersState state) {
          return CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                leading: Icon(HugeIcons.strokeRoundedHome10),
                automaticallyImplyLeading: false,
                title: Text(
                  'Tus ordenes',
                ),
                pinned: true,
              ),
              if (state is Success)
                ProductListBuilder(
                  listEmptyMessage: 'no tienes ordenes pendientes',
                  itemCount: state.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderTile(
                      onTap: () => context.push(
                        '/order/${state.orders[index].orderId}',
                      ),
                      order: state.orders[index],
                    );
                  },
                )
            ],
          );
        },
      ),
    );
  }
}

/* 

   return AnimatedSwitcher(
            duration: Constants.mainDuration * 2,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: switch (state) {
              Error _ => Center(
                  child: Text(state.message),
                ),
              Success _ => ProductListBuilder(
            
                  listEmptyMessage: 'no tienes ordenes pendientes',
                  itemCount: state.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderTile(
                      onTap: () => context.push(
                        '/order/${state.orders[index].orderId}',
                      ),
                      order: state.orders[index],
                    );
                  },
                ),
              _ => Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
            },
          );

 */
