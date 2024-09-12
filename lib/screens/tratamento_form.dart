import 'package:clinic_pet2/database/database.dart';
import 'package:flutter/material.dart';

import '../models/animal.dart';
import '../models/tratamento.dart';

class TratamentoForm extends StatefulWidget {
  const TratamentoForm({super.key});

  @override
  _TratamentoFormState createState() => _TratamentoFormState();
}

class _TratamentoFormState extends State<TratamentoForm> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _dataInicialController = TextEditingController();
  final _dataFinalController = TextEditingController();
  int? _animalSelecionado;

  List<Animal> _animais = [];

  @override
  void initState() {
    super.initState();
    _carregarAnimais();
  }

  Future<void> _carregarAnimais() async {
    final db = await DB.instance.database;
    final animais = await db.query('animal') as List;

    setState(() {
      _animais = animais.map((animal) {
        return Animal(
          id: animal['id'] as int,
          nome: animal['nome'] as String,
          idade: animal['idade'] as int,
          sexo: animal['sexo'] as String,
          clienteId: animal['clienteId'] as int,
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Tratamento"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição do Tratamento',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a descrição do tratamento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dataInicialController,
                decoration: InputDecoration(
                  labelText: 'Data Inicial (dd/mm/yyyy)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a data inicial';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dataFinalController,
                decoration: InputDecoration(
                  labelText: 'Data Final (dd/mm/yyyy)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a data final';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _animalSelecionado,
                decoration: InputDecoration(
                  labelText: 'Animal',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.pets),
                ),
                items: _animais.map((Animal animal) {
                  return DropdownMenuItem<int>(
                    value: animal.id,
                    child: Text(animal.nome),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _animalSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecione o animal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Tratamento novoTratamento = Tratamento(
                        dataInicial: _dataInicialController.text,
                        dataFinal: _dataFinalController.text,
                        animalId: _animalSelecionado!,
                      );

                      await DB.instance.database.then((db) {
                        db.insert('tratamento', novoTratamento.toMap());
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Tratamento registrado com sucesso!')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Tratamento'),
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
}
