import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Convierte una imagen al formato WebP y la guarda como un nuevo archivo.
Future<File?> compressAndConvertToWebP({required String imagePath}) async {
  try {
    final File file = File(imagePath);
    final String outputFilePath =
        imagePath.replaceAll(RegExp(r'\.(png|jpg|jpeg)$'), '.webp');

    final Uint8List? compressedBytes =
        await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      format: CompressFormat.webp,
      autoCorrectionAngle: true,
      numberOfRetries: 3,
      quality: 80,
    );

    if (compressedBytes == null) {
      throw Exception('No se pudo convertir la imagen a WebP');
    }

    final File outputFile = File(outputFilePath);
    await outputFile.writeAsBytes(compressedBytes);

    return outputFile;
  } catch (e) {
    throw Exception('error convirtiendo las imagenes');
  }
}
