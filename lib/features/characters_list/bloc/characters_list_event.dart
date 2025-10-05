import 'package:rick_and_morty_app/database/database.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

abstract class CharactersListEvent {}

class ChractersGetData extends CharactersListEvent {
  ChractersGetData();
}
