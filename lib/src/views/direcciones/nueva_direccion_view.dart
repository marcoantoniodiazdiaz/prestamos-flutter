import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/functions/input_functions.dart';
import 'package:prestamos/src/provider/directions_provider.dart';
import 'package:prestamos/src/provider/providers.dart';

class NewDirectionView extends StatelessWidget {
  final ClientsModel clientsModel;

  const NewDirectionView({required this.clientsModel});

  @override
  Widget build(BuildContext context) {
    final directionsProvider = Provider.of<DirectionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Nueva dirección para ${clientsModel.name}', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: directionsProvider.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Map(),
              SizedBox(height: 7.5),
              DesignText(
                'Latitud: ${directionsProvider.getTarget().latitude.toStringAsFixed(3)}, Longitud: ${directionsProvider.getTarget().longitude.toStringAsFixed(3)}',
                fontSize: 13,
                color: Colors.black54,
                fontStyle: FontStyle.italic,
              ),
              SizedBox(height: 20),
              DesignInput(
                hintText: 'Calle',
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onChanged: (v) => directionsProvider.street = v,
                validator: InputFunctions.regexValidator(onRegexError: 'Calle invalida', localValidators: LocalValidators.notEmpty),
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Colonia',
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onChanged: (v) => directionsProvider.suburb = v,
                validator: InputFunctions.regexValidator(onRegexError: 'Colonia invalida', localValidators: LocalValidators.notEmpty),
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Ciudad',
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onChanged: (v) => directionsProvider.city = v,
                validator: InputFunctions.regexValidator(onRegexError: 'Ciudad invalida', localValidators: LocalValidators.notEmpty),
              ),
              SizedBox(height: 20),
              DesignTextButton(
                width: double.infinity,
                height: 50,
                child: DesignText('Guardar dirección'),
                color: DesignColors.pink,
                primary: Colors.white,
                onPressed: () => directionsProvider.upload(clientsModel.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final directionsProvider = Provider.of<DirectionsProvider>(context);
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(20.34, -102.77),
                zoom: 5,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onCameraMove: (v) {
                directionsProvider.cameraPosition = v;
              },
              onMapCreated: directionsProvider.setMapController,
            ),
          ),
          Center(child: Transform.translate(offset: Offset(0, -12), child: Icon(FeatherIcons.mapPin))),
        ],
      ),
    );
  }
}
