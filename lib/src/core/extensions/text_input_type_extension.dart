import 'package:flutter/material.dart';

extension TextInputTypeExtension on TextInputType {
  static TextInputType get numbersOnly => TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      );
}
