import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart'; // Asegúrate de importar url_launcher

class MapaDetalleEnvio extends StatefulWidget {
  final LatLng ubicacionDestino;

  MapaDetalleEnvio({required this.ubicacionDestino});

  @override
  _MapaDetalleEnvioState createState() => _MapaDetalleEnvioState();
}

class _MapaDetalleEnvioState extends State<MapaDetalleEnvio> {
  late Set<Polyline> _polylines;

  @override
  void initState() {
    super.initState();
    _polylines = {};
    _createPolylines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa de Envío"),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(6.193282302525567, -75.59139891409373), // Punto de partida fijo
          zoom: 13.0,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('start'),
            position: LatLng(6.193282302525567, -75.59139891409373),
            infoWindow: InfoWindow(title: 'Punto de partida'),
          ),
          Marker(
            markerId: const MarkerId('destination'),
            position: widget.ubicacionDestino,
            infoWindow: const InfoWindow(title: 'Destino'),
          ),
        },
        polylines: _polylines,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _openGoogleMaps(); // Llamar a la función aquí
        },
        label: Text('Abrir en Google Maps'),
        icon: Icon(Icons.directions),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _openGoogleMaps() async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=${widget.ubicacionDestino.latitude},${widget.ubicacionDestino.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir Google Maps';
    }
  }

  Future<void> _createPolylines() async {
    List<LatLng> routeCoordinates = await getRouteCoordinates(
      const LatLng(6.193282302525567, -75.59139891409373), // Punto de partida fijo
      widget.ubicacionDestino,
    );

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.blue,
          points: routeCoordinates,
        ),
      );
    });
  }

  Future<List<LatLng>> getRouteCoordinates(LatLng start, LatLng end) async {
    String apiKey = "AIzaSyBqaKSNGXi0v6IGv7MRnMOmjRjJFN1PfTg"; // Reemplaza con tu clave de API
    String url = "https://maps.googleapis.com/maps/api/directions/json" +
        "?origin=${start.latitude},${start.longitude}" +
        "&destination=${end.latitude},${end.longitude}" +
        "&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<LatLng> coordinates = [];

      data['routes'][0]['legs'][0]['steps'].forEach((step) {
        var points = step['polyline']['points'];
        coordinates.addAll(_decodePolyline(points));
      });

      return coordinates;
    } else {
      throw Exception("Failed to load route");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng p = LatLng(lat / 1E5, lng / 1E5);
      poly.add(p);
    }

    return poly;
  }
}

void main() {
  runApp(MaterialApp(
    home: MapaDetalleEnvio(
      ubicacionDestino: LatLng(6.2180, -75.5742), // Coordenadas de destino
    ),
  ));
}
