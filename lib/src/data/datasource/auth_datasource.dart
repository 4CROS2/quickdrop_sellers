import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extensions/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_sellers/src/data/model/estableshment_information_model.dart';
import 'package:quickdrop_sellers/src/data/model/establishment_location_model.dart';
import 'package:quickdrop_sellers/src/data/model/seller_auth_model.dart';
import 'package:quickdrop_sellers/src/data/model/seller_information_model.dart';
import 'package:rxdart/rxdart.dart';

class AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<Map<String, dynamic>?> authStatus() {
    return _firebaseAuth.userChanges().switchMap((User? user) {
      if (user == null) {
        // Si no hay usuario autenticado, devolvemos un Stream con null.
        return Stream<Map<String, dynamic>?>.value(null);
      }

      // Referencia principal al documento del usuario.
      final DocumentReference<Map<String, dynamic>> reference =
          _firebaseFirestore.collection('sellers').doc(user.uid);

      // Stream de datos del documento principal.
      final Stream<Map<String, dynamic>> establishmentStream =
          reference.snapshots().toMapJsonStream();

      // Stream de la colección 'sellerInformation'.
      final Stream<Map<String, dynamic>> sellerInformationStream = reference
          .collection('sellerInformation')
          .doc('details')
          .snapshots()
          .toMapJsonStream();

      // Datos de 'accountInformation', no depende de Firestore.
      final Map<String, dynamic> accountInformation = <String, dynamic>{
        'isVerify': user.emailVerified,
        'email': user.email,
        'uid': user.uid,
      };

      // Combinamos los streams con los datos adicionales.
      return Rx.combineLatest2(
        establishmentStream,
        sellerInformationStream,
        (Map<String, dynamic> establishment, Map<String, dynamic> sellerInfo) {
          final Map<String, dynamic> combinedData = <String, dynamic>{};
          combinedData['establishment'] = establishment;
          combinedData['sellerInformation'] = sellerInfo;
          combinedData['accountInformation'] = accountInformation;
          return combinedData;
        },
      );
    });
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
    required EstablishmentLocationModel location,
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
        ...location.toJson(),
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
