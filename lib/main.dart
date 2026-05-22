// SDK de Firebase Analytics.
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:holamundo_firebase/firebase_options.dart';
import 'package:holamundo_firebase/screens/screen_one.dart';
import 'package:holamundo_firebase/screens/screen_two.dart';
import 'package:holamundo_firebase/screens/screen_three.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Instancia singleton usada para enviar eventos y screen views.
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Observer que escucha push/pop del Navigator y registra screen_view automáticamente.
  static final FirebaseAnalyticsObserver analyticsObserver =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analytics Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Conecta el observer al árbol de navegación para screen tracking sin código por pantalla.
      navigatorObservers: [analyticsObserver],
      // routeName de cada pantalla se envía a Analytics como nombre de pantalla (screen_view).
      initialRoute: ScreenOne.routeName,
      routes: {
        ScreenOne.routeName: (_) => const ScreenOne(),
        ScreenTwo.routeName: (_) => const ScreenTwo(),
        ScreenThree.routeName: (_) => const ScreenThree(),
      },
    );
  }
}
