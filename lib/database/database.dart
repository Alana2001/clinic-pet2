//import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  // Construtor com acesso privado
  DB._() {
    // Criar uma instancia de DB
  }

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;
    return await initDatabase();
  }

  initDatabase() async {
    return await openDatabase(
      join(
        await getDatabasesPath(),
        'clinica_veterinaria',
      ),
      version: 1,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {},
    );
  }

  Future<bool> reset() async {
    try {
      Database db = await DB.instance.database;
      await db.close();
      await initDatabase();
      return true;
    } catch (e) {
      return false;
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute(_cliente);
    await db.execute(_animal);
    await db.execute(_especie);
    await db.execute(_tratamento);
    await db.execute(_exame);
    await db.execute(_veterinario);
    await db.execute(_consulta);
  }

  String get _cliente => '''
    CREATE TABLE cliente (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        endereco TEXT NOT NULL,
        cep TEXT NOT NULL,
        telefone TEXT NOT NULL,
        email TEXT NOT NULL
      )
  ''';
  String get _animal => '''
    CREATE TABLE animal (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL,
        sexo TEXT NOT NULL,
        clienteId INTEGER,
        FOREIGN KEY (clienteId) REFERENCES cliente (id)
      ) 
  ''';

  String get _especie => '''
      CREATE TABLE especie (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeEspecie TEXT NOT NULL
      )
  ''';
  String get _tratamento => '''
      CREATE TABLE tratamento (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dataInicialTratamento TEXT NOT NULL,
        dataFinalTratamento TEXT NOT NULL,
        animalId INTEGER,
        FOREIGN KEY (animalId) REFERENCES animal (id)
      )
  ''';
  String get _exame => '''
       CREATE TABLE exame (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricaoExame TEXT NOT NULL,
        consultaId INTEGER,
        FOREIGN KEY (consultaId) REFERENCES consulta (id)
      )
  ''';
  String get _consulta => '''
      CREATE TABLE consulta (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dataConsulta TEXT NOT NULL,
        relatoConsulta TEXT NOT NULL,
        animalId INTEGER,
        veterinarioId INTEGER,
        FOREIGN KEY (animalId) REFERENCES animal (id),
        FOREIGN KEY (veterinarioId) REFERENCES veterinario (id)
      )
  ''';
  String get _veterinario => '''
      CREATE TABLE veterinario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomeVeterinario TEXT NOT NULL,
        enderecoVeterinario TEXT NOT NULL,
        cepVeterinario TEXT NOT NULL,
        telefoneVeterinario TEXT NOT NULL,
        emailVeterinario TEXT NOT NULL
      )
  ''';
}
