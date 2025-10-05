import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/database/database.dart';
import 'package:rick_and_morty_app/rick_and_morty_app.dart';

void main() {
  final locator = GetIt.instance;
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  locator.registerSingleton(database);
  runApp(const RickAndMortyApp());
}
