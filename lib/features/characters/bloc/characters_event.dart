import 'package:rick_and_morty_app/repositories/characters/model/character.dart';

abstract class CharactersEvent {}

class LoadInitialCharacters extends CharactersEvent {}

class LoadMoreCharacters extends CharactersEvent {
  final int count;

  LoadMoreCharacters({required this.count});
}

class AddCharacterToFavorites extends CharactersEvent {
  final Character character;

  AddCharacterToFavorites({required this.character});
}

class RefreshCharactersData extends CharactersEvent {}
