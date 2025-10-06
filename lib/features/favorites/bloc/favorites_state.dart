import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rick_and_morty_app/core/database/database.dart';

part 'favorites_state.freezed.dart';

@Freezed()
sealed class FavoritesPageState with _$FavoritesPageState {
  const FavoritesPageState._();
  const factory FavoritesPageState.processing() = ProcessingState;
  const factory FavoritesPageState.idle() = IdleState;
  const factory FavoritesPageState.loaded(List<Character> characters) =
      LoadedState;
}
