import 'package:quickdrop_sellers/src/domain/entity/estableshment_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/establishment_location_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_auth_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';

class SignupUsecase {
  SignupUsecase({
    required AuthRepository repository,
  }) : _repository = repository;
  final AuthRepository _repository;

  Future<void> createNewAccount({
    required SellerAuthEntity sellerAuth,
    required EstablishmentLocationEntity location,
    required SellerInformationEntity sellerInformation,
    required EstableshmentInformationEntity estableshmentInformation,
  }) =>
      _repository.createNewAccount(
        sellerAuth: sellerAuth,
        location: location,
        sellerInformation: sellerInformation,
        establishmentInformation: estableshmentInformation,
      );
}
