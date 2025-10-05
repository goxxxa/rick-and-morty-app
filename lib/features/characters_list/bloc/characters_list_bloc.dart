import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters_list/bloc/characters_list_event.dart';
import 'package:rick_and_morty_app/features/characters_list/bloc/characters_list_state.dart';
import 'package:rick_and_morty_app/repositories/character_repository.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

class CharacterBLoC extends Bloc<CharactersListEvent, CharacterPageState> {
  CharacterBLoC() : super(CharacterPageState.idle()) {
    on<ChractersGetData>((event, emit) async {
      final repo = CharacterRepository();
      var response = await repo.getData();
      if (response.statusCode == 200) {
        var data = CharacterModel.listFromJson(jsonDecode(response.body));
        emit(CharacterPageState.loaded(data));
      }
    });
  }
}
