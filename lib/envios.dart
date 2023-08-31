import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:mutlimotos_movil/components/body.dart';
import 'dart:convert';

import 'detalle_envio.dart';

class Sale {
  final String cliente;
  final String noCotizacion;
  final String empleado;
  final String estadoEnvio;
  final String latitud;
  final String longitud;
  final String direccion;

  Sale({
    required this.cliente,
    required this.noCotizacion,
    required this.empleado,
    required this.estadoEnvio,
    required this.latitud,
    required this.longitud,
    required this.direccion,
  });
}

class Envios extends StatefulWidget {
  const Envios({super.key});

  @override
  State<Envios> createState() => _EnviosState();
}

class _EnviosState extends State<Envios> {
  List<Sale> envios = [];

  @override
  void initState() {
    super.initState();
    fetchSales();
  }

  void fetchSales() async {
    final response = await http.get(Uri.parse('https://e51f-2800-e2-9600-1b5-e492-e7f8-9938-5671.ngrok.io/sales/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      final List<Sale> sales = jsonData.map((data) {
        return Sale(
          cliente: data['Cliente'][0],
          noCotizacion: data['Factura'],
          empleado: data['Empleado'],
          estadoEnvio: data['EstadoEnvio'],
          latitud: data['Cliente'][6],
          longitud: data['Cliente'][7],
          direccion: data['Cliente'][2],
        );
      }).toList();

      setState(() {
        envios = sales;
      });
    } else {
      print('Error en la solicitud a la API: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(envios: envios),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('icons/menu.svg'), 
        onPressed: () {},
      ),
    );
  }
}