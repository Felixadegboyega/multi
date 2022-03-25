import 'package:flutter/material.dart';
import 'package:multi/pages/todo/new_todo.dart';
import 'package:multi/pages/todo/todos.dart';
import 'package:multi/widgets/template.dart';

class TodoIndex extends StatelessWidget {
  TodoIndex({Key? key}) : super(key: key);

  final List<Widget> routes = <Widget>[
    const Todos(),
    const NewTodo(),
  ];
  @override
  Widget build(BuildContext context) {
    return Template(routes: routes, name: "Todo");
  }
}
