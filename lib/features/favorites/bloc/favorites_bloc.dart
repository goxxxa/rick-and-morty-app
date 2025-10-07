import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/core/database/database.dart';
import 'package:rick_and_morty_app/core/database/db_provider.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_state.dart';
import 'package:rick_and_morty_app/features/favorites/favorites.dart';

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
    on<SortFavorites>((event, emit) {
      if (state is LoadedState) {
        final currentState = state as LoadedState;
        var sortedList = <Character>[];
        switch (event.type) {
          case SortingTypes.byNameAsc:
            sortedList = List.of(currentState.characters)
              ..sort((a, b) => a.name.compareTo(b.name));
          case SortingTypes.byNameDesc:
            sortedList = List.of(currentState.characters)
              ..sort((a, b) => b.name.compareTo(a.name));
          case SortingTypes.byStatusAsc:
            sortedList = List.of(currentState.characters)
              ..sort((a, b) => a.status.compareTo(b.status));
          case SortingTypes.byStatusDesc:
            sortedList = List.of(currentState.characters)
              ..sort((a, b) => b.status.compareTo(a.status));
          case SortingTypes.bySpeciesAsc:
            sortedList = List.of(currentState.characters)
              ..sort((a, b) => a.species.compareTo(b.species));
          case SortingTypes.bySpeciesDesc:
            sortedList = List.of(currentState.characters)
              ..sort((a, b) => b.species.compareTo(a.species));
        }
        emit(FavoritesPageState.loaded(sortedList));
      }
    });
  }
}
