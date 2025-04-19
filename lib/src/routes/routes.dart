import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/domain/usecase/analytics_usecase.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/app_navigation_bar/presentation/app_navigation_bar.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/login.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/signup.dart';
import 'package:quickdrop_sellers/src/presentation/error/error.dart';
import 'package:quickdrop_sellers/src/presentation/loading/loading.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/new_product.dart';
import 'package:quickdrop_sellers/src/presentation/orderDetail/order_detail.dart';
import 'package:quickdrop_sellers/src/presentation/orders_page/orders.dart';
import 'package:quickdrop_sellers/src/presentation/productDetail/product_detail.dart';
import 'package:quickdrop_sellers/src/presentation/products/presentation/products.dart';
import 'package:quickdrop_sellers/src/presentation/profile/profile.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/schedule.dart';
import 'package:quickdrop_sellers/src/routes/listener.dart';

class AppRouter {
  final AppCubit _appCubit = sl<AppCubit>();
  final AnalyticsUsecase _analytics = sl<AnalyticsUsecase>();
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<StatefulNavigationShellState> _shellNavigatorKey =
      GlobalKey<StatefulNavigationShellState>();
  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoListener(stream: _appCubit.stream),
    errorPageBuilder: (BuildContext context, GoRouterState state) {
      return MaterialPage<ErrorPage>(
        child: ErrorPage(
          path: state.matchedLocation,
        ),
      );
    },
    redirect: (BuildContext context, GoRouterState state) {
      final AppState appState = _appCubit.state;
      final bool isAuthenticated = appState is Authenticated;
      final String currentLocation = state.matchedLocation;

      _analytics.logScreen(currentLocation);

      if (appState is UnAuthenticated &&
          state.matchedLocation != '/login' &&
          state.matchedLocation != '/signup') {
        return '/login';
      }

      if (isAuthenticated && currentLocation == '/') {
        return '/orders';
      }
      if (isAuthenticated &&
          <String>['/login', '/signup'].contains(currentLocation)) {
        return '/orders';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'loading page',
        builder: (_, __) => const Loading(),
      ),
      GoRoute(
        path: '/login',
        name: 'login page',
        builder: (_, __) => const Login(),
      ),
      GoRoute(
        path: '/signup',
        name: 'register page',
        builder: (_, __) => const Signup(),
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        key: _shellNavigatorKey,
        builder: (_, __, StatefulNavigationShell navigationShell) => Scaffold(
          body: navigationShell,
          bottomNavigationBar: AppNavigationBar(),
        ),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            preload: true,
            routes: <RouteBase>[
              GoRoute(
                path: '/orders',
                name: 'quickdrop',
                pageBuilder: (_, __) => const NoTransitionPage<Orders>(
                  child: Orders(),
                ),
              ),
              GoRoute(
                  path: '/products',
                  name: 'productos',
                  pageBuilder: (_, __) => const NoTransitionPage<Products>(
                        child: Products(),
                      ),
                  routes: <RouteBase>[
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: 'detail/:productId',
                      name: 'product details',
                      builder: (BuildContext context, GoRouterState state) {
                        final String? productId =
                            state.pathParameters['productId'];
                        return ProductDetail(productId: productId!);
                      },
                    ),
                  ]),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/establishment',
        name: 'establishment',
        builder: (_, __) => const Profile(),
      ),
      GoRoute(
        path: '/schedule',
        name: 'schedule',
        builder: (BuildContext context, GoRouterState state) =>
            const Schedule(),
      ),
      GoRoute(
        path: '/addnewproduct',
        builder: (BuildContext context, GoRouterState state) =>
            const AddNewProduct(),
      ),
      GoRoute(
        path: '/order/:orderId',
        builder: (BuildContext context, GoRouterState state) {
          final String orderId = (state.pathParameters['orderId'])!;
          return OrderDetail(orderId: orderId);
        },
      ),
    ],
  );
}
