import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Locations extends Table {
  IntColumn get id => integer()();
  TextColumn get url => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Origins extends Table {
  IntColumn get id => integer()();
  TextColumn get url => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Characters extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();
  // IntColumn get origin => integer().references(Origins, #id)();
  // IntColumn get location => integer().references(Locations, #id)();
  TextColumn get image => text()();
  BlobColumn get episode => blob()();
  TextColumn get created => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class Favorites extends Table {
  IntColumn get id => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [Characters, Favorites])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
