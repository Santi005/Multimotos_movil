import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatelessWidget {
  final String recoveryCode;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  ResetPasswordPage({required this.recoveryCode});


void _resetPassword(BuildContext context) async {
  final newPassword = _newPasswordController.text;
  final confirmPassword = _confirmPasswordController.text;

  if (newPassword != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Las contraseñas no coinciden'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  try {
    final response = await http.post(
      Uri.parse('https://02ce-181-133-128-113.ngrok-free.app/reset-password-code'),
      body: {
        'password': newPassword,
        'code' : recoveryCode,
        },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Contraseña restablecida con éxito'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Volver a la pantalla anterior
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error al restablecer la contraseña: ${response.body}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (error) {
    print('Error en la solicitud HTTP: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ocurrió un error al restablecer la contraseña. Inténtalo de nuevo más tarde.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restablecer Contraseña'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ingresa tu nueva contraseña $recoveryCode',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 250,
              child: TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nueva Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 250,
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar Nueva Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _resetPassword(context),
              child: Text('Restablecer Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
