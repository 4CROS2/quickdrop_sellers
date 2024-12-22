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
    emit(
      state.copyWith(
        saveStatus: ScheduleStatus.initial,
      ),
    );
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
    } catch (e) {
      emit(
        state.copyWith(
          saveStatus: ScheduleStatus.error,
          message: e.toString(),
        ),
      );
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
    emit(
      state.copyWith(
        newSchedules: newSchedules,
        saveStatus: ScheduleStatus.initial,
      ),
    );
  }

  bool _hasChanges() {
    // Convertir ambas listas en mapas para facilitar la comparación
    final Map<String, ScheduleEntity> currentSchedulesMap =
        <String, ScheduleEntity>{
      for (final ScheduleEntity schedule in state.schedules)
        schedule.day: schedule
    };
    final Map<String, ScheduleEntity> newSchedulesMap =
        <String, ScheduleEntity>{
      for (final ScheduleEntity schedule in state.newSchedules)
        schedule.day: schedule
    };

    // Compara ambos mapas, detectando eliminaciones, adiciones y modificaciones
    if (currentSchedulesMap.keys.length != newSchedulesMap.keys.length) {
      return true; // Hay un cambio en la cantidad de días
    }

    for (final String day in currentSchedulesMap.keys) {
      final ScheduleEntity? newSchedule = newSchedulesMap[day];
      if (newSchedule == null ||
          newSchedule.openHour != currentSchedulesMap[day]?.openHour ||
          newSchedule.closeHour != currentSchedulesMap[day]?.closeHour) {
        return true;
      }
    }

    for (final String day in newSchedulesMap.keys) {
      if (!currentSchedulesMap.containsKey(day)) {
        return true; // Día añadido
      }
    }

    return false; // No hay diferencias
  }
}
