import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/custom_app_bar.dart';

class ProfileHeader extends CustomAppBar {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Tu perfil',
        style: TextStyle(
          fontFamily: 'Questrial',
          fontSize: 16,
        ),
      ),
    );
  }
}
