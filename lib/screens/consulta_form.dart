import 'package:clinic_pet2/database/database.dart';
import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../models/consulta.dart';
import '../models/veterinario.dart';

class ConsultaForm extends StatefulWidget {
  const ConsultaForm({super.key});

  @override
  _ConsultaFormState createState() => _ConsultaFormState();
}

class _ConsultaFormState extends State<ConsultaForm> {
  final _formKey = GlobalKey<FormState>();
  final _dataConsultaController = TextEditingController();
  final _relatoConsultaController = TextEditingController();
  int? _animalSelecionado;
  int? _veterinarioSelecionado;

  List<Animal> _animais = [];
  List<Veterinario> _veterinarios = [];

  @override
  void initState() {
    super.initState();
    _carregarAnimaisEVeterinarios();
  }

  Future<void> _carregarAnimaisEVeterinarios() async {
    final db = await DB.instance.database;
    final animais = await db.query('animal') as List;
    final veterinarios = await db.query('veterinario') as List;

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

      _veterinarios = veterinarios.map((veterinario) {
        return Veterinario(
          id: veterinario['id'] as int,
          nomeVeterinario: veterinario['nomeVeterinario'] as String,
          enderecoVeterinario: veterinario['enderecoVeterinario'] as String,
          cepVeterinario: veterinario['cepVeterinario'] as String,
          telefoneVeterinario: veterinario['telefoneVeterinario'] as String,
          emailVeterinario: veterinario['emailVeterinario'] as String,
        );
      }).toList();
    });
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dataConsultaController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Consulta")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Informações da Consulta",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dataConsultaController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data da Consulta',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selecionarData(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a data da consulta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _relatoConsultaController,
                decoration: const InputDecoration(
                  labelText: 'Relato da Consulta',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _animalSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Animal',
                  border: OutlineInputBorder(),
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
                    return 'Por favor selecione um animal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _veterinarioSelecionado,
                decoration: const InputDecoration(
                  labelText: 'Veterinário',
                  border: OutlineInputBorder(),
                ),
                items: _veterinarios.map((Veterinario veterinario) {
                  return DropdownMenuItem<int>(
                    value: veterinario.id,
                    child: Text(veterinario.nomeVeterinario),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _veterinarioSelecionado = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecione um veterinário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Consulta novaConsulta = Consulta(
                      dataConsulta: _dataConsultaController.text,
                      relatoConsulta: _relatoConsultaController.text,
                      animalId: _animalSelecionado!,
                      veterinarioId: _veterinarioSelecionado!,
                    );

                    await DB.instance.database.then((db) {
                      db.insert('consulta', novaConsulta.toMap());
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Consulta registrada com sucesso!'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Salvar Consulta'),
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
