import 'package:flutter/material.dart';

class Constants {
  static double borderValue = 14.0;
  static double paddingValue = 12;
  static Color mainColor = Colors.black12;
  static Color secondaryColor = Colors.red;

  static Duration mainDuration = const Duration(
    milliseconds: 200,
  );

  static BorderRadius mainBorderRadius = BorderRadius.circular(
    borderValue,
  );
  static EdgeInsets mainPaddingWithOutBottom = EdgeInsets.symmetric(
    horizontal: paddingValue,
    vertical: paddingValue,
  ).copyWith(bottom: 0);
  static EdgeInsets mainPadding = EdgeInsets.all(paddingValue);

  static EdgeInsets paddingTop = EdgeInsets.only(
    top: Constants.paddingValue,
  );
  static EdgeInsets authInputPadding = EdgeInsets.symmetric(
    horizontal: paddingValue * 2,
  ).copyWith(top: paddingValue);

  static EdgeInsets authInputContent = EdgeInsets.symmetric(
    horizontal: paddingValue,
    vertical: paddingValue * 1.5,
  );

  static ScrollPhysics mainPhysics = AlwaysScrollableScrollPhysics(
    parent: BouncingScrollPhysics(),
  );
}
