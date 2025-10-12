import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/core/database/database.dart';

part 'character.freezed.dart';
part 'character.g.dart';

typedef JsonMap = Map<String, dynamic>;

@freezed
abstract class Character with _$Character {
  const factory Character({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required Origin origin,
    required Location location,
    required String image,
    required String url,
    required List<String> episode,
    required String created,
    @Default(false) bool isFavorite,
  }) = _Character;

  factory Character.fromJson(JsonMap json) => _$CharacterFromJson(json);

  factory Character.fromEntity(CharacterEntity entity) {
    return Character(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      species: entity.species,
      type: entity.type,
      gender: entity.gender,
      origin: Origin(name: entity.originName, url: entity.originUrl),
      location: Location(name: entity.locationName, url: entity.locationUrl),
      image: entity.image,
      url: entity.url,
      episode: (jsonDecode(utf8.decode(entity.episode)) as List<dynamic>)
          .cast<String>(),
      created: entity.created,
      isFavorite: entity.isFavorite,
    );
  }
}

@freezed
abstract class Origin with _$Origin {
  const factory Origin({required String name, required String url}) = _Origin;

  factory Origin.fromJson(JsonMap json) => _$OriginFromJson(json);
}

@freezed
abstract class Location with _$Location {
  const factory Location({required String name, required String url}) =
      _Location;

  factory Location.fromJson(JsonMap json) => _$LocationFromJson(json);
}
