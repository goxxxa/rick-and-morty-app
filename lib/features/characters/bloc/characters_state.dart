import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';

part 'characters_state.freezed.dart';

@freezed
class CharactersState with _$CharactersState {
  const factory CharactersState.idle() = IdleState;
  const factory CharactersState.processing() = ProcessingState;
  const factory CharactersState.loaded(List<Character> characters) =
      LoadedState;
  const factory CharactersState.empty() = EmptyState;
  const factory CharactersState.error() = ErrorState;
}
