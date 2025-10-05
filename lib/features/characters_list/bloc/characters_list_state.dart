import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

part 'characters_list_state.freezed.dart';

@Freezed()
class CharacterPageState with _$CharacterPageState {
  const CharacterPageState._();
  const factory CharacterPageState.processing() = ProcessingState;
  const factory CharacterPageState.idle() = IdleState;
  const factory CharacterPageState.loaded(List<CharacterModel> characters) = LoadedState;
}