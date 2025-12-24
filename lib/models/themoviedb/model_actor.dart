import 'dart:convert';

class ModelActor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  String get path => "https://image.tmdb.org/t/p/w500/$profilePath";

  ModelActor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  factory ModelActor.fromRawJson(String str) =>
      ModelActor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelActor.fromJson(Map<String, dynamic> json) => ModelActor(
    adult: json["adult"] ?? "",
    gender: json["gender"] ?? 0,
    id: json["id"] ?? 0,
    knownForDepartment: json["known_for_department"] ?? "",
    name: json["name"] ?? "",
    originalName: json["original_name"] ?? "",
    popularity: json["popularity"]?.toDouble() ?? 0,
    profilePath: json["profile_path"] ?? "",
    castId: json["cast_id"] ?? 0,
    character: json["character"] ?? "",
    creditId: json["credit_id"] ?? "",
    order: json["order"] ?? 0,
    department: json["department"] ?? "",
    job: json["job"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "order": order,
    "department": department,
    "job": job,
  };
}
