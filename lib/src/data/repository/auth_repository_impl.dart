import 'package:quickdrop_sellers/src/data/datasource/auth_datasource.dart';
import 'package:quickdrop_sellers/src/data/model/app_model.dart';
import 'package:quickdrop_sellers/src/data/model/estableshment_information_model.dart';
import 'package:quickdrop_sellers/src/data/model/establishment_location_model.dart';
import 'package:quickdrop_sellers/src/data/model/seller_auth_model.dart';
import 'package:quickdrop_sellers/src/data/model/seller_information_model.dart';
import 'package:quickdrop_sellers/src/domain/entity/estableshment_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/establishment_location_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_auth_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';

class IAuthRepository implements AuthRepository {
  IAuthRepository({
    required AuthDatasource datasource,
  }) : _datasource = datasource;
  final AuthDatasource _datasource;

  @override
  Stream<AppModel?> authStatus() {
    final Stream<Map<String, dynamic>?> response = _datasource.authStatus();
    return response.map((Map<String, dynamic>? json) {
      if (json == null) {
        return null;
      }
      try {
        return AppModel.fromJson(json: json);
      } catch (e) {
        return null;
      }
    });
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
  Future<void> createNewAccount({
    required SellerAuthEntity sellerAuth,
    required EstablishmentLocationEntity location,
    required SellerInformationEntity sellerInformation,
    required EstableshmentInformationEntity establishmentInformation,
  }) async {
    await _datasource.createNewAccount(
      sellerAuth: SellerAuthModel(
        email: sellerAuth.email,
        password: sellerAuth.password,
      ),
      location: EstablishmentLocationModel.fromDomain(entity: location),
      sellerInformation: SellerInformationModel.fromDomain(
        sellerInformation,
      ),
      establishmentInformation: EstableshmentInformationModel.fromDomain(
        establishmentInformation,
      ),
    );
  }

  @override
  Future<void> destroySession() async {
    await _datasource.destroySession();
  }
}
