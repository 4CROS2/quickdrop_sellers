import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';
import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/home/home.dart';
import 'package:quickdrop_sellers/src/presentation/loading/loading.dart';
import 'package:quickdrop_sellers/src/presentation/auth/login/login.dart';
import 'package:quickdrop_sellers/src/routes/listener.dart';

class AppRouter {
  final AppCubit _appCubit = sl<AppCubit>();
  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoListener(stream: _appCubit.stream),
    redirect: (BuildContext context, GoRouterState state) {
      if (_appCubit.state is UnAuthenticated && state.matchedLocation == '/') {
        return '/login';
      }
      if (_appCubit.state is UnAuthenticated &&
          state.matchedLocation != '/login') {
        return '/login';
      }
      if (_appCubit is Authenticated && state.matchedLocation == '/') {
        return '/home';
      }
      if (_appCubit is Authenticated && state.matchedLocation == '/login') {
        return '/home';
      }
      if (_appCubit is Authenticated && state.matchedLocation == '/signUp') {
        return '/home';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<Loading>(
            child: Loading(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage<Login>(
            child: Login(),
          );
        },
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const CupertinoPage<Home>(
            child: Home(),
          );
        },
      )
    ],
  );
}
