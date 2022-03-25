class Todo {
  String title;
  String timeAdded;
  bool done;
  String deadline;
  bool backedup = false;
  String email = "";

  Todo(
      {required this.title,
      required this.deadline,
      required this.timeAdded,
      this.done = false});

  factory Todo.fromJSON(Map<String, dynamic> json) {
    return Todo(
        title: json['title'],
        deadline: json['deadline'],
        timeAdded: json['timeAdded'],
        done: json['done']);
  }
}
