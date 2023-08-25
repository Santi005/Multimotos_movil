import 'package:flutter/material.dart';
import 'package:mutlimotos_movil/envios.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          const SizedBox(height: 0,),

          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Envios(), ),);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(0, 1, 1, 1),
              padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              )
            ),
            child: const Text("Envios")
          ),
        ],
      ),
    );
  }
}