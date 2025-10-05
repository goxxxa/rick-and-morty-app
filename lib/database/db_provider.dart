import 'package:rick_and_morty_app/database/database.dart';

abstract interface class DatabaseProvider {
  Future<void> addCharacter();
  Future<void> getCharacter();
  Future<void> deleteCharacter();
  Future<int> updateCharacter();

  Future<void> addCharacterToFavorites(int characterId);
  Future<void> getAllFavoritesCharacter();
}

class DatabaseProviderImpl implements DatabaseProvider {
  final AppDatabase db;

  DatabaseProviderImpl({required this.db});

  @override
  Future<void> addCharacter() {
    // TODO: implement addCharacter
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCharacter() {
    // TODO: implement deleteCharacter
    throw UnimplementedError();
  }

  @override
  Future<void> getCharacter() {
    // TODO: implement getCharacter
    throw UnimplementedError();
  }

  @override
  Future<int> updateCharacter() {
    // TODO: implement updateCharacter
    throw UnimplementedError();
  }

  @override
  Future<void> addCharacterToFavorites(int characterId) async {
    await (db.into(db.favorites).insert(Favorite(id: characterId)));
  }

  @override
  Future<List<Character>> getAllFavoritesCharacter() async {
    final List<int> ids = await (db.select(db.favorites).get()) as List<int>;
    List<Character> result = <Character>[];
    for (final id in ids) {
      result.add(
        (await (db.select(
          db.characters,
        )..where((t) => t.id.equals(id))).getSingle()),
      );
    }
    return result;
  }
}
