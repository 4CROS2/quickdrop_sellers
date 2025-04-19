import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/products/presentation/cubit/products_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/products/presentation/widgets/product_tile.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/loading_data_animation.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/product_list_builder.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Future<void> _refreshPage(BuildContext context) async {
    await context.read<ProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (BuildContext context) => sl<ProductsCubit>(),
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (BuildContext context, ProductsState state) {
          return CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                automaticallyImplyLeading: false,
                title: Text('Tus productos'),
              ),
              if (state is Loading)
                const SliverFillRemaining(
                  child: LoadingDataAnimation(),
                ),
              if (state is Success)
                ProductListBuilder(
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
            ],
          );
        },
      ),
    );
  }
}

/* 
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


 */
