import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';

class ScheduleModel extends ScheduleEntity {
  const ScheduleModel({
    required super.day,
    required super.openHour,
    required super.closeHour,
  });

  factory ScheduleModel.fromEntity({required ScheduleEntity entity}) {
    return ScheduleModel(
      day: entity.day,
      openHour: entity.openHour,
      closeHour: entity.closeHour,
    );
  }
  factory ScheduleModel.fromJson({required Map<String, dynamic> json}) {
    return ScheduleModel(
      day: json['day'],
      openHour: json['open_hour'],
      closeHour: json['close_hour'],
    );
  }
  Map<String, String> toJson() {
    return <String, String>{
      'day': day,
      'openHour': openHour,
      'closeHour': closeHour,
    };
  }
}
