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

  static PageTransitionsTheme get _pageTransition => PageTransitionsTheme(
        builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
          TargetPlatform.values,
          value: (_) => FadeForwardsPageTransitionsBuilder(),
        ),
      );

  static ThemeData _createLightTheme(BuildContext context) {
    return ThemeData(
      colorSchemeSeed: Constants.mainColor,
      scaffoldBackgroundColor: Colors.red.shade50,
      fontFamily: 'Questrial',
      cardColor: Colors.white,
      pageTransitionsTheme: _pageTransition,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
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
        fillColor: Colors.white,
        hintStyle: TextStyle(
          color: Colors.black,
        ),
        contentPadding: Constants.authInputContent,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        // ignore: deprecated_member_use
        year2023: false,
      ),
    );
  }

  static ThemeData _createDarkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Constants.secondaryColor,
      scaffoldBackgroundColor: Colors.grey.shade900,
      fontFamily: 'Questrial',
      cardColor: Colors.grey.shade800,
      pageTransitionsTheme: _pageTransition,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
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
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
        contentPadding: Constants.authInputContent,
      ),
    );
  }
}
