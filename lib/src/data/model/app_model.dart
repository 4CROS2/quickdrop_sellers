import 'package:quickdrop_sellers/src/data/model/account_information_model.dart';
import 'package:quickdrop_sellers/src/data/model/estableshment_information_model.dart';
import 'package:quickdrop_sellers/src/data/model/seller_information_model.dart';
import 'package:quickdrop_sellers/src/domain/entity/app_entity.dart';

class AppModel extends AppEntity {
  AppModel({
    required super.establishment,
    required super.sellerInformation,
    required super.accountInformation,
  });

  static AppModel fromJson({required Map<String, dynamic> json}) {
    final Map<String, dynamic> jsonEstablishment = json['establishment'];
    final Map<String, dynamic> jsonSellerInformation =
        json['sellerInformation'];
    final Map<String, dynamic> jsonAccountInformation =
        json['accountInformation'];

    return AppModel(
      establishment: EstableshmentInformationModel.fromJson(
        jsonEstablishment,
      ),
      sellerInformation: SellerInformationModel.fromJson(
        jsonSellerInformation,
      ),
      accountInformation: AccountInformationModel.fromJson(
        json: jsonAccountInformation,
      ),
    );
  }
}
