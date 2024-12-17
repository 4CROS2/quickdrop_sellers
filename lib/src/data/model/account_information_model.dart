import 'package:quickdrop_sellers/src/domain/entity/account_information_entity.dart';

class AccountInformationModel extends AccountInformationEntity {
  AccountInformationModel({
    required super.isVerify,
    required super.email,
    required super.uid,
  });

  static AccountInformationModel fromJson(
      {required Map<String, dynamic> json}) {
    return AccountInformationModel(
      isVerify: json['isVerify'] ?? false,
      email: json['email'],
      uid: json['uid'],
    );
  }
}
