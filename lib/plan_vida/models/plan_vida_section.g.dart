// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_vida_section.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanVidaSectionAdapter extends TypeAdapter<PlanVidaSection> {
  @override
  final int typeId = 0;

  @override
  PlanVidaSection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanVidaSection(
      id: fields[0] as String,
      titulo: fields[1] as String,
      descripcion: fields[2] as String,
      contenido: fields[4] as String,
      completado: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PlanVidaSection obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titulo)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.completado)
      ..writeByte(4)
      ..write(obj.contenido);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanVidaSectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
