import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';

class RickAndMortyApiClient {
  RickAndMortyApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  static const String _baseUrlCharacters =
      'https://rickandmortyapi.com/api/character/';

  final http.Client _httpClient;

  /// Gets List of [Character]`
  Future<List<Character>> getCharacters(List<int> ids) async {
    final joinedIds = ids.join(',');

    final charactersResponce = await _httpClient.get(
      Uri.parse('$_baseUrlCharacters$joinedIds'),
    );

    if (charactersResponce.statusCode != 200) {
      throw CharactersRequestsFailure();
    }

    final charactersJson = jsonDecode(charactersResponce.body) as List;

    if (charactersJson.isEmpty) {
      throw CharactersNotFoundFailure();
    }

    final results = charactersJson
        .map((json) => Character.fromJson(json))
        .toList();
    return results;
  }

  void close() => _httpClient.close();
}

class CharactersRequestsFailure implements Exception {}

class CharactersNotFoundFailure implements Exception {}
