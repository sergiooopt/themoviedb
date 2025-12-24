import 'dart:convert';

import 'package:peliculas/models/themoviedb/model_movie.dart';

class ModelGetDatesMovies {
  Dates dates;
  int page;
  List<ModelMovie> results;
  int totalPages;
  int totalResults;

  ModelGetDatesMovies({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ModelGetDatesMovies.fromRawJson(String str) =>
      ModelGetDatesMovies.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelGetDatesMovies.fromJson(Map<String, dynamic> json) =>
      ModelGetDatesMovies(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        results: List<ModelMovie>.from(
          json["results"].map((x) => ModelMovie.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "dates": dates.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Dates {
  String maximum;
  String minimum;

  Dates({required this.maximum, required this.minimum});

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dates.fromJson(Map<String, dynamic> json) =>
      Dates(maximum: json["maximum"] ?? "", minimum: json["minimum"] ?? "");

  Map<String, dynamic> toJson() => {"maximum": maximum, "minimum": minimum};
}
