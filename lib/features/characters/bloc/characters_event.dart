abstract class CharactersListEvent {}

class ChractersGetData extends CharactersListEvent {
  final List<int> ids;

  ChractersGetData({List<int>? ids})
    : ids = ids ?? List<int>.generate(10, (index) => index + 1);
}

class AddCharacterToFavorites extends CharactersListEvent {
  final int id;

  AddCharacterToFavorites({required this.id});
}
