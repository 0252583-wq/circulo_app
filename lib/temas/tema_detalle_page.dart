import 'package:flutter/material.dart';
import 'tema.dart';
import 'editar_tema_page.dart';

class TemaDetallePage extends StatelessWidget {
  final Tema tema;

  const TemaDetallePage({super.key, required this.tema});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tema.titulo),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final Tema? temaEditado = await Navigator.push<Tema>(
                context,
                MaterialPageRoute(
                  builder: (_) => EditarTemaPage(tema: tema),
                ),
              );

              if (temaEditado != null) {
                Navigator.pop(context, temaEditado);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          tema.contenido,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
