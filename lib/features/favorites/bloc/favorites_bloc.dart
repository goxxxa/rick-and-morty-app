import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_event.dart';
import 'package:rick_and_morty_app/features/favorites/bloc/favorites_state.dart';
import 'package:rick_and_morty_app/features/favorites/favorites.dart';
import 'package:rick_and_morty_app/repositories/characters/characters_repository.dart';

class FavoritesBLoC extends Bloc<FavoritesEvent, FavoritesPageState> {
  FavoritesBLoC({required CharactersRepository repository})
    : _repository = repository,
      super(FavoritesPageState.idle()) {
    on<LoadFavoritesCharacters>(_onInitialLoad);
    on<Request>(_onSubscriptionRequested);

    on<DeleteCharacterFromFavorites>((event, emit) async {
      _repository.unsetFavorite(event.id);
    });
    on<SortFavorites>((event, emit) async {
      emit(FavoritesPageState.processing());

      final characters = await _repository.charactersStream.first;
      final favorites = characters.where((c) => c.isFavorite).toList();

      if (favorites.isEmpty) {
        emit(FavoritesPageState.empty());
        return;
      }

      List<Character> sortedList = List.of(favorites);
      switch (event.type) {
        case SortingTypes.byNameAsc:
          sortedList.sort((a, b) => a.name.compareTo(b.name));
          break;
        case SortingTypes.byNameDesc:
          sortedList.sort((a, b) => b.name.compareTo(a.name));
          break;
        case SortingTypes.byStatusAsc:
          sortedList.sort((a, b) => a.status.compareTo(b.status));
          break;
        case SortingTypes.byStatusDesc:
          sortedList.sort((a, b) => b.status.compareTo(a.status));
          break;
        case SortingTypes.bySpeciesAsc:
          sortedList.sort((a, b) => a.species.compareTo(b.species));
          break;
        case SortingTypes.bySpeciesDesc:
          sortedList.sort((a, b) => b.species.compareTo(a.species));
          break;
      }

      emit(FavoritesPageState.loaded(sortedList));
    });
  }

  final CharactersRepository _repository;
  StreamSubscription<List<Character>>? _subscription;

  Future<void> _onSubscriptionRequested(
    Request event,
    Emitter<FavoritesPageState> emit,
  ) async {
    emit(FavoritesPageState.processing());

    await _subscription?.cancel();
    await emit.forEach<List<Character>>(
      _repository.charactersStream,
      onData: (characters) {
        final favorites = characters.where((c) => c.isFavorite).toList();
        if (favorites.isEmpty) return EmptyState();
        return FavoritesPageState.loaded(favorites);
      },
      onError: (_, __) => FavoritesPageState.idle(),
    );
  }

  Future<void> _onInitialLoad(
    LoadFavoritesCharacters event,
    Emitter<FavoritesPageState> emit,
  ) async {}
}
