import 'dart:convert';

import 'package:peliculas/models/themoviedb/model_actor.dart';

class ModelActores {
  int id;
  List<ModelActor> cast;
  List<ModelActor> crew;

  ModelActores({required this.id, required this.cast, required this.crew});

  factory ModelActores.fromRawJson(String str) =>
      ModelActores.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelActores.fromJson(Map<String, dynamic> json) => ModelActores(
    id: json["id"],
    cast: List<ModelActor>.from(json["cast"].map((x) => ModelActor.fromJson(x))),
    crew: List<ModelActor>.from(json["crew"].map((x) => ModelActor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}
