import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/domain/usecase/analytics_usecase.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/login.dart';
import 'package:quickdrop_sellers/src/presentation/auth/signup/signup.dart';
import 'package:quickdrop_sellers/src/presentation/error/error.dart';
import 'package:quickdrop_sellers/src/presentation/home/home.dart';
import 'package:quickdrop_sellers/src/presentation/loading/loading.dart';
import 'package:quickdrop_sellers/src/presentation/newProduct/new_product.dart';
import 'package:quickdrop_sellers/src/presentation/orderDetail/order_detail.dart';
import 'package:quickdrop_sellers/src/presentation/productDetail/product_detail.dart';
import 'package:quickdrop_sellers/src/presentation/profile/profile.dart';
import 'package:quickdrop_sellers/src/presentation/schedule/schedule.dart';
import 'package:quickdrop_sellers/src/routes/listener.dart';

class AppRouter {
  final AppCubit _appCubit = sl<AppCubit>();
  final AnalyticsUsecase _analytics = sl<AnalyticsUsecase>();
  late final GoRouter router = GoRouter(
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
        return '/home';
      }
      if (isAuthenticated &&
          <String>['/login', '/signup'].contains(currentLocation)) {
        return '/home';
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'loading page',
        builder: (BuildContext context, GoRouterState state) => const Loading(),
      ),
      GoRoute(
        path: '/login',
        name: 'login page',
        builder: (BuildContext context, GoRouterState state) => Login(),
      ),
      GoRoute(
        path: '/home',
        name: 'home page',
        builder: (BuildContext context, GoRouterState state) => Home(),
      ),
      GoRoute(
        path: '/signup',
        name: 'register page',
        builder: (BuildContext context, GoRouterState state) => Signup(),
      ),
      GoRoute(
        path: '/establishment',
        name: 'establishment',
        builder: (BuildContext context, GoRouterState state) => Profile(),
      ),
      GoRoute(
        path: '/schedule',
        name: 'schedule',
        builder: (BuildContext context, GoRouterState state) => Schedule(),
      ),
      GoRoute(
        path: '/productdetail/:productId',
        name: 'product details',
        builder: (BuildContext context, GoRouterState state) {
          final String? productId = state.pathParameters['productId'];
          return ProductDetail(productId: productId!);
        },
      ),
      GoRoute(
        path: '/addnewproduct',
        builder: (BuildContext context, GoRouterState state) => AddNewProduct(),
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
