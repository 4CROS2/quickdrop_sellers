import 'package:quickdrop_sellers/src/domain/entity/app_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';

class AppUsecase {
  AppUsecase({
    required AuthRepository repository,
  }) : _repository = repository;
  final AuthRepository _repository;

  Stream<AppEntity?> authStatus() => _repository.authStatus();
}
