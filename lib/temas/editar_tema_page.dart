import 'package:flutter/material.dart';
import 'tema.dart';

class EditarTemaPage extends StatefulWidget {
  final Tema tema;

  const EditarTemaPage({super.key, required this.tema});

  @override
  State<EditarTemaPage> createState() => _EditarTemaPageState();
}

class _EditarTemaPageState extends State<EditarTemaPage> {
  late TextEditingController _tituloController;
  late TextEditingController _contenidoController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tema.titulo);
    _contenidoController = TextEditingController(text: widget.tema.contenido);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    if (_tituloController.text.trim().isEmpty ||
        _contenidoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    final temaEditado = Tema(
      titulo: _tituloController.text.trim(),
      contenido: _contenidoController.text.trim(),
    );

    Navigator.pop(context, temaEditado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar tema'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _guardarCambios,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contenidoController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: 'Contenido',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
