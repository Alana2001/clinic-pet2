import 'package:flutter/material.dart';
import 'package:clinic_pet2/database/database.dart';
import '../models/animal.dart';
import '../models/cliente.dart';

class AnimalForm extends StatefulWidget {
  const AnimalForm({super.key});

  @override
  _AnimalFormState createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  String? _sexoSelecionado;
  int? _clienteSelecionado;
  List<Cliente> _clientes = [];

  @override
  void initState() {
    super.initState();
    _carregarClientes();
  }

  Future<void> _carregarClientes() async {
    final db = await DB.instance.database;
    final clientes = await db.query('cliente') as List;
    setState(() {
      _clientes = clientes.map((cliente) {
        return Cliente(
          id: cliente['id'] as int,
          nome: cliente['nome'] as String,
          endereco: cliente['endereco'] as String,
          cep: cliente['cep'] as String,
          telefone: cliente['telefone'] as String,
          email: cliente['email'] as String,
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastrar Animal")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Informações do Animal",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Animal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira o nome do animal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idadeController,
                decoration: const InputDecoration(
                  labelText: 'Idade do Animal',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a idade do animal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sexoSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Sexo do Animal',
                  border: OutlineInputBorder(),
                ),
                items: ['Macho', 'Fêmea'].map((String sexo) {
                  return DropdownMenuItem<String>(
                    value: sexo,
                    child: Text(sexo),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _sexoSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecione o sexo do animal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _clienteSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Cliente Proprietário',
                  border: OutlineInputBorder(),
                ),
                items: _clientes.map((Cliente cliente) {
                  return DropdownMenuItem<int>(
                    value: cliente.id,
                    child: Text(cliente.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _clienteSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecione o cliente proprietário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Animal novoAnimal = Animal(
                      nome: _nomeController.text,
                      idade: int.parse(_idadeController.text),
                      sexo: _sexoSelecionado!,
                      clienteId: _clienteSelecionado!,
                    );

                    await DB.instance.database.then((db) {
                      db.insert('animal', novoAnimal.toMap());
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Animal cadastrado com sucesso!')),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Salvar Animal'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
