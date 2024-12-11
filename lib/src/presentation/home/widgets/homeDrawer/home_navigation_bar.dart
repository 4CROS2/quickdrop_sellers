import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class HomeNavigationBar extends StatefulWidget {
  const HomeNavigationBar({
    int selected = 0,
    ValueChanged<int>? onTap,
    super.key,
  })  : _onTap = onTap,
        _selected = selected;
  final ValueChanged<int>? _onTap;
  final int _selected;
  @override
  State<HomeNavigationBar> createState() => _HomeNavigationBarState();
}

class _HomeNavigationBarState extends State<HomeNavigationBar> {
  final List<Map<String, dynamic>> destinations = <Map<String, dynamic>>[
    <String, dynamic>{
      'icon': Icons.home_outlined,
      'label': 'inicio',
      'selected_icon': Icons.home_rounded
    },
    <String, dynamic>{
      'icon': Icons.category_outlined,
      'label': 'productos',
      'selected_icon': Icons.category_rounded
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      elevation: 2,
      onDestinationSelected: widget._onTap,
      indicatorColor: Constants.secondaryColor,
      selectedIndex: widget._selected,
      surfaceTintColor: Constants.secondaryColor,
      destinations: <Widget>[
        ...List<Widget>.generate(
          destinations.length,
          (int index) {
            return NavigationDestination(
              icon: Icon(destinations[index]['icon']),
              label: (destinations[index]['label'] as String).capitalize(),
              tooltip: destinations[index]['label'],
              selectedIcon: Icon(
                destinations[index]['selected_icon'],
                color: Colors.white,
              ),
            );
          },
        ),
      ],
    );
  }
}
