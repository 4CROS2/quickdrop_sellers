import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_sellers/src/data/model/schedule_model.dart';

class ScheduleDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Map<String, dynamic>> getSchedules() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('sellers')
        .doc(_auth.currentUser!.uid)
        .get();
    final Map<String, dynamic> data = snapshot.toJson();
    return data['schedule'] ?? <String, dynamic>{};
  }

  Future<String> updateSchedule({required List<ScheduleModel> schedule}) async {
    try {
      final DocumentReference<Map<String, dynamic>> snapshot =
          _firestore.collection('sellers').doc(_auth.currentUser!.uid);

      final Map<String, dynamic> scheduleMap = <String, dynamic>{};

      for (ScheduleModel item in schedule) {
        scheduleMap.addAll(item.toJson());
      }

      await snapshot.update(<Object, Object?>{'schedule': scheduleMap});
      return 'horario actualizado';
    } catch (e) {
      throw Exception(e);
    }
  }
}
