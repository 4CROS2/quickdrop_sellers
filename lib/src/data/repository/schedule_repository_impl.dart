import 'package:quickdrop_sellers/src/data/datasource/schedule_datasource.dart';
import 'package:quickdrop_sellers/src/data/model/schedule_model.dart';
import 'package:quickdrop_sellers/src/domain/entity/schedule_entity.dart';
import 'package:quickdrop_sellers/src/domain/repository/schedule_repository.dart';

class IScheduleRepository implements ScheduleRepository {
  IScheduleRepository({
    required ScheduleDatasource datasource,
  }) : _datasource = datasource;

  final ScheduleDatasource _datasource;

  @override
  Future<List<ScheduleEntity>> getSchedules() async {
    final Map<String, dynamic> response = await _datasource.getSchedules();
    if (response.isEmpty) {
      return <ScheduleEntity>[];
    }
    return response.entries.map<ScheduleEntity>((
      MapEntry<String, dynamic> entry,
    ) {
      return ScheduleModel.fromJson(json: <String, dynamic>{
        'day': entry.key,
        ...entry.value,
      });
    }).toList();
  }

  @override
  Future<void> saveSchedules({required List<ScheduleEntity> schedules}) {
    throw UnimplementedError();
  }
}
