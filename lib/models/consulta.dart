class Consulta {
  int? id;
  String dataConsulta;
  String relatoConsulta;
  int animalId;
  int veterinarioId;

  Consulta({
    this.id,
    required this.dataConsulta,
    required this.relatoConsulta,
    required this.animalId,
    required this.veterinarioId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dataConsulta': dataConsulta,
      'relatoConsulta': relatoConsulta,
      'animalId': animalId,
      'veterinarioId': veterinarioId,
    };
  }
}
