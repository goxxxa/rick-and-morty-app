import 'package:http/http.dart' as http;

abstract interface class AbstractCharacterRepo {
  Future<http.Response> getAllCharacters();
  Future<http.Response> getSingleCharacter(int characterId);
  Future<http.Response> getMultipleCharacters(List<int> ids);
  Future<http.Response> getFilteredCharacters();

  Future<http.Response> getAllLocations();
  Future<http.Response> getSingleLocation(int locationId);
  Future<http.Response> getMultipleLocations();
  Future<http.Response> getFilteredLocations();

  Future<http.Response> getAllEpisodes();
  Future<http.Response> getSingleEpisode(int locationId);
  Future<http.Response> getMultipleEpisodes();
  Future<http.Response> getFilteredEpisodes();
}

class CharacterRepo implements AbstractCharacterRepo {
  final String mainUrl = 'https://rickandmortyapi.com/api/character/';
  final http.Client _client = http.Client();

  int lastIndex = 0;

  @override
  Future<http.Response> getAllCharacters() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getAllEpisodes() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getAllLocations() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getFilteredCharacters() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getFilteredEpisodes() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getFilteredLocations() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getMultipleCharacters(List<int> ids) async {
    if (ids.isEmpty) return http.Response('', 404);

    final joinedIds = ids.join(',');

    final responce = await _client.get(Uri.parse('$mainUrl$joinedIds'));
    return responce;
  }

  @override
  Future<http.Response> getMultipleEpisodes() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getMultipleLocations() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getSingleCharacter(int characterId) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getSingleEpisode(int locationId) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> getSingleLocation(int locationId) {
    throw UnimplementedError();
  }
}
