import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/api/remote_api/api_client.dart';
import 'package:rick_and_morty_app/app/app.dart';
import 'package:rick_and_morty_app/app/app_bloc_observer.dart';
import 'package:rick_and_morty_app/core/database/database.dart';
import 'package:rick_and_morty_app/api/local_api/local_storage_character_api.dart';
import 'package:rick_and_morty_app/repositories/characters/characters.dart';
import 'package:talker/talker.dart';

Future<void> bootstrap() async {
  final talker = Talker();
  FlutterError.onError = (details) {
    talker.error(details.exceptionAsString(), details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    talker.error(error.toString(), stack);
    return true;
  };

  final locator = GetIt.instance;
  locator.registerSingleton(talker);

  Bloc.observer = AppObserver();
  Bloc.transformer = sequential();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  final db = AppDatabase();
  final localApi = LocalStorageCharacterApi(db: db);
  final remoteApi = RickAndMortyApiClient();

  final repository = CharactersRepository(
    localApi: localApi,
    remoteApi: remoteApi,
  );

  runApp(App(createCharactersRepository: () => repository));
}
