import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Loading...',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ).copyWith(top: 20),
            child: LinearProgressIndicator(
              minHeight: 6,
              borderRadius: Constants.mainBorderRadius,
            ),
          ),
        ],
      ),
    );
  }
}
