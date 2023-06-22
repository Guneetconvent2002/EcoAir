import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
    } catch (e) {
      print('Error while getting location: $e');
    }

    return position;
  }

  Future<String> getCityName(Position position) async {
    String cityName = '';

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        cityName = placemarks[0].locality ?? '';
      }
    } catch (e) {
      print('Error while getting city name: $e');
    }

    return cityName;
  }
}
