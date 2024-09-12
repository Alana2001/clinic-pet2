class Tratamento {
  int? id;
  String dataInicial;
  String dataFinal;
  int animalId;

  Tratamento({
    this.id,
    required this.dataInicial,
    required this.dataFinal,
    required this.animalId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataInicialTratamento': dataInicial,
      'dataFinalTratamento': dataFinal,
      'animalId': animalId,
    };
  }
}
