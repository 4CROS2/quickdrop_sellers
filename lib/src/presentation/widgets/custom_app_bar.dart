import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    String title = '',
    bool centerTitle = false,
    super.key,
  })  : _title = title,
        _centerTitle = centerTitle;
  final String _title;
  final bool _centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        _title,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'Questrial',
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: _centerTitle,
      automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
