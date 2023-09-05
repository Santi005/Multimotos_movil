import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:mutlimotos_movil/components/body.dart';
import 'package:mutlimotos_movil/login.dart';
import 'dart:convert';

import 'user_model.dart';

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
  final User user; 

  const Envios({required this.user, Key? key}) : super(key: key);

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
    final response = await http.get(Uri.parse('https://94e0-181-133-128-113.ngrok-free.app/sales/'));
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

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(),
      drawer: CustomDrawer(),
      body: Body(
        envios: envios,
        userName: widget.user.nombre, // Pasa el nombre del usuario a Body
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('icons/menu.svg'), 
        onPressed: () {
          // Abre el menú hamburguesa usando ScaffoldMessenger
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      
    );
  }
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Text('Mis Pedidos'),
            onTap: () {
              
            },
          ),

          ListTile(
            title: Text('Cerrar Sesión'),
            onTap: () {
              // Muestra un modal de confirmación
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Cerrar Sesión'),
                    content: Text('¿Seguro que quieres cerrar sesión?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop(); 
                        },
                      ),
                      TextButton(
                        child: Text('Sí'),
                        onPressed: () {
                          Navigator.of(context).pop(); 
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage())
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            leading: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}