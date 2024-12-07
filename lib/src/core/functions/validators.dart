import 'package:extensions/extensions.dart';

String? emailvalidator(String? value) {
  if (value == null || value.isEmpty) {
    return _campRequired();
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
    return _campRequired();
  }

  if (value.length < 8) {
    return 'contraseña demasiado corta'.capitalize();
  }
  return null;
}

String? comparePassword({
  required String? firstPassword,
  required String? secondPassword,
}) {
  if (secondPassword!.isEmpty) {
    return _campRequired();
  }

  if (firstPassword != secondPassword) {
    return 'las contraseñas no coninciden';
  }
  return null;
}

String? emptyValidator(String? value) {
  if (value!.isEmpty) {
    return _campRequired();
  }
  return null;
}

String? _campRequired() {
  return 'campo requerido*'.capitalize();
}
