import 'package:flutter/material.dart';
import 'package:clinic_pet2/database/database.dart';
import 'home_page.dart';
import 'screens/animal_form.dart';
import 'screens/cliente_form.dart';
import 'screens/consulta_form.dart';
import 'screens/exame_form.dart';
import 'screens/tratamento_form.dart';
import 'screens/veterinario_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica Amigo Pet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          labelLarge: TextStyle(fontSize: 16, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Botões em azul
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          elevation: 4,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: const HomePage(), // Tela inicial
      routes: {
        '/animalForm': (context) => const AnimalForm(),
        '/clienteForm': (context) => const ClienteForm(),
        '/consultaForm': (context) => const ConsultaForm(),
        '/exameForm': (context) => const ExameForm(),
        '/tratamentoForm': (context) => const TratamentoForm(),
        '/veterinarioForm': (context) => const VeterinarioForm(),
      },
    );
  }
}
