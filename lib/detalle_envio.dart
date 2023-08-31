import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mapa.dart';

class DetalleEnvio extends StatefulWidget {
  final String cliente;
  final String estado;
  final String latitud;
  final String longitud;

  DetalleEnvio({required this.cliente, required this.estado, required this.latitud, required this.longitud});

  @override
  State<DetalleEnvio> createState() => _DetalleEnvioState();
}

class _DetalleEnvioState extends State<DetalleEnvio> {
  Color getColorForEstado(String estado) {
    switch (estado) {
      case "Por enviar":
        return Colors.red;
      case "En camino":
        return Colors.orange;
      case "Devolución":
        return Colors.purple;
      case "Entregado":
        return Colors.greenAccent;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {

    Color estadoColor = getColorForEstado(widget.estado);
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFfdee7fa),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight/3,
            child: Container(
              color: estadoColor,
            )
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back), 
                onPressed: () {
                  Navigator.pop(context);
                },
              ),


            )
          ),
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight*0.2,
            height: screenHeight*0.36,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,

              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight*0.1,),
                  Text(
                    widget.cliente,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Estado: ${widget.estado}",

                    style: TextStyle(
                      fontSize: 15,
                      color: estadoColor
                    ),
                  ),

                  if (widget.estado == "Por enviar")
                    ElevatedButton(
                      onPressed: () {
                        // Botón para Enviar
                      },
                      child: const Text("Enviar"),
                    ),
                  if (widget.estado == "Por enviar")
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapaDetalleEnvio(
                              ubicacionDestino: LatLng(double.parse(widget.latitud), double.parse(widget.longitud)), // Coordenadas obtenidas del envío
                            ),
                          ),
                        );
                      },
                      child: const Text("Ver mapa"),
                    ),
                  if (widget.estado == "En camino")
                    ElevatedButton(
                      onPressed: () {
                        // Botón para Confirmar entrega
                      },
                      child: const Text("Confirmar entrega"),
                    ),
                  if (widget.estado == "En camino")
                    ElevatedButton(
                      onPressed: () {
                        // Botón para Marcar devolución
                      },
                      child: const Text("Marcar Devolución"),
                    ),
                  if (widget.estado == "En camino")
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapaDetalleEnvio(
                              ubicacionDestino: LatLng(double.parse(widget.latitud), double.parse(widget.longitud)), // Coordenadas obtenidas del envío
                            ),
                          ),
                        );
                      },
                      child: const Text("Ver mapa"),
                    ),
                  if (widget.estado == "Devolución")
                    ElevatedButton(
                      onPressed: () {
                        // Botón para Ver razón devolución
                      },
                      child: const Text("Ver razón devolución"),
                    ),
                  if (widget.estado == "Devolución")
                    ElevatedButton(
                      onPressed: () {
                        // Botón para Reenviar
                      },
                      child: const Text("Reenviar"),
                    ),
                ],
              ),
            )
          ),
          Positioned(
            top: screenHeight*0.12,
            left: (screenWidth-150)/2,
            right: (screenWidth-150)/2,
            height: screenHeight*0.16,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('images/logoMultimotos.png'),
                  )
                ),
              ),
            ) 
          )
        ],
      ),






      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () {
      //       Navigator.pop(context); // Agrega acción de retroceso
      //     },
      //   ),
      //   title: const Text(
      //     "Detalle de Envío",
      //     style: TextStyle(
      //       fontSize: 18, // Tamaño de fuente igual al de la lista de envíos
      //     ),
      //   ),
      //   elevation: 0, // Elimina la sombra del AppBar
      // ),
      // body: Stack(
      //   children: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         const SizedBox(height: 120), // Espacio para la barra superpuesta
      //         Expanded(
      //           child: Container(
      //             padding: const EdgeInsets.all(20),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 const CircleAvatar(
      //                   radius: 50,
      //                   backgroundImage: AssetImage("images/logoMultimotos.png"), // Agrega la ruta de la imagen
      //                 ),
      //                 const SizedBox(height: 1),
      //                 Text(
      //                   widget.cliente,
      //                   style: const TextStyle(
      //                     fontSize: 24,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 const SizedBox(height: 5),
      //                 Text(
      //                   "Estado: ${widget.estado}",
      //                   style: TextStyle(
      //                     fontSize: 18,
      //                     color: estadoColor, // Usa el color según el estado
      //                   ),
      //                 ),
      //                 const SizedBox(height: 90),
      //                 // Agrega aquí los botones según el estado
      //                 if (widget.estado == "Por enviar")
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // Acción para Enviar
      //                     },
      //                     child: const Text("Enviar"),
      //                   ),
      //                 if (widget.estado == "Por enviar")
      //                     ElevatedButton(
      //                       onPressed: () {
      //                         Navigator.push(
      //                           context,
      //                           MaterialPageRoute(
      //                             builder: (context) => MapaDetalleEnvio(
      //                               ubicacionDestino: LatLng(double.parse(widget.latitud), double.parse(widget.longitud)), // Coordenadas obtenidas del envío
      //                             ),
      //                           ),
      //                         );
      //                       },
      //                       child: const Text("Ver mapa"),
      //                     ),
      //                 if (widget.estado == "En camino")
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // Acción para Confirmar entrega
      //                     },
      //                     child: const Text("Confirmar entrega"),
      //                   ),
      //                 if (widget.estado == "En camino")
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // Acción para Marcar devolución
      //                     },
      //                     child: const Text("Marcar Devolución"),
      //                   ),
      //                 if (widget.estado == "En camino")
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // Acción para Ver mapa
      //                     },
      //                     child: const Text("Ver mapa"),
      //                   ),
      //                 if (widget.estado == "Devolución")
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // Acción para Ver razón devolución
      //                     },
      //                     child: const Text("Ver razón devolución"),
      //                   ),
      //                 if (widget.estado == "Devolución")
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       // Acción para Reenviar
      //                     },
      //                     child: const Text("Reenviar"),
      //                   ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}