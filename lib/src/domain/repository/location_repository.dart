import 'package:location/location.dart';

abstract class LocationRepository {
  Future<LocationData> getCurrentLocation();
}
