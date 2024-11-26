import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';

class AppUsecase {
  AppUsecase({
    required AuthRepository repository,
  }) : _repository = repository;
  final AuthRepository _repository;

  Stream<User?> authStatus() => _repository.authStatus();
}
