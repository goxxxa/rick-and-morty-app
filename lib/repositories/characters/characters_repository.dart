import 'package:rick_and_morty_app/api/remote_api/api_client.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';
import 'package:rick_and_morty_app/api/local_api/character_api.dart';

class CharactersRepository {
  CharactersRepository({
    required CharacterApi localApi,
    required RickAndMortyApiClient remoteApi,
  }) : _localApi = localApi,
       _remoteApi = remoteApi;

  final CharacterApi _localApi;
  final RickAndMortyApiClient _remoteApi;

  Stream<List<Character>> get charactersStream => _localApi.getCharacters;

  Stream<List<Character>> get favoritesStream => _localApi.getFavorites;

  Future<void> loadMore(int offset, int limit) async {
    final ids = List.generate(limit, (i) => offset + i + 1);

    final localCharacters = await _localApi.getCharactersIds(ids);
    final localIds = localCharacters.map((c) => c.id).toSet();

    final missingIds = ids.where((id) => !localIds.contains(id)).toList();

    if (missingIds.isEmpty) {
      _localApi.loadMore(offset, limit);
      return;
    }

    final remoteCharacters = await _remoteApi.getCharacters(missingIds);

    for (final character in remoteCharacters) {
      await _localApi.saveCharacter(character);
    }
  }

  Future<void> setFavorite(int id) => _localApi.setFavorite(id);

  Future<void> unsetFavorite(int id) => _localApi.unsetFavorite(id);
}
