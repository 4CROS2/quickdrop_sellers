import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class NoAccountButton extends StatelessWidget {
  const NoAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.paddingTop * 4,
      child: Center(
        child: TextButton(
          onPressed: () {
            context.push('/signup');
          },
          child: Text(
            'no tienes cuenta?'.capitalize(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
