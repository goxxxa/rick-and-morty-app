import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:rick_and_morty_app/core/database/database.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';

extension CharacterX on Character {
  CharactersCompanion toCompanion() {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      species: Value(species),
      type: Value(type),
      gender: Value(gender),
      originName: Value(origin.name),
      originUrl: Value(origin.url),
      locationName: Value(location.name),
      locationUrl: Value(location.url),
      image: Value(image),
      url: Value(url),
      episode: Value(Uint8List.fromList(utf8.encode(jsonEncode(episode)))),
      created: Value(created),
      isFavorite: Value(isFavorite),
    );
  }
}
