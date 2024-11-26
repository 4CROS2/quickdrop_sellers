import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/extensions/string_extensions.dart';

class NoAccountButton extends StatelessWidget {
  const NoAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.paddingTop * 4,
      child: Center(
        child: TextButton(
          onPressed: () {
            
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
