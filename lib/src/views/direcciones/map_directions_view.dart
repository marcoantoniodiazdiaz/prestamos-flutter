import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/directions_model.dart';

class MapDirectionsView extends StatelessWidget {
  final DirectionsModel model;

  const MapDirectionsView({required this.model});
  @override
  Widget build(BuildContext context) {
    final marker = Marker(markerId: MarkerId(model.id.toString()), position: LatLng(model.latitude, model.longitude));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: DesignText('Dirección seleccionada', color: Colors.black),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(model.latitude, model.longitude),
          zoom: 15,
        ),
        markers: {marker},
        onMapCreated: (controller) {
          controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(model.latitude, model.longitude), 16));
        },
      ),
    );
  }
}
