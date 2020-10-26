import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../models/Todo.dart';

class TodoRepository {
  static const tableTofido = "tbTodo";

  Future<Database> _db() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'todos_database.db'),

      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE $tableTodo(id TEXT PRIMARY KEY, title TEXT, done INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  var uuid = Uuid();

  Future<Todo> insert(Todo todo) async {
    if (todo.id == null) {
      todo.id = uuid.v4();
    }
    final Database database = await _db();
    await database.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<List<Todo>> getAll() async {
    final Database database = await _db();
    final List<Map<String, dynamic>> maps =
        await database.query(tableTodo, orderBy: 'done');

    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<void> delete(Todo todo) async {
    final Database database = await _db();

    await database.delete(tableTodo, where: "id = ?", whereArgs: [todo.id]);
  }

  Future<void> update(Todo todo) async {
    final Database database = await _db();

    await database
        .update(tableTodo, todo.toMap(), where: "id = ?", whereArgs: [todo.id]);
  }
}
