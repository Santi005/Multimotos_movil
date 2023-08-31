// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:http/http.dart' as http;
// import 'package:mutlimotos_movil/components/body.dart';
// import 'dart:convert';


// import 'detalle_envio.dart';

// class Sale {
//   final String cliente;
//   final String noCotizacion;
//   final String empleado;
//   final String estadoEnvio;
//   final String latitud;
//   final String longitud;
//   final String direccion;

//   Sale({
//     required this.cliente,
//     required this.noCotizacion,
//     required this.empleado,
//     required this.estadoEnvio,
//     required this.latitud,
//     required this.longitud,
//     required this.direccion,
//   });
// }

// class Envios extends StatefulWidget {
//   const Envios({Key? key}) : super(key: key);

//   @override
//   State<Envios> createState() => _EnviosState();
// }

// class _EnviosState extends State<Envios> {
//   List<Sale> envios = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchSales();
//   }

//   void fetchSales() async {
//     final response = await http.get(Uri.parse('https://278b-181-133-128-113.ngrok-free.app/sales/'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);

//       final List<Sale> sales = jsonData.map((data) {
//         return Sale(
//           cliente: data['Cliente'][0],
//           noCotizacion: data['Factura'],
//           empleado: data['Empleado'],
//           estadoEnvio: data['EstadoEnvio'],
//           latitud: data['Cliente'][6],
//           longitud: data['Cliente'][7],
//           direccion: data['Cliente'][2],
//         );
//       }).toList();

//       setState(() {
//         envios = sales;
//       });
//     } else {
//       print('Error en la solicitud a la API: ${response.statusCode}');
//     }
//   }

//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey, // Asigna la clave aquí
//       appBar: buildAppBar(),
//       drawer: CustomDrawer(),
//       body: Body(envios: envios),
//     );
//   }

//   AppBar buildAppBar() {
//     return AppBar(
//       elevation: 0,
//       leading: IconButton(
//         icon: SvgPicture.asset('icons/menu.svg'), 
//         onPressed: () {
//           // Abre el menú hamburguesa usando ScaffoldMessenger
//           _scaffoldKey.currentState?.openDrawer();
//         },
//       ),
//     );
//   }
// }
// class CustomDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.red,
//             ),
//             child: Text(
//               'Menú',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             title: Text('Mis Pedidos'),
//             onTap: () {
//               // Agrega la lógica para abrir la pantalla de tus pedidos aquí
//             },
//           ),
//           ListTile(
//             title: Text('Cerrar Sesión'),
//             onTap: () {
//               // Agrega la lógica para cerrar sesión aquí
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
