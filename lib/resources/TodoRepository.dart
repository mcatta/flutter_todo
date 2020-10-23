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
    var searchedItem =
        _todoList.where((element) => element.id == todo.id).first;
    if (searchedItem != null) {
      _todoList.remove(searchedItem);
      return true;
    }

    return false;
  }

  Future<Todo> update(Todo todo) async {
    delete(todo);
    insert(todo);

    return todo;
  }
}
