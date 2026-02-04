import 'package:flutter/material.dart';
import 'tema.dart';

class NuevoTemaPage extends StatefulWidget {
  const NuevoTemaPage({super.key});

  @override
  State<NuevoTemaPage> createState() => _NuevoTemaPageState();
}

class _NuevoTemaPageState extends State<NuevoTemaPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo tema'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // ---------- TÍTULO ----------
                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título del tema',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Escribe un título';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ---------- CONTENIDO ----------
                Expanded(
                  child: TextFormField(
                    controller: _contenidoController,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      labelText: 'Contenido',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Escribe el contenido';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // ---------- BOTÓN GUARDAR ----------
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final nuevoTema = Tema(
                          titulo: _tituloController.text.trim(),
                          contenido: _contenidoController.text.trim(),
                        );

                        Navigator.pop(context, nuevoTema);
                      }
                    },
                    child: const Text('Guardar tema'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
