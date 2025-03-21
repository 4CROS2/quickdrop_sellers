import 'package:intl/intl.dart';

String formatHour({required String time}) {
  // Separa la hora y los minutos
  final List<String> parts = time.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  // Crea un objeto DateTime con una fecha arbitraria
  final DateTime dateTime = DateTime(0, 1, 1, hour, minute);

  // Formatea el objeto DateTime al formato deseado
  final String formattedTime = DateFormat('hh:mm a').format(dateTime);

  return formattedTime;
}
