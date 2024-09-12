class Cliente {
  int? id;
  String nome;
  String endereco;
  String cep;
  String telefone;
  String email;

  Cliente({
    this.id,
    required this.nome,
    required this.endereco,
    required this.cep,
    required this.telefone,
    required this.email,
  });

  // Métodos para converter para Map (para salvar no banco) e de Map para objeto
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'endereco': endereco,
      'cep': cep,
      'telefone': telefone,
      'email': email,
    };
  }
}
