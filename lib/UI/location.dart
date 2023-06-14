import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class DeviceLocation {
  final double latitude;
  final double longitude;
  final String city;
  final String state;

  DeviceLocation({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.state,
  });

  static Future<DeviceLocation> getCurrentLocation() async {
    // Get the device's current location.
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get the city and state from the device's location.
    String city = await Geocoder.local.getAddressFromLocation(
      position.latitude,
      position.longitude,
    );
    String state = city.split(',')[1];

    // Return a new DeviceLocation object.
    return DeviceLocation(
      latitude: position.latitude,
      longitude: position.longitude,
      city: city,
      state: state,
    );
  }

  String get cityName => city;

  String get stateName => state;
}
