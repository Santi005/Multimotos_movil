import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mutlimotos_movil/restablecercontrasena.dart'; 

class RecoveryCodePage extends StatelessWidget {
  final String email;
  RecoveryCodePage({required this.email});
  final TextEditingController _recoveryCodeController = TextEditingController();

  void _verifyRecoveryCode(BuildContext context) async {
    final recoveryCode = _recoveryCodeController.text;

    final response = await http.post(
      Uri.parse('https://02ce-181-133-128-113.ngrok-free.app/verify-recovery-code'), // Cambia la URL a tu servidor
      body: {
        'code': recoveryCode,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      // Código válido, navegar a la vista de restablecimiento de contraseña
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordPage(recoveryCode: _recoveryCodeController.text)), // Cambia a la vista de restablecimiento de contraseña
      );
    } else {
      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código de recuperación inválido'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar Código de Recuperación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ingresa el código que te hemos enviado al correo: $email',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 250,
              child: TextField(
                controller: _recoveryCodeController,
                decoration: InputDecoration(
                  labelText: 'Código de Recuperación',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _verifyRecoveryCode(context),
              child: Text('Verificar Código'),
            ),
          ],
        ),
      ),
    );
  }
}
