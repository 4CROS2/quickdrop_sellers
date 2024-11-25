import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> authStatus();

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> destroySession();
}
