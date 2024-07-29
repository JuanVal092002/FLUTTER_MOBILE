import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> _registerUser(
    String nombre, String correo, String contrasenia, int edad) async {
  final url = Uri.parse('https://api-js-d8yf.onrender.com/api/user');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'nombre': nombre,
      'correo': correo,
      'contrasenia': contrasenia,
      'edad': edad,  
    }),
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to register user');
  }
}

class RegisterUserScreen extends StatelessWidget {
  final String txtNombres;
  final String txtEmail;
  final String txtPassword;
  final int txtEdad;  

  const RegisterUserScreen({
    Key? key,
    required this.txtNombres,
    required this.txtEmail,
    required this.txtPassword,
    required this.txtEdad,  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _registerUser(txtNombres, txtEmail, txtPassword, txtEdad), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Center(
              child: Text('User registered successfully'),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
