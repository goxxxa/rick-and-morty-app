import 'package:rick_and_morty_app/repositories/characters/model/character.dart';

/// The interface for an API that provides access to a list of characters.
abstract class CharacterApi {
  const CharacterApi();

  /// Provides a [Stream] of all characters.
  Stream<List<Character>> get getCharacters;

  Stream<List<Character>> get getFavorites;

  /// Saves a [Character]
  ////
  ///
  Future<void> saveCharacter(Character character);

  Future<void> deleteCharacter(int id);

  // Future<List<Character>> getCharacters();

  Future<void> setFavorite(int id);

  Future<void> unsetFavorite(int id);

  Future<List<Character>> getCharactersIds(List<int> ids);

  Future<void> loadMore(int offset, int limit);

  Future<void> close();
}
