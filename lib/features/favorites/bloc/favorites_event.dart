abstract class FavoritesEvent {}

class GetFavoritesCharacters extends FavoritesEvent {
  GetFavoritesCharacters();
}

class DeleteCharacterFromFavorites extends FavoritesEvent {
  final int id;

  DeleteCharacterFromFavorites({required this.id});
}
