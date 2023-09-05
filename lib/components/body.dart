import 'package:flutter/material.dart';
import '../detalle_envio.dart';
import '../envios.dart';
import 'header_with_searchbox.dart';

class Body extends StatefulWidget {
  final List<Sale> envios;
  final String userName; // Agrega userName aquí

  const Body({
    required this.envios,
    required this.userName, // Añade userName al constructor
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState(
    userName: userName,
  );
}

class _BodyState extends State<Body> {
  final String userName;

  _BodyState({
    required this.userName,
  }); // Agrega este constructor
  // List<Sale> enviosFiltered = []; // Lista para almacenar los resultados filtrados
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // enviosFiltered = widget.envios; // Inicialmente, mostrar todos los envíos
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String newText) {
  newText = newText.toLowerCase();
  setState(() {
    widget.envios.where((envio) {
      final cliente = envio.cliente.toLowerCase();
      final noCotizacion = envio.noCotizacion.toLowerCase();
      final empleado = envio.empleado.toLowerCase();
      return cliente.contains(newText) ||
          noCotizacion.contains(newText) ||
          empleado.contains(newText);
    }).toList();
  });
}


  Color _getColorForStatus(String status) {
    if (status == "Por enviar") {
      return Colors.red;
    } else if (status == "En camino") {
      return Colors.deepOrange;
    } else if (status == "Devolución") {
      return Colors.purple;
    } else if (status == "Entregado") {
      return Colors.greenAccent;
    } else {
      return Colors.black;
    }
  } 
 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderWithSearchBox(
            size: size,
            onSearchTextChanged: _onSearchTextChanged,
            userName: userName,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.envios.length,
            itemBuilder: (BuildContext context, int index) {
              final statusColor = _getColorForStatus(widget.envios[index].estadoEnvio);
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
                        height: 100,
                        decoration: BoxDecoration(
                          color: statusColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'images/user.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.envios[index].cliente}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "No Cotización: ${widget.envios[index].noCotizacion}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Empleado: ${widget.envios[index].empleado}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Dirección: ${widget.envios[index].direccion}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Estado: ${widget.envios[index].estadoEnvio}",
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleEnvio(
                                cliente: widget.envios[index].cliente,
                                estado: widget.envios[index].estadoEnvio,
                                latitud: widget.envios[index].latitud,
                                longitud: widget.envios[index].longitud,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.remove_red_eye),
                        color: statusColor,
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