import 'package:flutter/material.dart';
import '../detalle_envio.dart';
import '../envios.dart';
import 'header_with_searchbox.dart';

class Body extends StatelessWidget {
  final List<Sale> envios;
  
  Color _getColorForStatus(String status) {
    if (status == "Por enviar") {
      return Colors.orange;
    } else if (status == "En camino") {
      return Colors.green;
    } else if (status == "Devolución") {
      return Colors.red;
    } else if (status == "Entregado") {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  } // Agrega esta línea

  const Body({required this.envios, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          ListView.separated(
            shrinkWrap: true, // Added this line to prevent list from taking full height
            itemCount: envios.length, // Use the length of the envios list
            separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
            itemBuilder: (BuildContext context, int index) {
              final statusColor = _getColorForStatus(envios[index].estadoEnvio);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        height: 60,
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${envios[index].cliente}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "No Cotización: ${envios[index].noCotizacion}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Empleado: ${envios[index].empleado}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Estado: ${envios[index].estadoEnvio}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Dirección: ${envios[index].direccion}",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleEnvio(
                                cliente: envios[index].cliente,
                                estado: envios[index].estadoEnvio,
                                direccion: envios[index].direccion,
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.more_horiz, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}