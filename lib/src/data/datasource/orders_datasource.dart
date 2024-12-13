import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';

class OrdersDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Map<String, dynamic>>> getOrders({required String sellerId}) {
    try {
      final Stream<List<Map<String, dynamic>>> response = _firestore
          .collection('sellers')
          .doc(sellerId)
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
