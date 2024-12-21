import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/schedule_usecase.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit({
    required ScheduleUsecase usecase,
  })  : _usecase = usecase,
        super(const ScheduleState());
  final ScheduleUsecase _usecase;

  Future<void> getSchedules() async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      final List<ScheduleEntity> schedules = await _usecase.getSchedules();
      emit(
        state.copyWith(
          status: ScheduleStatus.success,
          schedules: schedules,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ScheduleStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> saveSchedules() async {
    await _usecase.saveSchedules(schedules: state.newSchedules);
  }

  void newSchedules({
    required String day,
    ScheduleEntity? schedule,
  }) {
    final List<ScheduleEntity> newSchedules = List<ScheduleEntity>.from(
      state.newSchedules,
    );
    final List<ScheduleEntity> currentSchedules = List<ScheduleEntity>.from(
      state.schedules,
    );

    if (schedule == null) {
      newSchedules.removeWhere(
        (ScheduleEntity element) => element.day == day,
      );
      _emitNewSchedules(newSchedules: newSchedules);

      return;
    }

    if (schedule.isEmpty == false) {
      newSchedules
        ..removeWhere(
          (ScheduleEntity element) => element.day == day,
        )
        ..add(schedule);

      _emitNewSchedules(newSchedules: newSchedules);
    }
  }

  void _emitNewSchedules({required List<ScheduleEntity> newSchedules}) {
    emit(
      state.copyWith(
        newSchedules: newSchedules,
      ),
    );
  }
}
