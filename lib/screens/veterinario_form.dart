import 'package:clinic_pet2/database/database.dart';
import 'package:flutter/material.dart';

import '../models/veterinario.dart';

class VeterinarioForm extends StatefulWidget {
  const VeterinarioForm({super.key});

  @override
  _VeterinarioFormState createState() => _VeterinarioFormState();
}

class _VeterinarioFormState extends State<VeterinarioForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cepController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Veterinário"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextFormField(
                controller: _nomeController,
                label: 'Nome do Veterinário',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o nome do veterinário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _enderecoController,
                label: 'Endereço',
                icon: Icons.home,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _cepController,
                label: 'CEP',
                icon: Icons.location_on,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _telefoneController,
                label: 'Telefone',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _emailController,
                label: 'E-mail',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Veterinario novoVeterinario = Veterinario(
                        nomeVeterinario: _nomeController.text,
                        enderecoVeterinario: _enderecoController.text,
                        cepVeterinario: _cepController.text,
                        telefoneVeterinario: _telefoneController.text,
                        emailVeterinario: _emailController.text,
                      );

                      await DB.instance.database.then((db) {
                        db.insert('veterinario', novoVeterinario.toMap());
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Veterinário cadastrado com sucesso!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Veterinário'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
