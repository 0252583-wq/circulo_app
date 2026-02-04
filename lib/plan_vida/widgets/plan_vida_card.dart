import 'package:flutter/material.dart';
import '../models/plan_vida_section.dart';

class PlanVidaCard extends StatelessWidget {
  final PlanVidaSection section;
  final VoidCallback onToggle;
  final VoidCallback onOpen;

  const PlanVidaCard({
    super.key,
    required this.section,
    required this.onToggle,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(section.titulo),
        subtitle: Text(section.descripcion),
        onTap: onOpen,
        trailing: IconButton(
          icon: Icon(
            section.completado
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: section.completado ? Colors.green : Colors.grey,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
