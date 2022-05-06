import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';

class MapView extends StatelessWidget {
  final PaymentsModel model;

  const MapView({required this.model});
  @override
  Widget build(BuildContext context) {
    final separated = model.location.split(',');
    final latitude = double.parse(separated[0]);
    final longitude = double.parse(separated[1]);

    final marker = Marker(markerId: MarkerId(model.id.toString()), position: LatLng(latitude, longitude));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: DesignText('${model.user.name} [\$${model.transaction.amount.toStringAsFixed(2)}]', color: Colors.black),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {marker},
      ),
    );
  }
}
