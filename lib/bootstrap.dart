import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/app/app.dart';
import 'package:rick_and_morty_app/app/app_observer.dart';
import 'package:rick_and_morty_app/core/characters_cache.dart';
import 'package:rick_and_morty_app/core/database/database.dart';
import 'package:rick_and_morty_app/core/database/db_provider.dart';
import 'package:talker/talker.dart';

Future<void> bootstrap() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final locator = GetIt.instance;
    final talker = Talker();

    final database = AppDatabase();
    final databaseProvider = DatabaseProviderImpl(db: database);

    Bloc.observer = AppObserver();
    Bloc.transformer = sequential();

    locator.registerSingleton(database);
    locator.registerSingleton(databaseProvider);
    locator.registerSingleton(talker);
    final cache = await CharactersCache.init();
    locator.registerSingleton(cache);
    runApp(const RickAndMortyApp());
  }, (error, st) {});
}
