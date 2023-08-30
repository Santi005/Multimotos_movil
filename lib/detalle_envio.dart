import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mapa.dart';

class DetalleEnvio extends StatelessWidget {
  final String cliente;
  final String estado;
  final String direccion;

  DetalleEnvio({required this.cliente, required this.estado, required this.direccion});

  Color getColorForEstado(String estado) {
    switch (estado) {
      case "Por enviar":
        return Colors.blue;
      case "En camino":
        return Colors.orange;
      case "Devolución":
        return Colors.red;
      case "Entregado":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {

    Color estadoColor = getColorForEstado(estado);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Agrega acción de retroceso
          },
        ),
        title: const Text(
          "Detalle de Envío",
          style: TextStyle(
            fontSize: 18, // Tamaño de fuente igual al de la lista de envíos
          ),
        ),
        elevation: 0, // Elimina la sombra del AppBar
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 120), // Espacio para la barra superpuesta
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("images/logoMultimotos.png"), // Agrega la ruta de la imagen
                      ),
                      const SizedBox(height: 1),
                      Text(
                        cliente,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Estado: $estado",
                        style: TextStyle(
                          fontSize: 18,
                          color: estadoColor, // Usa el color según el estado
                        ),
                      ),
                      const SizedBox(height: 90),
                      // Agrega aquí los botones según el estado
                      if (estado == "Por enviar")
                        ElevatedButton(
                          onPressed: () {
                            // Acción para Enviar
                          },
                          child: const Text("Enviar"),
                        ),
                      if (estado == "Por enviar")
                        if (estado == "Por enviar")
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapaDetalleEnvio(
                                    ubicacion: LatLng(6.34501665, -75.5391948900531), // Coordenadas válidas
                                  ),
                                ),
                              );
                            },
                            child: const Text("Ver mapa"),
                          ),
                      if (estado == "En camino")
                        ElevatedButton(
                          onPressed: () {
                            // Acción para Confirmar entrega
                          },
                          child: const Text("Confirmar entrega"),
                        ),
                      if (estado == "En camino")
                        ElevatedButton(
                          onPressed: () {
                            // Acción para Marcar devolución
                          },
                          child: const Text("Marcar Devolución"),
                        ),
                      if (estado == "En camino")
                        ElevatedButton(
                          onPressed: () {
                            // Acción para Ver mapa
                          },
                          child: const Text("Ver mapa"),
                        ),
                      if (estado == "Devolución")
                        ElevatedButton(
                          onPressed: () {
                            // Acción para Ver razón devolución
                          },
                          child: const Text("Ver razón devolución"),
                        ),
                      if (estado == "Devolución")
                        ElevatedButton(
                          onPressed: () {
                            // Acción para Reenviar
                          },
                          child: const Text("Reenviar"),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}