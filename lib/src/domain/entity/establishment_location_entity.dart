import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EstablishmentLocationEntity extends Equatable {
  const EstablishmentLocationEntity({
    required this.direction,
    required this.aditionalInfomation,
    required this.location,
  });

  final String direction;
  final String aditionalInfomation;
  final GeoPoint location;

  static const EstablishmentLocationEntity empty = EstablishmentLocationEntity(
    direction: '',
    aditionalInfomation: '',
    location: GeoPoint(0, 0),
  );

  @override
  List<Object?> get props => <Object?>[
        direction,
        aditionalInfomation,
        location,
      ];
}
