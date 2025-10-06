import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/core/database/db_provider.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_state.dart';

class FavoritesBLoC extends Bloc<FavoritesEvent, FavoritesPageState> {
  FavoritesBLoC() : super(FavoritesPageState.idle()) {
    on<GetFavoritesCharacters>((event, emit) async {
      var data = await GetIt.instance<DatabaseProviderImpl>()
          .getAllFavoritesCharacter();
      emit(FavoritesPageState.loaded(data));
    });
    on<DeleteCharacterFromFavorites>((event, emit) async {
      await GetIt.instance<DatabaseProviderImpl>().deleteCharacterFromFavorites(
        event.id,
      );
      if (state is LoadedState) {
        final currentState = state as LoadedState;
        final updatedList = List.of(currentState.characters)
          ..removeWhere((c) => c.id == event.id);
        emit(FavoritesPageState.loaded(updatedList));
      }
    });
  }
}
