import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/plan_vida_section.dart';
import '../widgets/plan_vida_card.dart';
import '../data/data.dart';
import 'plan_vida_detail_page.dart';

class PlanVidaPage extends StatefulWidget {
  const PlanVidaPage({super.key});

  @override
  State<PlanVidaPage> createState() => _PlanVidaPageState();
}

class _PlanVidaPageState extends State<PlanVidaPage> {
  late Box<PlanVidaSection> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<PlanVidaSection>('plan_vida');

    // ✅ INSERTAR SECCIONES POR DEFECTO SOLO UNA VEZ
    if (box.isEmpty) {
      for (final section in planVidaDefaults) {
        box.add(section);
      }
    }
  }

  // ➕ AGREGAR SECCIÓN PERSONAL
  void _agregarNuevaSeccion() {
    final tituloCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final contenidoCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nueva sección'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloCtrl,
                decoration: const InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: contenidoCtrl,
                decoration: const InputDecoration(labelText: 'Contenido'),
                maxLines: 4,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              box.add(
                PlanVidaSection(
                  id: DateTime.now().toIso8601String(),
                  titulo: tituloCtrl.text,
                  descripcion: descCtrl.text,
                  contenido: contenidoCtrl.text,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan de Vida'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _agregarNuevaSeccion,
            tooltip: 'Agregar sección',
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<PlanVidaSection>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          final sections = box.values.toList();

          if (sections.isEmpty) {
            return const Center(
              child: Text('No hay secciones aún'),
            );
          }

          return ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              final section = sections[index];

              return PlanVidaCard(
                section: section,

                // ✔️ Marcar como completado
                onToggle: () {
                  section.completado = !section.completado;
                  section.save();
                },

                // 📖 Ver detalle
                onOpen: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PlanVidaDetailPage(section: section),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

