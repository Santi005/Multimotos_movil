import 'package:flutter/material.dart';
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

      // Navegar a la página HomePage después del inicio de sesión exitoso
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Image.asset('images/logoMultimotos.png',
                width: 200,
                height: 200,
              ),

            ],
          ),

          SizedBox(height: 50),

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

