import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clínica Veterinária'),
      ),
      body: SingleChildScrollView(
        // ScrollView para telas menores
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/clienteForm');
              },
              label: const Text('Gerenciar Clientes'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.pets),
              onPressed: () {
                Navigator.pushNamed(context, '/animalForm');
              },
              label: const Text('Gerenciar Animais'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.pushNamed(context, '/consultaForm');
              },
              label: const Text('Gerenciar Consultas'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.science),
              onPressed: () {
                Navigator.pushNamed(context, '/exameForm');
              },
              label: const Text('Gerenciar Exames'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.medical_services),
              onPressed: () {
                Navigator.pushNamed(context, '/tratamentoForm');
              },
              label: const Text('Gerenciar Tratamentos'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.person_pin),
              onPressed: () {
                Navigator.pushNamed(context, '/veterinarioForm');
              },
              label: const Text('Gerenciar Veterinários'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
