import 'package:flutter/material.dart';
import 'package:mutlimotos_movil/olvidemicontrasena.dart'; 

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

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Llamada a la API para autenticación
    final response = await http.post(
      Uri.parse('https://fda3-2800-e2-9600-1b5-1c0f-f934-84b2-59c6.ngrok.io/auth/login'),
      body: {'correo': email, 'Contrasena': password},
    );

    if (response.statusCode == 200) {
      setState(() {
        _message = 'Inicio de sesión exitoso';
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Envios()),
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
          Column(
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
            ],
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
