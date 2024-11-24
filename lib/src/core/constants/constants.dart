import 'package:flutter/material.dart';

class Constants {
  static double borderValue = 14.0;
  static double paddingValue = 12;
  static Color mainColor = Colors.black12;
  static BorderRadius mainBorderRadius = BorderRadius.circular(
    borderValue,
  );
  static EdgeInsets mainPadding = EdgeInsets.symmetric(
    horizontal: paddingValue,
    vertical: paddingValue,
  ).copyWith(bottom: 0);

  static EdgeInsets paddingTop = EdgeInsets.only(
    top: Constants.paddingValue,
  );
  static EdgeInsets authInputPadding = EdgeInsets.symmetric(
    horizontal: paddingValue * 2,
  ).copyWith(top: paddingValue);
}
