class Tema {
  final String titulo;
  final String contenido;

  Tema({
    required this.titulo,
    required this.contenido,
  });

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'contenido': contenido,
    };
  }

  factory Tema.fromJson(Map<String, dynamic> json) {
    return Tema(
      titulo: json['titulo'],
      contenido: json['contenido'],
    );
  }
}
