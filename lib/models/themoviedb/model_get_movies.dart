import 'dart:convert';

import 'package:peliculas/models/themoviedb/model_movie.dart';

class ModelGetMovies {
  int page;
  List<ModelMovie> results;
  int totalPages;
  int totalResults;

  ModelGetMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ModelGetMovies.fromRawJson(String str) =>
      ModelGetMovies.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory ModelGetMovies.fromJson(Map<String, dynamic> json) => ModelGetMovies(
    page: json["page"] ?? 0,
    results: List<ModelMovie>.from(
      json["results"].map((x) => ModelMovie.fromJson(x)),
    ),
    totalPages: json["total_pages"] ?? 0,
    totalResults: json["total_results"] ?? 0,
  );

  // Map<String, dynamic> toJson() => {
    // "page": page,
    // "results": List<dynamic>.from(results.map((x) => x.toJson())),
    // "total_pages": totalPages,
    // "total_results": totalResults,
  // };
}
