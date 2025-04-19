import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/custom_app_bar.dart';

class ProfileHeader extends CustomAppBar {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'informacion de la cuenta'.capitalize(),
        style: const TextStyle(
          fontFamily: 'Questrial',
          fontSize: 16,
        ),
      ),
    );
  }
}
