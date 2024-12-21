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
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const MaterialPage<Loading>(
            child: Loading(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login page',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage<Login>(
            child: Login(),
          );
        },
      ),
      GoRoute(
        path: '/home',
        name: 'home page',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage<Home>(
            name: state.name,
            child: Home(),
          );
        },
      ),
      GoRoute(
        path: '/signup',
        name: 'register page',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage<Signup>(
            name: state.name,
            child: Signup(),
          );
        },
      ),
      GoRoute(
        path: '/establishment',
        name: 'establishment',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage<Profile>(
            name: state.name,
            child: Profile(),
          );
        },
      ),
      GoRoute(
        path: '/schedule',
        name: 'schedule',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage<Schedule>(
            name: state.name,
            child: Schedule(),
          );
        },
      ),
    ],
  );
}
