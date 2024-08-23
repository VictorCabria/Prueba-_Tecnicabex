import 'package:shared_preferences/shared_preferences.dart';

import '../../data/provides/database_helper.dart';

class UserRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<void> createUser(String email, String password) async {
    final db = await _databaseHelper.database;
    final token = generateToken(); // Generar el token
    await db.insert('Users', {
      'email': email,
      'password': password,
      'token': token, // Asignar el token al usuario
    });
  }

  Future<String> signIn(String email, String password) async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      'Users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      final token =
          result.first['token'] as String; // Obtener el token almacenado

      // Guardar el token en SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);

      return token;
    } else {
      throw Exception('Invalid credentials');
    }
  }

  Future<void> signOut() async {
    final db = await _databaseHelper.database;
    await db.update('Users', {'token': null});

    // Eliminar el token de SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }

  String generateToken() {
    return List.generate(
        24,
        (index) => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split(
            '')[(index + DateTime.now().millisecondsSinceEpoch) % 36]).join();
  }

  // Método para obtener el token desde SharedPreferences
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
