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

  void addTodo(String title) {
    _todoRepository.insert(Todo(title));
  }
}

final bloc = TodoBloc();
