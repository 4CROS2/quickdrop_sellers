import 'package:quickdrop_sellers/src/core/extensions/string_extensions.dart';

String? emailvalidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Correo requerido*'.capitalize();
  }

  // Expresión regular para validar el correo electrónico
  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegExp.hasMatch(value)) {
    return 'Correo invalido*'.capitalize();
  }

  return null;
}

String? passwordValidator(String? value) {
  if (value!.isEmpty) {
    return 'campo requerido*'.capitalize();
  }
  return null;
}
