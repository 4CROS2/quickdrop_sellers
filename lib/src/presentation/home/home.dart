import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/home/cubit/home_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/orders.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/products/products.dart';
import 'package:quickdrop_sellers/src/presentation/home/widgets/drawer/home_drawer.dart';
import 'package:quickdrop_sellers/src/presentation/home/widgets/homeNavigation/home_navigation_bar.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (BuildContext context) => sl<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (BuildContext context, HomeState state) {
          final HomeCubit homeCubit = context.read<HomeCubit>();
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Quickdrop',
              centerTitle: true,
            ),
            drawer: HomeDrawer(),
            body: PageView(
              controller: _controller,
              onPageChanged: homeCubit.setPage,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Orders(),
                Products(),
              ],
            ),
            bottomNavigationBar: HomeNavigationBar(
              onTap: (int value) => homeCubit.jumpToPage(
                controller: _controller,
                page: value,
              ),
              selected: state.currentPage,
            ),
          );
        },
      ),
    );
  }
}
