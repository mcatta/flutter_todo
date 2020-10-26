import 'package:flutter/material.dart';
import 'package:todo_list/blocs/TodoBloc.dart';
import 'package:todo_list/models/Todo.dart';

class TodoListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoListView> {
  @override
  Widget build(BuildContext context) {
    bloc.fetchTodos();

    return StreamBuilder(
      stream: bloc.allTodos,
      builder: (context, AsyncSnapshot<List<Todo>> snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void dispose() {
    bloc.dispose();
  }

  void _updateTodoState(Todo todo, bool state) {
    setState(() {
      bloc.updateTodo(todo, state);
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      bloc.deleteTodo(todo);
      _showSnackbar("TODO deleted");
    });
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget buildList(List<Todo> todols) {
    var listView = ListView(
        scrollDirection: Axis.vertical,
        children: todols.map((todo) {
          return Container(
              color: Colors.green[100],
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: Checkbox(
                              value: todo.done,
                              onChanged: (state) =>
                                  {_updateTodoState(todo, state)})),
                      Flexible(
                          flex: 10,
                          fit: FlexFit.tight,
                          child: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.done
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          )),
                      Flexible(
                        child: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteTodo(todo);
                          },
                        ),
                        flex: 1,
                      )
                    ],
                  )));
        }).toList());
    return listView;
  }
}
