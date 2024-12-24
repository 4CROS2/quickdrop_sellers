import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsDatasource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getProducts() async {
    final String uid = _auth.currentUser!.uid;
    try {
      final QuerySnapshot<Map<String, dynamic>> response = await _firestore
          .collection('products')
          .where('seller_id', isEqualTo: uid)
          .get();
      return response.toJson();
    } catch (e) {
      throw Exception(e);
    }
  }
}
