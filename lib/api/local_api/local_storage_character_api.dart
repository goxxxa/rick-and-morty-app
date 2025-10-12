import 'dart:async';
import 'package:rick_and_morty_app/utils/extensions/extensions.dart';
import 'package:rxdart/subjects.dart';
import 'package:drift/drift.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';
import 'package:rick_and_morty_app/api/local_api/character_api.dart';
import 'package:rick_and_morty_app/core/database/database.dart';

/// An implementation of the [CharacterApi] that uses local storage.
class LocalStorageCharacterApi extends CharacterApi {
  LocalStorageCharacterApi({required this.db}) {
    _init();
  }

  late final BehaviorSubject<List<Character>> _charactersStreamController =
      BehaviorSubject<List<Character>>.seeded(const []);

  @override
  Stream<List<Character>> get getCharacters =>
      _charactersStreamController.asBroadcastStream();

  @override
  Stream<List<Character>> get getFavorites => _charactersStreamController.stream
      .map((characters) => characters.where((c) => c.isFavorite).toList());

  final AppDatabase db;

  Future<void> _init() async {
    final characters = await (db.select(db.characters)..limit(10)).get();
    _charactersStreamController.add(
      characters.map(Character.fromEntity).toList(),
    );
  }

  @override
  Future<void> loadMore(int offset, int limit) async {
    final newCharacters =
        await (db.select(db.characters)
              // ..orderBy([(t) => OrderingTerm.asc(t.id)])
              ..limit(limit, offset: offset))
            .get();

    final current = [..._charactersStreamController.value];
    current.addAll(newCharacters.map(Character.fromEntity));

    _charactersStreamController.add(current);
  }

  @override
  Future<void> deleteCharacter(int id) async {
    final characters = [..._charactersStreamController.value];
    final characterIndex = characters.indexWhere((t) => t.id == id);
    if (characterIndex != -1) {
      characters.removeAt(characterIndex);
      _charactersStreamController.add(characters);
      await (db.delete(db.characters)..where((t) => t.id.equals(id))).go();
    }
  }

  @override
  Future<void> saveCharacter(Character character) async {
    final current = [..._charactersStreamController.value];
    final index = current.indexWhere((c) => c.id == character.id);

    if (index >= 0) {
      current[index] = character;
    } else {
      current.add(character);
    }

    _charactersStreamController.add(current);
    await db
        .into(db.characters)
        .insertOnConflictUpdate(character.toCompanion());
  }

  @override
  Future<void> setFavorite(int id) async {
    final current = [..._charactersStreamController.value];
    final index = current.indexWhere((c) => c.id == id);

    if (index >= 0) {
      current[index] = current[index].copyWith(isFavorite: true);
      _charactersStreamController.add(current);
    }

    await (db.update(db.characters)..where((t) => t.id.equals(id))).write(
      CharactersCompanion(isFavorite: Value(true)),
    );
  }

  @override
  Future<void> unsetFavorite(int id) async {
    final current = [..._charactersStreamController.value];
    final index = current.indexWhere((c) => c.id == id);

    if (index >= 0) {
      current[index] = current[index].copyWith(isFavorite: false);
      _charactersStreamController.add(current);
    }

    await (db.update(db.characters)..where((t) => t.id.equals(id))).write(
      CharactersCompanion(isFavorite: Value(false)),
    );
  }

  @override
  Future<List<Character>> getCharactersIds(List<int> ids) async {
    final query = await (db.select(
      db.characters,
    )..where((t) => t.id.isIn(ids))).get();

    return query.map(Character.fromEntity).toList();
  }

  @override
  Future<void> close() async {
    await _charactersStreamController.close();
  }
}
