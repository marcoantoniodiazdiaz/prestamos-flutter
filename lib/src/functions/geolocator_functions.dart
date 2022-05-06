import 'package:geolocator/geolocator.dart';

class GeolocatorFunctions {
  static Future<Position> medium() async {
    await Geolocator.requestPermission();
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  }

  static Future<Position> best() async {
    await Geolocator.requestPermission();
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
