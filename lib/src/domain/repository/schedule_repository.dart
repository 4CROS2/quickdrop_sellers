import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleEntity>> getSchedules();

  Future<String> saveSchedules({required List<ScheduleEntity> schedules});
}
