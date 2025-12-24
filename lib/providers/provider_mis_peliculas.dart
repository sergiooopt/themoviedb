import 'package:flutter/material.dart';
import 'package:peliculas/models/mis_peliculas/model_mi_pelicula.dart';
import 'package:peliculas/services/service_mis_peliculas.dart';
import 'package:sqflite/sqflite.dart';

class ProviderMispeliculas with ChangeNotifier {
  List<ModelMiPelicula> _peliculasLocales = [];
  List<String> _generos = [];

  List<ModelMiPelicula> get peliculasLocales {
    _getPeliculasLocales();
    return _peliculasLocales;
  }

  List<String> get generos {
    _getGeneros();
    return _generos;
  }

  void _getPeliculasLocales() async {
    _peliculasLocales = await ServiceMisPeliculas.instance.getMisPeliculas();
    notifyListeners();
  }

  void _getGeneros() async {
    _generos = await ServiceMisPeliculas.instance.getGeneros();
    notifyListeners();
  }

  void addPeliculaLocal(ModelMiPelicula miPelicula) async {
    final Database db = await ServiceMisPeliculas.instance.database;

    // Comprobar si ya existe para hacer update en vez de insert
    final List<Map<String, Object?>> coincidencias = await db.query(
      'peliculas',
      where: '''titulo = '${miPelicula.titulo}' ''',
    );

    if (coincidencias.isEmpty) {
      db.insert('peliculas', ModelMiPelicula.getMap(miPelicula));
      notifyListeners();
    } else {
      db.update('peliculas', ModelMiPelicula.getMap(miPelicula));
      notifyListeners();
    }
  }

  void removePeliculaLocal(String titulo) async {
    final Database db = await ServiceMisPeliculas.instance.database;
    db.delete('peliculas', where: ''' titulo = '$titulo' ''');
    notifyListeners();
  }
}
