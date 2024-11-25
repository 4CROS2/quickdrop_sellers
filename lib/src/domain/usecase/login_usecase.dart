import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';

class LoginUsecase {
  LoginUsecase({
    required AuthRepository repository,
  }) : _repository = repository;
  final AuthRepository _repository;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) =>
      _repository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
}
