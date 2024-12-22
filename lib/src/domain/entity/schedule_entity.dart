import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  const ScheduleEntity({
    required this.day,
    required this.openHour,
    required this.closeHour,
  });

  final String day;
  final String openHour;
  final String closeHour;

  ScheduleEntity copyWith({
    String? day,
    String? openHour,
    String? closeHour,
  }) {
    return ScheduleEntity(
      day: day ?? this.day,
      openHour: openHour ?? this.openHour,
      closeHour: closeHour ?? this.closeHour,
    );
  }

  const ScheduleEntity.empty()
      : day = '',
        openHour = '',
        closeHour = '';

  bool get isEmpty => day.isEmpty || openHour.isEmpty || closeHour.isEmpty;

  @override
  List<Object?> get props => <Object?>[day, openHour, closeHour];

  @override
  bool? get stringify => true;
}
