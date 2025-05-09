import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentPosition() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception("Location permissions are denied.");
    }

    return Geolocator.getCurrentPosition();
  }
}
