import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/home/cubit/home_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page.dart/orders_pages.dart';
import 'package:quickdrop_sellers/src/presentation/home/widgets/homeDrawer/home_navigation_bar.dart';

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
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: Text('agregar'),
              icon: Icon(Icons.add),
            ),
            body: PageView(
              controller: _controller,
              onPageChanged: homeCubit.setPage,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Orders(),
                Text('s'),
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
