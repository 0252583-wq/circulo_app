import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'tema.dart';

class TemasStorage {
  static const String _key = 'temas_guardados';

  // Guardar temas
  static Future<void> guardarTemas(List<Tema> temas) async {
    final prefs = await SharedPreferences.getInstance();
    final temasJson = temas.map((t) => t.toJson()).toList();
    await prefs.setString(_key, jsonEncode(temasJson));
  }

  // Cargar temas
  static Future<List<Tema>> cargarTemas() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((e) => Tema.fromJson(e)).toList();
  }
}
