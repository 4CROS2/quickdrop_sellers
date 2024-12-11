String? validateRUT(String? value) {
  if (value == null || value.isEmpty) {
    // Si el campo está vacío, no se valida porque no es obligatorio
    return null;
  }

  // Divide el RUT en número base y dígito verificador (si está presente)
  final List<String> parts = value.split('-');
  final String base = parts[0];
  final String? verifier = parts.length > 1 ? parts[1] : null;

  // Verifica que el número base sea numérico
  if (!RegExp(r'^\d+$').hasMatch(base)) {
    return 'El número base del RUT debe ser un número válido';
  }

  // Si no se proporciona el dígito verificador, se considera válido
  if (verifier == null) {
    return null; // RUT válido sin verificador
  }

  // Valida el dígito verificador
  if (!RegExp(r'^\d$').hasMatch(verifier)) {
    return 'El dígito verificador debe ser un número del 0 al 9';
  }

  final String expectedVerifier = _calculateDV(base);

  if (verifier != expectedVerifier) {
    return 'El RUT es inválido. El dígito verificador esperado es $expectedVerifier';
  }

  return null; // RUT válido
}

String _calculateDV(String base) {
  int sum = 0;
  int multiplier = 2;

  for (int i = base.length - 1; i >= 0; i--) {
    sum += int.parse(base[i]) * multiplier;
    multiplier = multiplier == 7 ? 2 : multiplier + 1;
  }

  final int remainder = sum % 11;
  final int dv = 11 - remainder;

  return dv == 10 ? '0' : (dv == 11 ? '1' : dv.toString());
}
