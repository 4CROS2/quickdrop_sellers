import 'package:quickdrop_sellers/src/domain/entity/estableshment_information_entity.dart';

class EstableshmentInformationModel extends EstableshmentInformationEntity {
  const EstableshmentInformationModel({
    required super.companyName,
    required super.rut,
    required super.description,
    required super.direction,
    required super.contact,
  });

  factory EstableshmentInformationModel.fromJson(Map<String, dynamic> json) {
    return EstableshmentInformationModel(
      companyName: json['company_name'] ?? '',
      rut: json['rut'] ?? '',
      description: json['description'] ?? '',
      direction: json['direction'] ?? '',
      contact: json['contact'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'company_name': companyName,
      'rut': rut,
      'description': description,
      'direction': direction,
      'contact': contact,
    };
  }

  factory EstableshmentInformationModel.fromDomain(
      EstableshmentInformationEntity entity) {
    return EstableshmentInformationModel(
      companyName: entity.companyName,
      contact: entity.contact,
      description: entity.description,
      direction: entity.direction,
      rut: entity.rut,
    );
  }
}