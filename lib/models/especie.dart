class Especie {
  int? id;
  String nomeEspecie;

  Especie({
    this.id,
    required this.nomeEspecie,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeEspecie': nomeEspecie,
    };
  }
}
