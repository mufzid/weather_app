import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/src/models/user_data_model.dart';

class UserDataHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return database;
  }

  Future<Database?> initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY,
          first_name TEXT,
          last_name TEXT,
          email TEXT
)

''');
    });
  }

  Future<void> insertUser(User user) async {
    final Database? db = await database;
    if (db != null) {
      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<User>> getUsers() async {
    final Database? db = await database;
    final List<Map<String, dynamic>> maps = await db?.query('users') ?? [];

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        firstName: maps[i]['first_name'],
        lastName: maps[i]['last_name'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> deleteUser(int userId) async {
    final Database? db = await database;
    if (db != null) {
      await db.delete('users', where: 'id = ?', whereArgs: [userId]);
    }
  }
}
