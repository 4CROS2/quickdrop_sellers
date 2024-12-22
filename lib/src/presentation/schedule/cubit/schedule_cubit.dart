import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/schedule_usecase.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit({required ScheduleUsecase usecase})
      : _usecase = usecase,
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
      _emitError(message: e.toString());
    }
  }

  Future<void> saveSchedules() async {
    emit(
      state.copyWith(
        saveStatus: ScheduleStatus.initial,
      ),
    );
    if (!hasChanges()) {
      _emitError(
        message: 'No hay cambios para guardar',
        saveStatus: true,
      );
      return;
    }

    emit(
      state.copyWith(
        saveStatus: ScheduleStatus.loading,
      ),
    );

    try {
      final String response =
          await _usecase.saveSchedules(schedules: state.newSchedules);
      emit(state.copyWith(
        saveStatus: ScheduleStatus.success,
        schedules: state.newSchedules,
        message: response,
      ));
    } catch (e) {
      _emitError(
        message: e.toString(),
        saveStatus: true,
      );
    } finally {
      emit(
        state.copyWith(
          saveStatus: ScheduleStatus.initial,
        ),
      );
    }
  }

  void updateSchedule({required String day, ScheduleEntity? schedule}) {
    final List<ScheduleEntity> newSchedules =
        List<ScheduleEntity>.from(state.newSchedules);

    if (schedule == null) {
      // Eliminar el horario del día
      newSchedules.removeWhere((ScheduleEntity element) => element.day == day);
    } else if (!schedule.isEmpty) {
      // Actualizar o añadir el horario
      final int index = newSchedules
          .indexWhere((ScheduleEntity element) => element.day == day);
      index != -1 ? newSchedules[index] = schedule : newSchedules.add(schedule);
    }

    emit(state.copyWith(
        newSchedules: newSchedules, saveStatus: ScheduleStatus.initial));
  }

  bool hasChanges() {
    final Map<String, ScheduleEntity> currentMap =
        _toScheduleMap(state.schedules);
    final Map<String, ScheduleEntity> newMap =
        _toScheduleMap(state.newSchedules);

    // Verificar diferencias en días o cambios en horarios
    if (currentMap.keys.length != newMap.keys.length) {
      return true;
    }

    for (final String day in currentMap.keys) {
      final ScheduleEntity? current = currentMap[day];
      final ScheduleEntity? updated = newMap[day];
      if (updated == null ||
          current!.openHour != updated.openHour ||
          current.closeHour != updated.closeHour) {
        return true;
      }
    }
    return false;
  }

  Map<String, ScheduleEntity> _toScheduleMap(List<ScheduleEntity> schedules) {
    return <String, ScheduleEntity>{
      for (final ScheduleEntity schedule in schedules) schedule.day: schedule
    };
  }

  void _emitError({required String message, bool saveStatus = false}) {
    emit(state.copyWith(
      message: message,
      saveStatus: saveStatus ? ScheduleStatus.error : state.saveStatus,
      status: saveStatus ? state.status : ScheduleStatus.error,
    ));
  }
}
