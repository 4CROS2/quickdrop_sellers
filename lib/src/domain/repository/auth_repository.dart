import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickdrop_sellers/src/domain/entity/estableshment_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_auth_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_information_entity.dart';

abstract class AuthRepository {
  Stream<User?> authStatus();

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> createNewAccount({
    required SellerAuthEntity sellerAuth,
    required SellerInformationEntity sellerInformation,
    required EstableshmentInformationEntity establishmentInformation,
  });
  Future<void> destroySession();
}
