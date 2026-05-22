import 'package:flutter/material.dart';
import 'package:holamundo_firebase/screens/screen_three.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  // Nombre de ruta reportado por FirebaseAnalyticsObserver en screen_view.
  static const routeName = 'pantalla_detalle';

  void _irATerceraPantalla(BuildContext context) {
    Navigator.of(context).pushNamed(ScreenThree.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 2 — Detalle'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pantalla intermedia. El cambio aquí se registra solo '
              'con el NavigatorObserver, sin código extra de analytics.',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => _irATerceraPantalla(context),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Ir a Pantalla 3'),
            ),
          ],
        ),
      ),
    );
  }
}
