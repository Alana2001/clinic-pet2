class Animal {
  int? id;
  String nome;
  int idade;
  String sexo;
  int clienteId;

  Animal({
    this.id,
    required this.nome,
    required this.idade,
    required this.sexo,
    required this.clienteId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
      'sexo': sexo,
      'clienteId': clienteId,
    };
  }
}
