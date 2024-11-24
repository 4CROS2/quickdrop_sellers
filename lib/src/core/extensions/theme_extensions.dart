import 'package:flutter/material.dart';

/// A set of extensions on [BuildContext] for accessing theme-related properties.
extension ThemeExtensions on BuildContext {
  /// Extension on [BuildContext] to access the theme data.
  ///
  /// This extension method provides easy access to the theme data using `Theme.of(this)`.
  ThemeData get theme => Theme.of(this);

  /// Extension on [BuildContext] to access the text theme.
  ///
  /// This extension method provides easy access to the text theme from the theme data.
  TextTheme get textTheme => theme.textTheme;

  /// Extension on [BuildContext] to access the color scheme.
  ///
  /// This extension method provides easy access to the color scheme from the theme data.
  ColorScheme get colorScheme => theme.colorScheme;
}
