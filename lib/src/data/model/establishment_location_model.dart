import 'package:quickdrop_sellers/src/domain/entity/establishment_location_entity.dart';

class EstablishmentLocationModel extends EstablishmentLocationEntity {
  const EstablishmentLocationModel({
    required super.direction,
    required super.aditionalInfomation,
    required super.location,
  });

  static EstablishmentLocationModel fromJson(Map<String, dynamic> json) {
    return EstablishmentLocationModel(
      direction: json['direction'],
      aditionalInfomation: json['aditional_infomation'],
      location: json['location'],
    );
  }

  static EstablishmentLocationModel fromDomain(
      {required EstablishmentLocationEntity entity}) {
    return EstablishmentLocationModel(
      direction: entity.direction,
      aditionalInfomation: entity.aditionalInfomation,
      location: entity.location,
    );
  }

  Map<String, Object> toJson() {
    return <String, Object>{
      'direction': direction,
      'aditional_infomation': aditionalInfomation,
      'location': location,
    };
  }
}
