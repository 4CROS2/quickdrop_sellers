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
      emit(state.copyWith(
        status: ScheduleStatus.success,
        schedules: schedules,
        newSchedules: schedules,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ScheduleStatus.error,
        message: e.toString(),
      ));
    }
  }

  Future<void> saveSchedules() async {
    if (!_hasChanges()) {
      emit(state.copyWith(
        saveStatus: ScheduleStatus.error,
        message: 'No hay cambios para guardar',
      ));
      return;
    }

    emit(
      state.copyWith(
        saveStatus: ScheduleStatus.loading,
      ),
    );

    try {
      final String response = await _usecase.saveSchedules(
        schedules: state.newSchedules,
      );

      emit(
        state.copyWith(
          saveStatus: ScheduleStatus.success,
          schedules: state.newSchedules,
          message: response,
        ),
      );

      emit(
        state.copyWith(
          saveStatus: ScheduleStatus.initial,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        saveStatus: ScheduleStatus.error,
        message: e.toString(),
      ));
      emit(state.copyWith(
        saveStatus: ScheduleStatus.initial,
        message: '',
      ));
    }
  }

  void newSchedules({
    required String day,
    ScheduleEntity? schedule,
  }) {
    final List<ScheduleEntity> newSchedules = List<ScheduleEntity>.from(
      state.newSchedules,
    );

    if (schedule == null) {
      newSchedules.removeWhere(
        (ScheduleEntity element) => element.day == day,
      );
    } else if (!schedule.isEmpty) {
      final int index = newSchedules.indexWhere(
        (ScheduleEntity element) => element.day == day,
      );

      if (index != -1) {
        newSchedules[index] = schedule;
      } else {
        newSchedules.add(schedule);
      }
    }

    _emitNewSchedules(newSchedules: newSchedules);
  }

  void _emitNewSchedules({required List<ScheduleEntity> newSchedules}) {
    emit(state.copyWith(newSchedules: newSchedules));
  }

  bool _hasChanges() {
    if (state.schedules.length != state.newSchedules.length) {
      return true;
    }

    for (final ScheduleEntity schedule in state.schedules) {
      final ScheduleEntity newSchedule = state.newSchedules.firstWhere(
        (ScheduleEntity element) => element.day == schedule.day,
        orElse: () => const ScheduleEntity.empty(),
      );

      if (newSchedule.isEmpty ||
          newSchedule.openHour != schedule.openHour ||
          newSchedule.closeHour != schedule.closeHour) {
        return true;
      }
    }

    return false;
  }
}
