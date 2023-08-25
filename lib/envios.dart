import 'package:flutter/material.dart';
import 'package:mutlimotos_movil/envios_list.dart';

class Envios extends StatefulWidget {
  const Envios({super.key});

  @override
  State<Envios> createState() => _EnviosState();
}

class _EnviosState extends State<Envios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Envios"),
        backgroundColor: Colors.red,
      ),
      body: 
      ListView.separated(
        itemCount: envios.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                
                Column(
                  children: [
                    Text("${envios[index]['Cliente']}" ,
                    style: const TextStyle(
                    color:Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    ) ,),

                    Text("${envios[index]['No Cotización']}" ,
                    style: const TextStyle(
                    color:Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    ) ,),

                    Text("${envios[index]['Empleado']}" ,
                    style: const TextStyle(
                    color:Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    ) ,),

                    Text("${envios[index]['Estado del envio']}" ,
                    style: const TextStyle(
                    color:Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    ) ,),
                  ],
                ),

                Column(
                  children: [
                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(
                        Icons.local_shipping, 
                        color: Colors.red,
                        size: 24.0,
                      )
                    ),

                    IconButton(
                      onPressed: (){}, 
                      icon: const Icon(
                        Icons.location_on_sharp, 
                        color: Colors.red,
                        size: 24.0,
                      )
                    )
                  ],
                )

              ],
            ),
          );
        }
      )
    );
  }
}