import 'package:multi/Functions/record.dart';
import 'package:multi/Functions/todo.dart';

backupTodos(email) async {
  List todos = await fetchTodo();
  todos = todos.map((e) {
    if (!e["backedup"]) {
      e["email"] = email;
      return e;
    }
  }).toList();
  print(todos);
}

backupRecords(email) async {
  List records = await fetchRecord();
  print(records);
}
