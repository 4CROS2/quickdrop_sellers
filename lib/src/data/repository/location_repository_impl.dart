import 'package:location/location.dart';
import 'package:quickdrop_sellers/src/data/datasource/location_datasource.dart';
import 'package:quickdrop_sellers/src/domain/repository/location_repository.dart';

class ILocationRepository extends LocationRepository {
  ILocationRepository({required LocationDatasource datasource})
      : _datasource = datasource;
  final LocationDatasource _datasource;

  @override
  Future<LocationData> getCurrentLocation() async {
    try {
      return await _datasource.getCurrentLocation()!;
    } catch (e) {
      rethrow;
    }
  }
}
