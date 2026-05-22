import 'package:flutter/material.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  // Nombre de ruta reportado por FirebaseAnalyticsObserver en screen_view.
  static const routeName = 'pantalla_resumen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 3 — Resumen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Última pantalla del flujo dummy. Navega hacia atrás '
              'para ver cómo el observer vuelve a registrar la pantalla anterior.',
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              icon: const Icon(Icons.home),
              label: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
