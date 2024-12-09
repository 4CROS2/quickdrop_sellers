import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_sellers/src/data/datasource/auth_datasource.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';

class IAuthRepository implements AuthRepository {
  IAuthRepository({
    required AuthDatasource datasource,
  }) : _datasource = datasource;
  final AuthDatasource _datasource;

  @override
  Stream<User?> authStatus() {
    return _datasource.authStatus();
  }

  @override
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _datasource.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  
  @override
  Future<void> destroySession() async {
    await _datasource.destroySession();
  }
}
