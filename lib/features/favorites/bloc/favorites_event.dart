import 'package:rick_and_morty_app/features/favorites/favorites.dart';

abstract class FavoritesEvent {}

class GetFavoritesCharacters extends FavoritesEvent {
  GetFavoritesCharacters();
}

class DeleteCharacterFromFavorites extends FavoritesEvent {
  final int id;

  DeleteCharacterFromFavorites({required this.id});
}

class SortFavorites extends FavoritesEvent {
  final SortingTypes type;

  SortFavorites({required this.type});
}
