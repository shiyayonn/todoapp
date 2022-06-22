import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static final SQLHelper _databaseHelper = SQLHelper._();

  SQLHelper._();

  late Database db;

  factory SQLHelper() {
    return _databaseHelper;
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        isCompleted BOOLEAN DEFAULT 0,
        title TEXT,
        details TEXT,
        dateCreated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        unique( title, details )
      )
      """);
  }
// id: the id of a item
// title, details: name and details of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'json.db'),
      onCreate: (database, version) async {
        await createTables(database);
      },
      version: 1,
    );
  }

  // Create new Todo
  Future<int> createItem(String title, String? details) async {
    final data = {'title': title, 'details': details};
    final id = await db.insert('todo', data);
    return id;
  }

  // Read all todo
  Future<List<Map<String, dynamic>>> getAllTodos() async {
    return db.query('todo', orderBy: "id");
  }

  // Read all incomplete todo
  Future<List<Map<String, dynamic>>> getIncompleteTodos() async {
    return db.query('todo', where: "isCompleted == 0");
  }

  // Read all incomplete todo
  Future<List<Map<String, dynamic>>> getCompleteTodos() async {
    return db.query('todo', where: "isCompleted == 1");
  }

  // Read a single todo by id
  Future<List<Map<String, dynamic>>> getTodo(int id) async {
    return db.query('todo', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an todo by id
  Future<int> updateItem(int id, String title, String? details) async {
    final data = {
      'title': title,
      'details': details,
      'dateCreated': DateTime.now().toString()
    };

    final result =
        await db.update('todo', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Update an item by id
  Future<int> updateTodoStatus(int id, int isCompleted) async {
    final data = {
      'isCompleted': isCompleted,
    };

    final result =
        await db.update('todo', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  Future<void> deleteItem(int id) async {
    try {
      await db.delete("todo", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
