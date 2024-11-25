import 'package:firebase_auth/firebase_auth.dart';

class AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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

  Future<void> destroySession() async {
    await _firebaseAuth.signOut();
  }
}
