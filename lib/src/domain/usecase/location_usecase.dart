import 'package:location/location.dart';
import 'package:quickdrop_sellers/src/domain/repository/location_repository.dart';

class LocationUsecase {
  LocationUsecase({
    required LocationRepository repository,
  }) : _repository = repository;

  final LocationRepository _repository;

  Future<LocationData> getLocation() async {
    return _repository.getCurrentLocation();
  }
}
