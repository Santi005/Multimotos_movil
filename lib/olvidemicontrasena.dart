import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mutlimotos_movil/codigo.dart'; 

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _emailSent = false;
  String _errorMessage = ''; // Nuevo campo para el mensaje de error
  String _recoveryEmail = '';

  void _requestPasswordRecovery(BuildContext context) async {
    final email = _emailController.text;

    final response = await http.post(
      Uri.parse('https://94e0-181-133-128-113.ngrok-free.app/request-password-recovery'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      setState(() {
        _emailSent = true;
        _errorMessage = ''; // Reiniciar el mensaje de error
        _recoveryEmail = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RecoveryCodePage(email: _emailController.text)),
      );
    } else if (response.statusCode == 404) {
      setState(() {
        _emailSent = false;
        _errorMessage = 'El correo electrónico no está registrado.'; // Actualizar el mensaje de error
        _recoveryEmail = email;
      });
    } else {
      // Mostrar mensaje de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ingresa tu correo para recuperar tu contraseña',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 250,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            if (_emailSent)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Se ha enviado un correo electrónico con el enlace de recuperación.',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            if (_errorMessage.isNotEmpty) // Mostrar el mensaje de error si no está vacío
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _requestPasswordRecovery(context),
              child: Text('Recuperar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
