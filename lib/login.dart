import 'package:flutter/material.dart';
import 'package:mutlimotos_movil/start_page.dart'; // Importa el paquete http para hacer peticiones HTTP
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
        primarySwatch: Colors.blue,
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
      Uri.parse('http://localhost:8080/auth/login'),
      body: {'correo': email, 'Contrasena': password},
    );

    if (response.statusCode == 200) {
      setState(() {
        _message = 'Inicio de sesión exitoso';
      });

      // Navegar a la página HomePage después del inicio de sesión exitoso
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    } else {
      setState(() {
        _message = 'Credenciales incorrectas. Inténtalo de nuevo.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
              SizedBox(height: 8.0),
              Text(_message, style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}

