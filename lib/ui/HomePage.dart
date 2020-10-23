import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/blocs/TodoBloc.dart';
import 'package:todo_list/models/Todo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _TodoListState extends State<TodoList> {
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

  Widget buildList(List<Todo> todols) {
    var listView = ListView(
        scrollDirection: Axis.vertical,
        children: todols.map((e) {
          return Container(
              height: 50,
              color: Colors.green[100],
              child: Center(child: Text(e.title)));
        }).toList());
    return listView;
  }
}

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _HomePageState extends State<HomePage> {
  var _incremental = 0;

  void _addTodo() {
    setState(() {
      _incremental++;
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      bloc.addTodo("TODO N $_incremental");
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Add a todo',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
