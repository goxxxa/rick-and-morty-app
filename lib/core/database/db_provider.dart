import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/core/database/database.dart';
import 'package:rick_and_morty_app/repositories/models.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

abstract interface class DatabaseProvider {
  Future<void> addCharacter();
  Future<Character> getCharacter(int characterId);
  Future<List<Character>> getAllCharacters();
  Future<void> deleteCharacter();
  Future<int> updateCharacter();
  Future<void> deleteDatabaseFile();

  Future<void> addCharacters(List<CharacterModel> characters);

  Future<void> addCharacterToFavorites(int characterId);
  Future<void> deleteCharacterFromFavorites(int characterId);
  Future<void> getAllFavoritesCharacter();
}

class DatabaseProviderImpl implements DatabaseProvider {
  final AppDatabase db;

  DatabaseProviderImpl({required this.db});

  @override
  Future<void> addCharacter() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCharacter() {
    throw UnimplementedError();
  }

  @override
  Future<Character> getCharacter(int characterId) async {
    return await (db.select(
      db.characters,
    )..where((t) => t.id.equals(characterId))).getSingle();
  }

  @override
  Future<void> addCharacterToFavorites(int characterId) async {
    await db
        .into(db.favorites)
        .insertOnConflictUpdate(
          FavoritesCompanion.insert(id: Value(characterId)),
        );
  }

  @override
  Future<List<Character>> getAllFavoritesCharacter() async {
    final favorites = await db.select(db.favorites).get();
    final ids = favorites.map((f) => f.id).toList();

    if (ids.isEmpty) return [];
    final query = db.select(db.characters)..where((t) => t.id.isIn(ids));

    final result = await query.get();
    return result;
  }

  @override
  Future<void> deleteDatabaseFile() async {
    final dir = await getApplicationSupportDirectory();
    final dbFile = File(join(dir.path, 'my_database.sqlite'));

    if (await dbFile.exists()) {
      await dbFile.delete();
    }
  }

  @override
  Future<void> addCharacters(List<CharacterModel> characters) async {
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        db.characters,
        characters.map((character) {
          return CharactersCompanion.insert(
            id: Value(character.id),
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            image: character.image,
            episode: Uint8List.fromList([1, 1, 1]),
            created: character.created,
          );
        }).toList(),
      );
    });
  }

  @override
  Future<int> updateCharacter() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCharacterFromFavorites(int characterId) async {
    await (db.delete(
      db.favorites,
    )..where((t) => t.id.equals(characterId))).go();
  }

  @override
  Future<List<Character>> getAllCharacters() async {
    return await (db.select(db.characters)).get();
  }
}
