// SDK de Firebase Analytics.
import 'package:firebase_analytics/firebase_analytics.dart';
// SDK base de Firebase para inicializar la app con la configuración de proyecto.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Archivo generado por FlutterFire CLI con las credenciales/configuración por plataforma.
import 'package:holamundo_firebase/firebase_options.dart';
import 'package:holamundo_firebase/screens/screen_one.dart';
import 'package:holamundo_firebase/screens/screen_three.dart';
import 'package:holamundo_firebase/screens/screen_two.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa Firebase con la configuración correspondiente a la plataforma actual.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Obtiene la instancia singleton de Firebase Analytics.
  final analytics = FirebaseAnalytics.instance;
  // Activa la recopilación de datos en Analytics.
  await analytics.setAnalyticsCollectionEnabled(true);
  // Envía un evento de apertura de app para facilitar el seguimiento en Firebase.
  await analytics.logAppOpen();

  if (kDebugMode) {
    final appInstanceId = await analytics.appInstanceId;
    debugPrint(
      'Firebase Analytics Android — appInstanceId: ${appInstanceId ?? "null (revisa Google Play Services)"}',
    );
  }

  runApp(MyApp(analytics: analytics));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.analytics});

  final FirebaseAnalytics analytics;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final FirebaseAnalyticsObserver analyticsObserver;

  @override
  void initState() {
    super.initState();
    // Observador que permite que Firebase Analytics registre cambios de pantalla.
    analyticsObserver = FirebaseAnalyticsObserver(
      analytics: widget.analytics,
      onError: (error) {
        debugPrint(
          'FirebaseAnalyticsObserver error: ${error.code} ${error.message}',
        );
      },
    );

    // El observer no recibe didPush de la ruta inicial; registramos la primera pantalla aquí.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.analytics.logScreenView(screenName: ScreenOne.routeName);
    });
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    final Widget page;
    switch (settings.name) {
      case ScreenOne.routeName:
        page = const ScreenOne();
      case ScreenTwo.routeName:
        page = const ScreenTwo();
      case ScreenThree.routeName:
        page = const ScreenThree();
      default:
        return null;
    }

    return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analytics Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorObservers: [analyticsObserver],
      initialRoute: ScreenOne.routeName,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
