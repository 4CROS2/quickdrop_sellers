import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    String title = '',
    bool centerTitle = false,
    List<Widget>? actions,
    super.key,
  })  : _title = title,
        _actions = actions,
        _centerTitle = centerTitle;
  final String _title;
  final bool _centerTitle;
  final List<Widget>? _actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        _title,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Questrial',
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: _actions,
      centerTitle: _centerTitle,
      automaticallyImplyLeading: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
