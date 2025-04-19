import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class DarkAppTheme {
  static ThemeData? _instance;

  static ThemeData get instance {
    if (_instance == null) {
      throw Exception('AppTheme not initialized with context');
    }
    return _instance!;
  }

  static void initialize(BuildContext context) {
    _instance = _createDarkTheme(context);
  }

  static ThemeData _createDarkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Constants.secondaryColor,
      fontFamily: 'Questrial',
      cardColor: Colors.grey.shade800,
      pageTransitionsTheme: Constants.pageTransition,
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
        surfaceTintColor: ThemeData.dark().scaffoldBackgroundColor,
        titleTextStyle: const TextStyle(
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
        fillColor: Colors.grey.shade800,
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
        contentPadding: Constants.authInputContent,
      ),
    );
  }
}
