import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/custom_app_bar.dart';

class HomeAppBar extends CustomAppBar {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Material(
        color: Colors.transparent,
        child: Hero(
          tag: 'title',
          child: Text(
            'quickdrop'.capitalize(),
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Questrial',
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
