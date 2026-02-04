import 'package:hive/hive.dart';

part 'plan_vida_section.g.dart';

@HiveType(typeId: 0)
class PlanVidaSection extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String titulo;

  @HiveField(2)
  final String descripcion;

  @HiveField(3)
  bool completado;

  @HiveField(4)
  final String contenido;

  PlanVidaSection({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.contenido,
    this.completado = false,
  });
}
