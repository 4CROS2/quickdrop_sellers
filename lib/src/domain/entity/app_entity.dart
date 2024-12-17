import 'package:quickdrop_sellers/src/domain/entity/account_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/estableshment_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_information_entity.dart';

class AppEntity {
  AppEntity({
    required this.establishment,
    required this.sellerInformation,
    required this.accountInformation,
  });
  final EstableshmentInformationEntity establishment;
  final SellerInformationEntity sellerInformation;
  final AccountInformationEntity accountInformation;
}
