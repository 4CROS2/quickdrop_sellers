import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/schedule_repository.dart';

class ScheduleUsecase {
  ScheduleUsecase({
    required ScheduleRepository repository,
  }) : _repository = repository;

  final ScheduleRepository _repository;

  Future<List<ScheduleEntity>> getSchedules() => _repository.getSchedules();

  Future<String> saveSchedules({required List<ScheduleEntity> schedules}) =>
      _repository.saveSchedules(schedules: schedules);
}
