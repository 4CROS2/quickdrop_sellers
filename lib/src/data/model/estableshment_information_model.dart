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
      companyName: json['companyName'] ?? '',
      rut: json['rut'] ?? '',
      description: json['description']??'',
      direction: json['direction']??'',
      contact: json['contact']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'companyName': companyName,
      'rut': rut,
      'description': description,
      'direction': direction,
      'contact': contact,
    };
  }
}
