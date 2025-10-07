import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/core/database/db_provider.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_event.dart';
import 'package:rick_and_morty_app/features/characters/bloc/characters_state.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

class CharacterBLoC extends Bloc<CharactersListEvent, CharacterPageState> {
  CharacterBLoC() : super(CharacterPageState.idle()) {
    on<ChractersGetData>((event, emit) async {
      final repo = CharacterRepository();
      var response = await repo.getMultipleCharacters(event.ids);

      if (response.statusCode == 200) {
        var data = CharacterModel.listFromJson(jsonDecode(response.body));
        await GetIt.instance<DatabaseProviderImpl>().addCharacters(data);
        var ids = await GetIt.instance<DatabaseProviderImpl>()
            .getFavoritesIds();
        emit(CharacterPageState.loaded(data, ids));
      }
    });
    on<AddCharacterToFavorites>((event, emit) async {
      final db = GetIt.instance<DatabaseProviderImpl>();
      await db.addCharacterToFavorites(event.id);
    });
  }
}
