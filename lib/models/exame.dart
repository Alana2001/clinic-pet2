class Exame {
  int? id;
  String descricaoExame;
  int consultaId;

  Exame({
    this.id,
    required this.descricaoExame,
    required this.consultaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricaoExame': descricaoExame,
      'consultaId': consultaId,
    };
  }

  // Adiciona o método fromMap
  factory Exame.fromMap(Map<String, dynamic> map) {
    return Exame(
      id: map['id'] as int?,
      descricaoExame: map['descricaoExame'] as String,
      consultaId: map['consultaId'] as int,
    );
  }
}
