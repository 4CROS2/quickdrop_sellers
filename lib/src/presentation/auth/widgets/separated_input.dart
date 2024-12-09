import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class SeparatedInput extends StatelessWidget {
  const SeparatedInput({required Widget child, super.key}) : _widget = child;
  final Widget _widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.paddingTop,
      child: _widget,
    );
  }
}
