import 'package:quickdrop_sellers/src/domain/entity/seller_information_entity.dart';

class SellerInformationModel extends SellerInformationEntity {
  const SellerInformationModel({
    required super.name,
    required super.lastName,
    required super.id,
    required super.documentType,
    required super.date,
    required super.phone,
  });

  factory SellerInformationModel.fromJson(Map<String, dynamic> json) {
    return SellerInformationModel(
      name: json['name'],
      lastName: json['lastName'],
      id: json['id'],
      documentType: json['documentType'],
      date: json['date'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'lastName': lastName,
      'id': id,
      'documentType': documentType,
      'date': date,
      'phone': phone,
    };
  }
}
