import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/home/cubit/home_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/orders_page.dart';
import 'package:quickdrop_sellers/src/presentation/home/widgets/homeDrawer/home_navigation_bar.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/animation_button.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PageController _controller;
  //late final AuthRepository _authProvider;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
    //_authProvider = sl<AuthRepository>();
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
            appBar: AppBar(
              centerTitle: true,
              title: Material(
                color: Colors.transparent,
                child: Hero(
                  tag: 'title',
                  child: Text(
                    'quickdrop'.capitalize(),
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
            drawer: Drawer(),
            floatingActionButton: AnimationButton(
                child: Material(
              surfaceTintColor: Constants.secondaryColor,
              borderRadius: Constants.mainBorderRadius,
              child: SizedBox(
                width: 60,
                height: 60,
                child: Icon(
                  Icons.add,
                ),
              ),
            )),
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
