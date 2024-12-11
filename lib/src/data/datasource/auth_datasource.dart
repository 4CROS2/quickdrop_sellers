import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_sellers/src/data/model/estableshment_information_model.dart';
import 'package:quickdrop_sellers/src/data/model/seller_auth_model.dart';
import 'package:quickdrop_sellers/src/data/model/seller_information_model.dart';

class AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<User?> authStatus() {
    return _firebaseAuth.userChanges();
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  Future<void> createNewAccount({
    required SellerAuthModel sellerAuth,
    required SellerInformationModel sellerInformation,
    required EstableshmentInformationModel establishmentInformation,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: sellerAuth.email,
        password: sellerAuth.password,
      );

      String uid = userCredential.user!.uid;

      await _firebaseFirestore
          .collection('sellers')
          .doc(uid)
          .set(<String, dynamic>{
        ...establishmentInformation.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _firebaseFirestore
          .collection('sellers')
          .doc(uid)
          .collection('sellerInformation')
          .doc('details')
          .set(
            sellerInformation.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      throw Exception('Error al crear cuenta: ${e.message}');
    } catch (e) {
      throw Exception('Error al guardar datos: $e');
    }
  }

  Future<void> destroySession() async {
    await _firebaseAuth.signOut();
  }
}
