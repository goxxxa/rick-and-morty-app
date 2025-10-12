import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';
import 'package:rick_and_morty_app/features/favorites/favorites.dart';

abstract class FavoritesEvent extends Equatable {}

class LoadFavoritesCharacters extends FavoritesEvent {
  LoadFavoritesCharacters();

  @override
  List<Object?> get props => [];
}

class Request extends FavoritesEvent {
  Request();

  @override
  List<Object?> get props => [];
}

class DeleteCharacterFromFavorites extends FavoritesEvent {
  final int id;

  DeleteCharacterFromFavorites({required this.id});

  @override
  List<Object?> get props => [id];
}

class SortFavorites extends FavoritesEvent {
  final SortingTypes type;

  SortFavorites({required this.type});

  @override
  List<Object?> get props => [type];
}

class UndoDeleteCharacter extends FavoritesEvent {
  final Character character;

  UndoDeleteCharacter({required this.character});

  @override
  List<Object?> get props => [character];
}
