class Todo {
  Todo(this.title);

  String title, id;

  bool done = false;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done ? 1 : 0,
    };
  }

  Todo.fromMap(Map<String, dynamic> data) {
    this.id = data['id'];
    this.title = data['title'];
    this.done = data['done'] == 1;
  }
}
