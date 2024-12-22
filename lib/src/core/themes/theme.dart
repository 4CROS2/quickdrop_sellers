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

  static void initialize(BuildContext context, {bool isDarkMode = false}) {
    _instance =
        isDarkMode ? _createDarkTheme(context) : _createLightTheme(context);
  }

  static ThemeData _createLightTheme(BuildContext context) {
    return ThemeData(
      colorSchemeSeed: Constants.mainColor,
      scaffoldBackgroundColor: Colors.red.shade50,
      fontFamily: 'RedHat',
      cardColor: Colors.white,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Questrial',
        ),
      ),
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
        contentPadding: Constants.authInputContent,
      ),
    );
  }

  static ThemeData _createDarkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Constants.secondaryColor,
      scaffoldBackgroundColor: Colors.grey.shade900,
      fontFamily: 'RedHat',
      cardColor: Colors.grey.shade800,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
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
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        contentPadding: Constants.authInputContent,
      ),
    );
  }
}
