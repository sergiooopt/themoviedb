import 'package:flutter/material.dart';
import 'package:peliculas/core/routes_peliculas.dart';

class App extends StatelessWidget {
  // ScaffoldMessenger global para evitar problema de context
  static final scaffoldMessenger = GlobalKey<ScaffoldMessengerState>();

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessenger,
      debugShowCheckedModeBanner: false,
      routes: RoutesPeliculas.getRoutes(),
      initialRoute: RoutesPeliculas.inicialScreen,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
    );
  }
}
