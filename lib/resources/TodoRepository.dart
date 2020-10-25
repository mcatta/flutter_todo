import 'package:uuid/uuid.dart';

import '../models/Todo.dart';

class TodoRepository {
  var uuid = Uuid();
  List<Todo> _todoList = [];

  Future<Todo> insert(Todo todo) async {
    if (todo.id == null) {
      todo.id = uuid.v4();
    }
    _todoList.add(todo);
    return todo;
  }

  Future<List<Todo>> getAll() async {
    return _todoList;
  }

  Future<bool> delete(Todo todo) async {
    var position = _todoList.indexOf(todo);
    if (position >= 0) {
      _todoList.removeAt(position);
      return true;
    }

    return false;
  }

  Future<Todo> update(Todo todo) async {
    var position = _todoList.indexOf(todo);
    _todoList[position].done = todo.done;
    _todoList[position].title = todo.title;

    return todo;
  }
}
