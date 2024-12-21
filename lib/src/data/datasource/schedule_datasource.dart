import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScheduleDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>> getSchedules() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sellers')
        .doc(_auth.currentUser!.uid)
        .get();
    final Map<String, dynamic> data = snapshot.toJson();
    return data['schedule'];
  }
}
