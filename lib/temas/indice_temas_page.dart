import 'package:flutter/material.dart';
import 'tema.dart';
import 'temas_data.dart';
import 'tema_detalle_page.dart';
import 'nuevo_tema_page.dart';
import 'temas_storage.dart';

class IndiceTemasPage extends StatefulWidget {
  const IndiceTemasPage({super.key});

  @override
  State<IndiceTemasPage> createState() => _IndiceTemasPageState();
}

class _IndiceTemasPageState extends State<IndiceTemasPage> {
  final TextEditingController _buscadorController = TextEditingController();
  List<Tema> temasFiltrados = [];

  @override
  void initState() {
    super.initState();
    temasFiltrados = List.from(temas);
    _buscadorController.addListener(_filtrarTemas);
  }

  void _filtrarTemas() {
    final query = _buscadorController.text.toLowerCase();

    setState(() {
      temasFiltrados = temas
          .where((tema) => tema.titulo.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _buscadorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Índice de temas'),
        centerTitle: true,
        actions: [
          // ➕ AGREGAR TEMA
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Agregar tema',
            onPressed: () async {
              final Tema? nuevoTema = await Navigator.push<Tema>(
                context,
                MaterialPageRoute(
                  builder: (_) => const NuevoTemaPage(),
                ),
              );

              if (nuevoTema != null) {
                setState(() {
                  temas.add(nuevoTema);
                  temasFiltrados = List.from(temas);
                });

                await TemasStorage.guardarTemas(temas);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tema agregado')),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 BUSCADOR
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _buscadorController,
              decoration: InputDecoration(
                hintText: 'Buscar tema...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 📄 LISTA DE TEMAS
          Expanded(
            child: temasFiltrados.isEmpty
                ? const Center(
                    child: Text(
                      'No se encontraron temas',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: temasFiltrados.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final tema = temasFiltrados[index];

                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: ListTile(
                          title: Text(
                            tema.titulo,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // ✏️ EDITAR
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  final Tema? editado =
                                      await Navigator.push<Tema>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          TemaDetallePage(tema: tema),
                                    ),
                                  );

                                  if (editado != null) {
                                    setState(() {
                                      final i = temas.indexOf(tema);
                                      temas[i] = editado;
                                      temasFiltrados = List.from(temas);
                                    });
                                    await TemasStorage.guardarTemas(temas);
                                  }
                                },
                              ),

                              // 🗑️ BORRAR
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () async {
                                  final confirmar = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title:
                                          const Text('Eliminar tema'),
                                      content: Text(
                                        '¿Eliminar "${tema.titulo}"?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child:
                                              const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child:
                                              const Text('Eliminar'),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirmar == true) {
                                    setState(() {
                                      temas.remove(tema);
                                      temasFiltrados =
                                          List.from(temas);
                                    });
                                    await TemasStorage
                                        .guardarTemas(temas);
                                  }
                                },
                              ),
                            ],
                          ),

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    TemaDetallePage(tema: tema),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
