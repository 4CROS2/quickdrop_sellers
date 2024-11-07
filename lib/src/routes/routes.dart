import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/presentation/home/home.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return const CupertinoPage<Home>(
            child: Home(),
          );
        },
      )
    ],
  );
}
