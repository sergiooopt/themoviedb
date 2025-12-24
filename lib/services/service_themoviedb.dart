import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:peliculas/models/themoviedb/model_get_dates_movies.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/themoviedb/model_actor.dart';
import 'package:peliculas/models/themoviedb/model_actores.dart';
import 'package:peliculas/models/themoviedb/model_movie.dart';
import 'package:peliculas/models/themoviedb/model_get_movies.dart';

class ServiceThemoviedb {
  ServiceThemoviedb._();

  static final ServiceThemoviedb instance = ServiceThemoviedb._();

  Future<List<ModelMovie>> getTopRatedMovies() async {
    final Uri uri = Uri.https('api.themoviedb.org', '/3/movie/top_rated', {
      'language': 'es-ES',
      'page': '1',
    });

    final resultado = await http.get(
      uri,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MjEzMDU5ZmVkYzZjMzExMDFmNjRlODM0YTVhMjRiMiIsIm5iZiI6MTc2NDA3MTE5OS44NSwic3ViIjoiNjkyNTk3MWY0MjRkZWVjZDMyMjZiODcwIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.nazSlxr5jj-J1IIDaDnp3aa39o0jVc3bunP_tGC6rec',
        'accept': 'application/json',
      },
    );

    if (resultado.statusCode != 200) {
      debugPrint('STATUS CODE ${resultado.statusCode}');
      return [];
    }

    String contenido = resultado.body;
    ModelGetMovies modelTopRated = ModelGetMovies.fromRawJson(contenido);
    return modelTopRated.results;
  }

  Future<List<ModelMovie>> getNowPlaying({int page = 1}) async {
    final Uri uri = Uri.https('api.themoviedb.org', '/3/movie/now_playing', {
      'language': 'es-ES',
      'page': '$page',
    });

    final Response respuesta = await http.get(
      uri,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MjEzMDU5ZmVkYzZjMzExMDFmNjRlODM0YTVhMjRiMiIsIm5iZiI6MTc2NDA3MTE5OS44NSwic3ViIjoiNjkyNTk3MWY0MjRkZWVjZDMyMjZiODcwIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.nazSlxr5jj-J1IIDaDnp3aa39o0jVc3bunP_tGC6rec',
        'accept': 'application/json',
      },
    );

    if (respuesta.statusCode != 200) {
      debugPrint('STATUS CODE ${respuesta.statusCode}');
      return [];
    }

    String contenido = respuesta.body;
    ModelGetDatesMovies modelNowPlaying = ModelGetDatesMovies.fromRawJson(contenido);
    return modelNowPlaying.results;
  }

  Future<List<ModelMovie>> getPopular({int page = 1}) async {
    final Uri uri = Uri.https('api.themoviedb.org', '/3/movie/popular', {
      'language': 'es-ES',
      'page': '$page',
    });

    final Response respuesta = await http.get(
      uri,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MjEzMDU5ZmVkYzZjMzExMDFmNjRlODM0YTVhMjRiMiIsIm5iZiI6MTc2NDA3MTE5OS44NSwic3ViIjoiNjkyNTk3MWY0MjRkZWVjZDMyMjZiODcwIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.nazSlxr5jj-J1IIDaDnp3aa39o0jVc3bunP_tGC6rec',
        'accept': 'application/json',
      },
    );

    if (respuesta.statusCode != 200) {
      debugPrint('STATUS CODE ${respuesta.statusCode}');
      return [];
    }

    String contenido = respuesta.body;
    ModelGetMovies modelPopular = ModelGetMovies.fromRawJson(contenido);
    return modelPopular.results;
  }

  Future<List<ModelMovie>> getUpcoming({int page = 1}) async {
    final Uri uri = Uri.https('api.themoviedb.org', '/3/movie/upcoming', {
      'language': 'es-ES',
      'page': '$page',
    });

    final Response respuesta = await http.get(
      uri,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MjEzMDU5ZmVkYzZjMzExMDFmNjRlODM0YTVhMjRiMiIsIm5iZiI6MTc2NDA3MTE5OS44NSwic3ViIjoiNjkyNTk3MWY0MjRkZWVjZDMyMjZiODcwIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.nazSlxr5jj-J1IIDaDnp3aa39o0jVc3bunP_tGC6rec',
        'accept': 'application/json',
      },
    );

    if (respuesta.statusCode != 200) {
      debugPrint('STATUS CODE ${respuesta.statusCode}');
      return [];
    }

    ModelGetDatesMovies modelUpcoming = ModelGetDatesMovies.fromRawJson(respuesta.body);
    return modelUpcoming.results;
  }

  Future<List<ModelActor>> getActores({required int id}) async {
    final Uri uri = Uri.https('api.themoviedb.org', '/3/movie/$id/credits', {
      'language': 'es-ES',
    });

    final Response respuesta = await http.get(
      uri,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MjEzMDU5ZmVkYzZjMzExMDFmNjRlODM0YTVhMjRiMiIsIm5iZiI6MTc2NDA3MTE5OS44NSwic3ViIjoiNjkyNTk3MWY0MjRkZWVjZDMyMjZiODcwIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.nazSlxr5jj-J1IIDaDnp3aa39o0jVc3bunP_tGC6rec',
        'accept': 'application/json',
      },
    );

    if (respuesta.statusCode != 200) {
      debugPrint('STATUS CODE ${respuesta.statusCode}');
      return [];
    }

    ModelActores modelActores = ModelActores.fromRawJson(respuesta.body);
    return modelActores.cast;
  }

  Future<List<ModelMovie>> getPeliculasPorNombre({
    required String texto,
  }) async {
    final Uri uri = Uri.https('api.themoviedb.org', '/3/search/movie', {
      'query': texto,
      'language': 'es-ES',
      'page': '1',
    });

    final Response respuesta = await http.get(
      uri,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MjEzMDU5ZmVkYzZjMzExMDFmNjRlODM0YTVhMjRiMiIsIm5iZiI6MTc2NDA3MTE5OS44NSwic3ViIjoiNjkyNTk3MWY0MjRkZWVjZDMyMjZiODcwIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.nazSlxr5jj-J1IIDaDnp3aa39o0jVc3bunP_tGC6rec',
        'accept': 'application/json',
      },
    );

    if (respuesta.statusCode != 200) {
      debugPrint('STATUS CODE ${respuesta.statusCode}');
      return [];
    }

    ModelGetMovies modelTopRated = ModelGetMovies.fromRawJson(respuesta.body);
    return modelTopRated.results;
  }
}
