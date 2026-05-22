// SDK de Firebase Analytics.
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:holamundo_firebase/screens/screen_two.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  // Nombre de ruta que FirebaseAnalyticsObserver reporta como pantalla en screen_view.
  static const routeName = 'pantalla_inicio';

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  // Instancia para registrar eventos y propiedades personalizadas en esta pantalla.
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  int _visitas = 0;

  Future<void> _registrarEventoPersonalizado() async {
    setState(() => _visitas++);

    // Evento personalizado visible en DebugView / informes de Analytics.
    await _analytics.logEvent(
      name: 'demo_interaccion',
      parameters: {
        'pantalla': ScreenOne.routeName,
        'tipo_accion': 'boton_ejemplo',
        'contador_visitas': _visitas,
        'timestamp_ms': DateTime.now().millisecondsSinceEpoch,
      },
    );

    // Propiedad de usuario asociada al dispositivo/sesión en el perfil de Analytics.
    await _analytics.setUserProperty(
      name: 'nivel_demo',
      value: _visitas > 3 ? 'avanzado' : 'principiante',
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Evento "demo_interaccion" enviado (visitas: $_visitas). '
          'Revísalo en Firebase Console → Analytics → DebugView.',
        ),
      ),
    );
  }

  void _irASegundaPantalla() {
    Navigator.of(context).pushNamed(ScreenTwo.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla 1 — Inicio'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Screen tracking automático vía FirebaseAnalyticsObserver.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Esta pantalla registra datos personalizados de ejemplo '
              '(evento + user property) para verlos en Firebase.',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _registrarEventoPersonalizado,
              icon: const Icon(Icons.analytics_outlined),
              label: const Text('Enviar evento personalizado'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _irASegundaPantalla,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Ir a Pantalla 2'),
            ),
          ],
        ),
      ),
    );
  }
}
