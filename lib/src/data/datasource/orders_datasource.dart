import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrdersDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getOrders() {
    final String userId = _firebaseAuth.currentUser!.uid;
    try {
      final Stream<List<Map<String, dynamic>>> response = _firestore
          .collection('sellers')
          .doc(userId)
          .collection('orders')
          .orderBy(
            'order_time',
            descending: false,
          )
          .snapshots()
          .toMapJsonListStream();

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
