import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/core/database/db_provider.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

class CacheCharacterModel extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final int imageId;

  const CacheCharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.imageId,
  });

  @override
  List<Object?> get props => [id, name, status, species, type, gender, imageId];
}

class CharactersCache {
  final _cache = <int, CharacterModel>{};

  CharactersCache._();

  static Future<CharactersCache> init() async {
    final cache = CharactersCache._();

    final characters = await GetIt.instance<DatabaseProviderImpl>()
        .getAllCharacters();

    for (final character in characters) {
      cache._cache[character.id] = CharacterModel(
        id: character.id,
        name: character.name,
        status: character.status,
        species: character.species,
        type: character.type,
        gender: character.gender,
        image: character.image,
        created: character.created,
        origin: null,
        location: null,
        url: '',
        episode: [],
      );
    }

    return cache;
  }

  CharacterModel? get(int term) => _cache[term];

  void set(int term, CharacterModel result) => _cache[term] = result;

  bool contains(int term) => _cache.containsKey(term);

  void remove(int term) => _cache.remove(term);

  void close() {
    _cache.clear();
  }
}
