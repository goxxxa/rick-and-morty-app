import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/repositories/models.dart';

part 'database.g.dart';

typedef OriginColumn = Column<Origin>;
typedef LocationColumn = Column<Location>;

class Characters extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();
  // OriginColumn get origin => text()();
  TextColumn get image => text()();
  BlobColumn get episode => blob()();
  TextColumn get created => text()();
}

class Favorites extends Table {
  IntColumn get id => integer()();
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
