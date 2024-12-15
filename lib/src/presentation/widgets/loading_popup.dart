import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class LoadingPopUp extends StatelessWidget {
  const LoadingPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        borderRadius: Constants.mainBorderRadius,
        child: Padding(
          padding: EdgeInsets.all(
            Constants.paddingValue * 2,
          ),
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
