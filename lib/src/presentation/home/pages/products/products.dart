import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/products/cubit/products_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/products/widgets/product_tile.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/loading_data_animation.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/product_list_builder.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products>
    with AutomaticKeepAliveClientMixin {
  Future<void> _refreshPage(BuildContext context) async {
    await context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HapticFeedback.selectionClick();
          context.push('/addnewproduct');
        },
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: BlocProvider<ProductsCubit>(
        create: (BuildContext context) => sl<ProductsCubit>(),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (BuildContext context, ProductsState state) {
            return AnimatedSwitcher(
              duration: Constants.mainDuration,
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
                Success _ => RefreshIndicator(
                    onRefresh: () => _refreshPage(context),
                    child: ProductListBuilder(
                      title: 'tus productos',
                      listEmptyMessage: 'no tiene productos registrados',
                      itemCount: state.products.length,
                      showRefreshButton: true,
                      refreshOnTap: () => _refreshPage(context),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductTile(
                          product: state.products[index],
                        );
                      },
                    ),
                  ),
                _ => LoadingDataAnimation(),
              },
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
