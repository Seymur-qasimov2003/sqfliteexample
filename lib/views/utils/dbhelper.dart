import 'package:fluttersqlite/model/personmodel.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;

  static Future<void> initDb() async {
    if (_db != null) {
      print('Database already initialized');
      return;
    }
    try {
      String path = await getDatabasesPath() + 'my_db.db';
      print('Database path: $path');
      _db = await openDatabase(path, version: 1, onCreate: onCreate);
    } catch (e) {
      print(e);
    }
  }

  ///onCreate
  static Future<void> onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE persons (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
  }

  ///insert
  static Future<int> insert(String table, PersonModel model) async {
    return await _db!.insert(table, model.toJson());
  }
  ///delete
  static Future<int> delete(String table, int id) async {
    return await _db!.delete(table, where: 'id = ?', whereArgs: [id]);
  }
  ///update
  static Future<int> update(String table, PersonModel model) async {
    return await _db!.update(table, model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);
  }
  ///get
  static Future<List<PersonModel>> get(String table) async {
    List<Map<String, dynamic>> result = await _db!.query(table);
    return result.map((e) => PersonModel.fromJson(e)).toList();
  }
  ///close
  static Future<void> close() async {
    await _db!.close();
  }
}
