import 'package:rxdart/rxdart.dart';
import 'package:todo_list/models/Todo.dart';

import '../resources/TodoRepository.dart';

class TodoBloc {
  final _todoRepository = TodoRepository();
  final _todosFetcher = PublishSubject<List<Todo>>();

  Stream<List<Todo>> get allTodos => _todosFetcher.stream;

  void fetchTodos() async {
    List<Todo> todos = await _todoRepository.getAll();
    _todosFetcher.sink.add(todos);
  }

  void dispose() => _todosFetcher.close();

  void addTodo(String title) async {
    await _todoRepository.insert(Todo(title));
  }

  void updateTodo(Todo todo, bool state) async {
    todo.done = state;
    await _todoRepository.update(todo);
  }

  void deleteTodo(Todo todo) async => await _todoRepository.delete(todo);
}

final bloc = TodoBloc();
