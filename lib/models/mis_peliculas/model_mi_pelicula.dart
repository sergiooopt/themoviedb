import 'package:peliculas/models/themoviedb/model_movie.dart';

class ModelMiPelicula {
  int? id;
  String titulo;
  String resumen;
  bool vista;
  double valoracion;
  String genero;

  ModelMiPelicula({
    this.id,
    required this.titulo,
    required this.resumen,
    required this.vista,
    required this.valoracion,
    required this.genero,
  });

  factory ModelMiPelicula.fromMap(Map<String, dynamic> misPeliculas) =>
      ModelMiPelicula(
        id: misPeliculas['id'] ?? -1,
        titulo: misPeliculas['titulo'] ?? '',
        resumen: misPeliculas['resumen'] ?? '',
        vista: misPeliculas['vista'] == 1 ? true : false,
        valoracion: double.tryParse(misPeliculas['valoracion'].toString()) ?? 0,
        genero: misPeliculas['genero'] ?? -1,
      );

  static ModelMiPelicula getModelEmpty() {
    return ModelMiPelicula(
      titulo: '',
      resumen: '',
      vista: false,
      valoracion: 0,
      genero: '',
    );
  }

  static Map<String, dynamic> getMap(ModelMiPelicula miPelicula) {
    return {
      'titulo': miPelicula.titulo,
      'resumen': miPelicula.resumen,
      'vista': miPelicula.vista,
      'valoracion': miPelicula.valoracion,
      'genero': miPelicula.genero,
    };
  }

  static ModelMiPelicula convertModelMovie(ModelMovie movie) {
    return ModelMiPelicula(
      titulo: movie.title, 
      resumen: movie.overview, 
      vista: false, // ModelMovie no implementa este campo 
      valoracion: movie.voteAverage, 
      genero: 'Ciencia ficción' // valor por defecto
      );
  }
}
