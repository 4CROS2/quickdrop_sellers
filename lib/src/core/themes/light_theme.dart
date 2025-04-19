import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class LightAppTheme {
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
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Questrial',
      cardColor: Colors.grey[200],
      pageTransitionsTheme: Constants.pageTransition,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        foregroundColor: Constants.secondaryColor,
        surfaceTintColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Questrial',
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: Constants.mainBorderRadius,
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        contentPadding: Constants.authInputContent,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        // ignore: deprecated_member_use
        year2023: false,
      ),
    );
  }
}
