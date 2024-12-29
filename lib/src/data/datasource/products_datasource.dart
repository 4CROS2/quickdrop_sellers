import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickdrop_sellers/src/core/functions/webp_image_converter.dart';
import 'package:quickdrop_sellers/src/data/model/new_product_model.dart';
import 'package:quickdrop_sellers/src/domain/entity/new_product_entity.dart';

class ProductsDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Obtener el UID del usuario actual
  String get _uid => _auth.currentUser!.uid;

  Future<Map<String, dynamic>> getProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection('products')
          .where(
            'seller_id',
            isEqualTo: _uid,
          )
          .get();
      return response.toJson();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<NewProductStatus> saveNewProduct({
    required NewProductModel product,
  }) async {
    try {
      final Map<String, dynamic> data = product.toJson();
      data['seller_id'] = _uid;

      // Extraer las rutas de las imágenes
      final List<String> imagePaths =
          product.images.map((XFile e) => e.path).toList();

      // Procesar imágenes en isolate
      List<String> webpPaths = <String>[];

      for (final String path in imagePaths) {
        final File? webpFile = await compressAndConvertToWebP(imagePath: path);
        if (webpFile != null) {
          webpPaths.add(webpFile.path);
        }
      }

      // Subir a Firebase Storage
      final List<String> uploadedUrls = <String>[];
      for (final String path in webpPaths) {
        final String fileName = path.split('/').last;
        final Reference ref = _storage.ref().child('products/$fileName');
        final UploadTask uploadTask = ref.putFile(File(path));

        final TaskSnapshot snapshot = await uploadTask;
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        uploadedUrls.add(downloadUrl);
      }

      data['base_images'] = uploadedUrls;
      await _firestore.collection('products').add(data);
      return NewProductStatus.success;
    } catch (e) {
      rethrow;
    }
  }
}
