import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_event.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_state.dart';
import 'package:rick_and_morty_app/repositories/characters/characters_repository.dart';
import 'package:rick_and_morty_app/repositories/characters/model/character.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc({required CharactersRepository repository})
    : _repository = repository,
      super(const CharactersState.idle()) {
    on<LoadInitialCharacters>(_onInitialLoad);
    on<LoadMoreCharacters>(_onLoadMore);
    on<RefreshCharactersData>(_onRefresh);
    on<AddCharacterToFavorites>(_onToggleFavorite);
  }

  final CharactersRepository _repository;
  StreamSubscription<List<Character>>? _subscription;

  Future<void> _onInitialLoad(
    LoadInitialCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(const CharactersState.processing());
    await _repository.loadMore(0, 20);
    await _subscribeToStream(emit);
  }

  Future<void> _onLoadMore(
    LoadMoreCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    final start = event.count;
    await _repository.loadMore(start - 10, 10);
  }

  Future<void> _onRefresh(
    RefreshCharactersData event,
    Emitter<CharactersState> emit,
  ) async {
    emit(const CharactersState.processing());
    Future.delayed(Duration(seconds: 1));
    await _subscribeToStream(emit);
  }

  Future<void> _onToggleFavorite(
    AddCharacterToFavorites event,
    Emitter<CharactersState> emit,
  ) async {
    final character = event.character;
    if (character.isFavorite) {
      await _repository.unsetFavorite(character.id);
    } else {
      await _repository.setFavorite(character.id);
    }
  }

  Future<void> _subscribeToStream(Emitter<CharactersState> emit) async {
    await _subscription?.cancel();
    await emit.forEach<List<Character>>(
      _repository.charactersStream,
      onData: (characters) => characters.isEmpty
          ? const CharactersState.empty()
          : CharactersState.loaded(characters),
      onError: (_, __) => CharactersState.error(),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
