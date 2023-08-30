import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaDetalleEnvio extends StatelessWidget {
  final LatLng ubicacion;

  MapaDetalleEnvio({required this.ubicacion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa de Envío"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: ubicacion,
          zoom: 15,
        ),
        markers: Set.from([
          Marker(
            markerId: MarkerId('${ubicacion.latitude}-${ubicacion.longitude}'),
            position: ubicacion,
          ),
        ]),
      ),
    );
  }
}