import 'package:flutter/material.dart';

extension TextInputTypeExtension on TextInputType {
  static TextInputType get numbersOnly => const TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      );
}
