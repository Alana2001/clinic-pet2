class Veterinario {
  int? id;
  String nomeVeterinario;
  String enderecoVeterinario;
  String cepVeterinario;
  String telefoneVeterinario;
  String emailVeterinario;

  Veterinario({
    this.id,
    required this.nomeVeterinario,
    required this.enderecoVeterinario,
    required this.cepVeterinario,
    required this.telefoneVeterinario,
    required this.emailVeterinario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeVeterinario': nomeVeterinario,
      'enderecoVeterinario': enderecoVeterinario,
      'cepVeterinario': cepVeterinario,
      'telefoneVeterinario': telefoneVeterinario,
      'emailVeterinario': emailVeterinario,
    };
  }
}
