import 'package:location/location.dart';

sealed class LocationDatasource {
  Future<LocationData>? getCurrentLocation();
}

class LocationDatasourceImpl implements LocationDatasource {
  final Location _location = Location();

  @override
  Future<LocationData>? getCurrentLocation() async {
    try {
      final PermissionStatus response = await _location.requestPermission();
      if (response != PermissionStatus.granted) {
        throw Exception('permiso de GPS no permitido');
      }

      return await _getCurrentLocation();
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationData> _getCurrentLocation() async {
    final LocationData locationData = await _location.getLocation();
    return locationData;
  }
}
