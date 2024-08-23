// utils/validation.dart
class Validation {
  static String? validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (email.isEmpty) {
      return 'El email no puede estar vacío';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Por favor ingresa un email válido';
    }
    return null; // Retorna null si no hay error
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'La contraseña no puede estar vacía';
    } else if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null; // Retorna null si no hay error
  }
}
