import 'package:clinic_pet2/database/database.dart';
import 'package:flutter/material.dart';

import '../models/consulta.dart';
import '../models/exame.dart';

class ExameForm extends StatefulWidget {
  const ExameForm({super.key});

  @override
  _ExameFormState createState() => _ExameFormState();
}

class _ExameFormState extends State<ExameForm> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  int? _consultaSelecionada;

  List<Consulta> _consultas = [];

  @override
  void initState() {
    super.initState();
    _carregarConsultas();
  }

  Future<void> _carregarConsultas() async {
    final db = await DB.instance.database;
    final consultas = await db.query('consulta') as List;

    setState(() {
      _consultas = consultas.map((consulta) {
        return Consulta(
          id: consulta['id'] as int,
          dataConsulta: consulta['dataConsulta'] as String,
          relatoConsulta: consulta['relatoConsulta'] as String,
          animalId: consulta['animalId'] as int,
          veterinarioId: consulta['veterinarioId'] as int,
        );
      }).toList();
    });
  }

  Future<void> _registrarExame() async {
    if (_formKey.currentState!.validate()) {
      Exame novoExame = Exame(
        descricaoExame: _descricaoController.text,
        consultaId: _consultaSelecionada!,
      );

      final db = await DB.instance.database;
      await db.insert('exame', novoExame.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exame registrado com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _consultarExame(int id) async {
    final db = await DB.instance.database;
    final result = await db.query('exame', where: 'id = ?', whereArgs: [id]);

    if (result.isNotEmpty) {
      final exame = Exame.fromMap(result.first);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exame encontrado: ${exame.descricaoExame}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exame não encontrado')),
      );
    }
  }

  Future<void> _listarExames() async {
    final db = await DB.instance.database;
    final result = await db.query('exame') as List;

    if (result.isNotEmpty) {
      final exames = result.map((e) => Exame.fromMap(e)).toList();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exames Registrados'),
            content: SizedBox(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemCount: exames.length,
                itemBuilder: (context, index) {
                  final exame = exames[index];
                  return ListTile(
                    title: Text(exame.descricaoExame),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum exame registrado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Exame"),
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
                  labelText: 'Descrição do Exame',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor insira a descrição do exame';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _consultaSelecionada,
                decoration: InputDecoration(
                  labelText: 'Consulta',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: const Icon(Icons.medical_services),
                ),
                items: _consultas.map((Consulta consulta) {
                  return DropdownMenuItem<int>(
                    value: consulta.id,
                    child: Text('Consulta: ${consulta.dataConsulta}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _consultaSelecionada = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor selecione uma consulta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _registrarExame,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar Exame'),
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
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await _consultarExame(1);
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Consultar Exame'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
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
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _listarExames,
                  icon: const Icon(Icons.list),
                  label: const Text('Listar Exames'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
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
