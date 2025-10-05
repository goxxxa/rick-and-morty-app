import 'package:equatable/equatable.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final String created;

  const Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    airDate,
    episode,
    characters,
    url,
    created,
  ];
}

class Origin extends Equatable {
  final String name;
  final String url;

  const Origin({required this.name, required this.url});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(name: json["name"], url: json["url"]);
  }

  @override
  List<Object?> get props => [name, url];

  @override
  String toString() => '''Origin { name: $name, url: $url}''';
}

class Location extends Equatable {
  final String name;
  final String url;

  const Location({required this.name, required this.url});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json["name"], url: json["url"]);
  }

  @override
  List<Object?> get props => [name, url];

  @override
  String toString() => '''Location { id: $name, url^ $url} ''';
}

class CharacterModel extends Equatable {
  const CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.url,
    required this.episode,
    required this.created,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  final String url;
  final List<String> episode;
  final String created;

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"],
      gender: json["gender"],
      origin: Origin.fromJson(json["origin"]),
      location: Location.fromJson(json["location"]),
      image: json["image"],
      url: json["url"],
      episode: List<String>.from(json["episode"]),
      created: json["created"],
    );
  }

  static List<CharacterModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CharacterModel.fromJson(json)).toList();
  }

  @override
  String toString() {
    return '''Character { id: $id, name: $name, status: $status, species: $species, type: $type, gender: $gender, } ''';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    species,
    type,
    gender,
    origin,
    location,
    image,
    url,
    episode,
    created,
  ];
}
