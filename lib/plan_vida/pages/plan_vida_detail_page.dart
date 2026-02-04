import 'package:flutter/material.dart';
import '../models/plan_vida_section.dart';

class PlanVidaDetailPage extends StatelessWidget {
  final PlanVidaSection section;

  const PlanVidaDetailPage({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            section.contenido,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ),
      ),
    );
  }
}
