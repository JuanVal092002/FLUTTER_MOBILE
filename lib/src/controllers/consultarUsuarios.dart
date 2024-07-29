import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<Users>> consultarUsuarios() async {
  final response =
      await http.get(Uri.parse('https://api-js-d8yf.onrender.com/api/user'));
  if (response.statusCode == 200) {
    List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => Users.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load jewelry products');
  }
}

class Users {
  final String nombre;
  final int edad;
  final String correo;

  const Users({
    required this.nombre,
    required this.edad,
    required this.correo,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      nombre: json['nombre'] ?? '', 
      edad: json['edad'] ?? 0, 
      correo: json['correo'] ?? '', 
    );
  }
}
