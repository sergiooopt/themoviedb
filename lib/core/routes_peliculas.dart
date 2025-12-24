import 'package:flutter/material.dart';
import 'package:peliculas/screens/themoviedb/detail_screen.dart';
import 'package:peliculas/screens/home/screen_home.dart';
import 'package:peliculas/screens/screen_inicial.dart';
import 'package:peliculas/screens/mispeliculas/detalle_mispeliculas.dart';
import 'package:peliculas/screens/mispeliculas/screen_lista_peliculas.dart';

class RoutesPeliculas {
  static const String home = "home";
  static const String detail = "detail";
  static const String misPeliculasDetalle = "peliculas detalle";
  static const String misPeliculasLista = "peliculas lista";
  static const String inicialScreen = "screen inicial";

  static Map<String, WidgetBuilder> getRoutes() => {
    home: (_) => const ScreenHome(),
    detail: (_) => const DetailScreen(),
    misPeliculasDetalle: (_) => const DetalleMispeliculas(),
    misPeliculasLista: (_) => const ScreenListaPeliculas(),
    inicialScreen: (_) => const ScreenInicial(),
  };
}
