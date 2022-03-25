import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addTodo(text) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> todo = {
    "title": text,
    "deadline": "",
    "timeAdded": DateTime.now().toString(),
    "done": false,
    "backedup": false,
    "email": ""
  };
  var jsonTodos = prefs.getString('todos');
  if (jsonTodos != null) {
    List todos = jsonDecode(jsonTodos) as List;
    todos.add(todo);
    prefs.setString('todos', jsonEncode(todos));
  } else {
    List todos = [todo];
    prefs.setString('todos', jsonEncode(todos));
  }
  return true;
}

Future<List> fetchTodo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonTodos = prefs.getString('todos');
  if (jsonTodos != null) {
    var decodedTodos = jsonDecode(jsonTodos) as List;
    return decodedTodos;
  } else {
    return [];
  }
}

changeTodoStatus(index, todo) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonTodos = prefs.getString('todos');
  if (jsonTodos != null) {
    List todos = jsonDecode(jsonTodos) as List;
    for (var i = 0; i < todos.length; i++) {
      if (index == i) {
        todos.replaceRange(index, index + 1, [
          {...todos[index], 'done': !todos[index]['done']}
        ]);
      }
    }
    prefs.setString('todos', jsonEncode(todos));
    return true;
  }
}

deleteTodo(List<int> toBeDeletedIndexArray) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jsonTodos = prefs.getString('todos');
  if (jsonTodos != null) {
    List todos = jsonDecode(jsonTodos) as List;
    for (var i = 0; i < toBeDeletedIndexArray.length; i++) {
      todos.removeAt(toBeDeletedIndexArray[i]);
    }
    prefs.setString('todos', jsonEncode(todos));
    return true;
  }
}
