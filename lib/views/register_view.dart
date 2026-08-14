import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../core/app_colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 void _registrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      // Mostrar indicador de carga opcional o mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conectando con la base de datos...')),
      );

      final resultado = await AuthService.registrarUsuario(
        nombre: _nombreController.text.trim(),
        apellido: _apellidoController.text.trim(),
        telefono: _telefonoController.text.trim(),
        correo: _correoController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (resultado['estado'] == 'exito') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultado['mensaje']), backgroundColor: Colors.green),
        );
        Navigator.pop(context); // Regresar al Login tras registrarse con éxito
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resultado['mensaje']), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.midnightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Registro de Cliente'),
        foregroundColor: AppColors.goldenPalm,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            color: Colors.white.withOpacity(0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.goldenPalm, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(_nombreController, 'Nombre', Icons.person),
                    _buildTextField(_apellidoController, 'Apellido', Icons.person_outline),
                    _buildTextField(_telefonoController, 'Teléfono', Icons.phone, isNumeric: true),
                    _buildTextField(_correoController, 'Correo electrónico', Icons.email),
                    _buildTextField(_passwordController, 'Contraseña', Icons.lock, isPassword: true),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.goldenPalm,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _registrarUsuario,
                        child: const Text('REGISTRARSE', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
    bool isNumeric = false,
    int? maxLength, // Nuevo parámetro opcional para el límite
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumeric ? TextInputType.phone : TextInputType.text,
        maxLength: maxLength, // Aplica el límite máximo
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: AppColors.goldenPalm),
          counterText: '', // Oculta el contador debajo del input
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.goldenPalm),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo requerido';
          }
          if (isNumeric) {
            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'Solo se permiten números';
            }
            if (value.length < 7) {
              return 'Número muy corto';
            }
          }
          return null;
        },
      ),
    );
  }
}