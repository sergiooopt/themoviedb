import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:peliculas/models/themoviedb/model_actor.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';
import 'package:peliculas/services/service_themoviedb.dart';

class ProviderThemoviedb with ChangeNotifier {
  final List<ModelMovie> _nowPlaying = [];
  int _pagesNowPlaying = 1;

  final List<ModelMovie> _popular = [];
  int _pagesPopular = 1;

  final List<ModelMovie> _upcoming = [];
  int _pagesUpcoming = 1;

  Future<List<ModelMovie>> getTopRatedMovies() async {
    return await ServiceThemoviedb.instance.getTopRatedMovies();
  }

  Future<List<ModelMovie>> getNowPlaying() async {
    _nowPlaying.addAll(
      await ServiceThemoviedb.instance.getNowPlaying(page: _pagesNowPlaying),
    );
    _pagesNowPlaying++;

    notifyListeners();
    return _nowPlaying;
  }

  Future<List<ModelMovie>> getPopular() async {
    _popular.addAll(
      await ServiceThemoviedb.instance.getPopular(page: _pagesPopular),
    );
    _pagesPopular++;

    notifyListeners();
    return _popular;
  }

  Future<List<ModelMovie>> getUpcoming() async {
    _upcoming.addAll(
      await ServiceThemoviedb.instance.getUpcoming(page: _pagesUpcoming),
    );
    _pagesUpcoming++;

    notifyListeners();
    return _upcoming;
  }

  Future<List<ModelActor>> getActores({required int id}) async {
    return await ServiceThemoviedb.instance.getActores(id: id);
  }

  Future<List<ModelMovie>> getPeliculasPorNombre({
    required String texto,
  }) async {
    return await ServiceThemoviedb.instance.getPeliculasPorNombre(texto: texto);
  }
}
