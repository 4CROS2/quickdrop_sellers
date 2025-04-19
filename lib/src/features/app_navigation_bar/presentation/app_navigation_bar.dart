import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:quickdrop_sellers/src/features/app_navigation_bar/domain/entity/destination_route.dart';
import 'package:quickdrop_sellers/src/features/app_navigation_bar/presentation/widgets/destinations.dart';
import 'package:quickdrop_sellers/src/features/app_navigation_bar/presentation/widgets/go_router_builder.dart';

class AppNavigationBar extends StatelessWidget {
  AppNavigationBar({super.key});

  final List<DestinationRoute> destinations = <DestinationRoute>[
    DestinationRoute(
      page: 0,
      path: '/orders',
      destinaton: Destination(
        icon: HugeIcons.strokeRoundedHome10,
        label: 'tus ordenes',
      ),
    ),
    DestinationRoute(
      page: 1,
      path: '/products',
      destinaton: Destination(
        icon: HugeIcons.strokeRoundedTable,
        label: 'productos',
      ),
    ),
    DestinationRoute(
      page: 2,
      path: '/usermenu',
      destinaton: Destination(
        icon: HugeIcons.strokeRoundedUserAccount,
        label: 'cuenta',
      ),
    ),
  ];

  int _getPage({required String location}) {
    final DestinationRoute? matchingRoute = destinations.firstWhereOrNull(
          (DestinationRoute dest) => location == dest.path,
        ) ??
        destinations.firstWhereOrNull(
          (DestinationRoute dest) => location.startsWith(dest.path),
        );
    return matchingRoute?.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return GoRouterBuilder(
      builder: (BuildContext context, GoRouterState state, Widget? child) {
        final String currentLocation = state.uri.path;
        final int currentPage = _getPage(location: currentLocation);

        return NavigationBar(
          selectedIndex: currentPage,
          onDestinationSelected: (int value) {
            if (value == currentPage) {
              return;
            }

            final String targetPath = destinations[value].path;

            if (value == 0 && currentLocation != '/orders') {
              context.go('/orders');
            } else if (currentLocation == '/orders') {
              context.push(targetPath);
            } else {
              context.pushReplacement(targetPath);
            }
          },
          destinations: destinations
              .map(
                (DestinationRoute destination) => destination.destinaton,
              )
              .toList(),
        );
      },
    );
  }
}
