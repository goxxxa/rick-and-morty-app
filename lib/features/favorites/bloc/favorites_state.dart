import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesPageState with _$FavoritesPageState {
  const FavoritesPageState._();
  const factory FavoritesPageState.processing() = ProcessingState;
  const factory FavoritesPageState.idle() = IdleState;
  const factory FavoritesPageState.loaded(List<Character> characters) =
      LoadedState;
  const factory FavoritesPageState.empty() = EmptyState;
  const factory FavoritesPageState.error(String message) = ErrorState;
}
