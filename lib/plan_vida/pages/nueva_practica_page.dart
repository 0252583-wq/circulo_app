import 'package:flutter/material.dart';
import '../models/plan_vida_section.dart';
import '../storage/plan_vida_storage.dart';
import 'package:uuid/uuid.dart';

class NuevaPracticaPage extends StatefulWidget {
  const NuevaPracticaPage({super.key});

  @override
  State<NuevaPracticaPage> createState() => _NuevaPracticaPageState();
}

class _NuevaPracticaPageState extends State<NuevaPracticaPage> {
  final tituloCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  void _guardar() async {
    if (tituloCtrl.text.trim().isEmpty) return;

    final nueva = PlanVidaSection(
      id: const Uuid().v4(),
      titulo: tituloCtrl.text.trim(),
      descripcion: descCtrl.text.trim(),
      esEditable: true,
    );

    await PlanVidaStorage.add(nueva);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva práctica')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tituloCtrl,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardar,
              child: const Text('Agregar'),
            )
          ],
        ),
      ),
    );
  }
}
