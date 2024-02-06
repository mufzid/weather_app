import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ToggleDatabase {
  static const String tableName = 'toggleState';
  static const String columnId = 'id';
  static const String columnToggleState = 'toggleState';

  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'toggle_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE IF NOT EXISTS $tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnToggleState INTEGER
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<void> saveToggleState(bool toggleState) async {
    await _database.insert(
      tableName,
      {
        columnToggleState: toggleState ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> getToggleState() async {
    final List<Map<String, dynamic>> maps = await _database.query(tableName);

    if (maps.isNotEmpty) {
      return maps.first[columnToggleState] == 1;
    } else {
      return false; // Default value if no toggle state is saved
    }
  }
}
