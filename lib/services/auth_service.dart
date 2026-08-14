import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // URL base de tu API en XAMPP
  // Nota: Si corres en emulador Android se usa 'http://10.0.2.2/barber_knight_api/', 
  // pero para Flutter Web / Chrome usamos 'http://localhost/barber_knight_api/'
  static const String baseUrl = 'http://localhost/barber_knight_api';

  // Método para registrar usuario
  static Future<Map<String, dynamic>> registrarUsuario({
    required String nombre,
    required String apellido,
    required String telefono,
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/registro.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nombre': nombre,
          'apellido': apellido,
          'telefono': telefono,
          'correo': correo,
          'password': password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'estado': 'error', 'mensaje': 'Error de conexión con el servidor: $e'};
    }
  }

  // Método para iniciar sesión
  static Future<Map<String, dynamic>> loginUsuario({
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'correo': correo,
          'password': password,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'estado': 'error', 'mensaje': 'Error de conexión con el servidor: $e'};
    }
  }
}