part of 'schedule_cubit.dart';

enum ScheduleStatus { initial, loading, success, error }

class ScheduleState extends Equatable {
  const ScheduleState({
    this.schedules = const <ScheduleEntity>[],
    this.newSchedules = const <ScheduleEntity>[],
    this.status = ScheduleStatus.initial,
    this.message = '',
  });
  final List<ScheduleEntity> schedules;
  final List<ScheduleEntity> newSchedules;
  final ScheduleStatus status;
  final String message;
  ScheduleState copyWith({
    List<ScheduleEntity>? schedules,
    List<ScheduleEntity>? newSchedules,
    ScheduleStatus? status,
    String? message,
  }) {
    return ScheduleState(
      schedules: schedules ?? this.schedules,
      newSchedules: newSchedules ?? this.newSchedules,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => <Object>[schedules, newSchedules, status, message];

  @override
  bool? get stringify => true;
}
