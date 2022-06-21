import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        isCompleted BOOLEAN DEFAULT FALSE,
        title TEXT,
        details TEXT,
        dateCreated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, details: name and details of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'json.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new Todo
  static Future<int> createItem(String title, String? details) async {
    final db = await SQLHelper.db();

    final data = {'title': title, 'details': details};
    final id = await db.insert('todo', data);
    return id;
  }

  // Read all todo
  static Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await SQLHelper.db();
    return db.query('todo', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getTodo(int id) async {
    final db = await SQLHelper.db();
    return db.query('todo', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String title, String? details) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'details': details,
      'dateCreated': DateTime.now().toString()
    };

    final result =
        await db.update('todo', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("todo", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
