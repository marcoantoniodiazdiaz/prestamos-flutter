import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prestamos/src/database/directions_database.dart';
import 'package:prestamos/src/functions/geolocator_functions.dart';
import 'package:prestamos/src/functions/input_functions.dart';

class DirectionsProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late String street, suburb, city;

  CameraPosition? _cameraPosition;
  CameraPosition? get cameraPosition => _cameraPosition;
  set cameraPosition(CameraPosition? camera) {
    _cameraPosition = camera;
    notifyListeners();
  }

  GoogleMapController? _googleMapController;
  GoogleMapController? get googleMapController => _googleMapController;

  setMapController(GoogleMapController controller) {
    _googleMapController = controller;
    initMap();
  }

  initMap() async {
    final location = await GeolocatorFunctions.medium();
    _googleMapController!.animateCamera(CameraUpdate.newLatLngZoom(LatLng(location.latitude, location.longitude), 16));
    notifyListeners();
  }

  LatLng getTarget() {
    if (_cameraPosition == null) {
      return LatLng(0, 0);
    }
    return _cameraPosition!.target;
  }

  Future<bool> delete(int id) async {
    final resp = await DirectionsDatabase.delete(id);

    if (resp) {
      notifyListeners();
    }

    return resp;
  }

  upload(int clientId) async {
    if (!InputFunctions.validate(formKey)) return;
    if (getTarget().latitude == 0 || getTarget().longitude == 0) return;

    final data = {
      'street': street,
      'suburb': suburb,
      'city': city,
      'latitude': getTarget().latitude,
      'longitude': getTarget().longitude,
      'clientId': clientId,
    };

    final resp = await DirectionsDatabase.post(data);
    if (resp) {
      formKey.currentState!.reset();
      notifyListeners();
    }
  }
}
