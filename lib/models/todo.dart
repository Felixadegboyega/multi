class Todo {
  String name;
  String timeAdded;
  bool done;
  String deadline;

  Todo(
      {required this.name,
      required this.deadline,
      required this.timeAdded,
      required this.done});

  factory Todo.fromJSON(Map<String, dynamic> json) {
    return Todo(
        name: json['name'],
        deadline: json['deadline'],
        timeAdded: json['timeAdded'],
        done: json['done']);
  }
}
