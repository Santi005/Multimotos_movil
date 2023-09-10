import 'package:flutter/material.dart';
import 'package:mutlimotos_movil/olvidemicontrasena.dart'; 

import 'dart:convert'; // Importa la biblioteca para trabajar con JSON


import 'user_model.dart';

import 'package:mutlimotos_movil/envios.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _message = '';

void _login() async {
  String email = _emailController.text;
  String password = _passwordController.text;

  // Llamada a la API para autenticación
  final response = await http.post(
    Uri.parse('https://fa2a-181-133-128-113.ngrok-free.app/auth/login'),
    body: {'correo': email, 'Contrasena': password},
  );

  print('Response status code: ${response.statusCode}'); 

  print('Response JSON: ${response.body}');


  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    // Extrae el token de autenticación
    final token = responseData['token'];
    print('Token obtenido: $token');


    // Extrae los datos del usuario de la respuesta JSON
    final userData = responseData['user'];
    print(userData);
    final user = User(
      id: userData['_id'],
      documento: userData['Documento'],
      nombre: userData['Nombre'],
      apellidos: userData['Apellidos'],
      correo: userData['Correo'],
      rolNombre: userData['Rol']['nombre']
    );

    setState(() {
      _message = 'Inicio de sesión exitoso';
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Envios(user: user)), // Pasa el objeto 'user' a la siguiente pantalla
    );
  } else {
    setState(() {
      _message = 'Credenciales incorrectas. Inténtalo de nuevo.';
    });
  }
}



  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/fondo.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                // Resto de tus elementos de inicio de sesión aquí
              ],
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                width: 325,
                child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Iniciar Sesión', // Agrega el texto aquí
                style: TextStyle(
                  fontSize: 24.0, // Tamaño de fuente personalizable
                  fontWeight: FontWeight.bold, // Puedes ajustar el peso de la fuente
                ),
              ),
              SizedBox(height: 16.0), // Espacio entre el texto y el logo
              Image.asset(
                'images/logoMultimotos.png',
                width: 150,
                height: 150,
              ),
                        SizedBox(height: 24.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Correo Electrónico',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _navigateToForgotPassword,
                            child: Text(
                              'Olvidé mi contraseña',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            textStyle: TextStyle(fontSize: 18.0),
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text('Iniciar Sesión'),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(_message, style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
