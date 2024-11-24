import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class AppTheme {
  static ThemeData? _instance;

  static ThemeData get instance {
    if (_instance == null) {
      throw Exception('AppTheme not initialized with context');
    }
    return _instance!;
  }

  static void initialize(BuildContext context) {
    _instance = _createLightTheme(context);
  }

  static ThemeData _createLightTheme(BuildContext context) {
    return ThemeData(
      colorSchemeSeed: Constants.mainColor,
      scaffoldBackgroundColor: Colors.red.shade50,
      fontFamily: 'RedHat',
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: Constants.mainBorderRadius,
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Constants.mainColor,
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
    );
  }
}
