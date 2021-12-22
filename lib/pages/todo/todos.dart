import 'package:flutter/material.dart';
import 'package:multi/Functions/app_bar.dart';

class Todos extends StatelessWidget {
  Todos({Key? key}) : super(key: key);

  final List<Map> todos = [
    {'name': 'Read1'},
    {'name': 'Read2'},
    {'name': 'Read3'}
  ];
  @override
  Widget build(BuildContext context) {
    bool lg = MediaQuery.of(context).size.width > 1010;
    return Scaffold(
      appBar: appBarWidget('My Todos', lg, context),
      body: todoList(),
    );
  }

  Padding todoList() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
          itemCount: todos.length * 2,
          itemBuilder: (BuildContext context, int index) {
            if (index.isOdd) {
              return const Divider();
            }
            final int i = index ~/ 2;
            return ListTile(
              title: Text(todos[i]['name']),
            );
          }),
    );
  }

  Center emptyTodoWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.checklist_rtl_rounded,
            color: Colors.blueGrey,
            size: 80,
          ),
          Text('Empty, you will see your added todos here.')
        ],
      ),
    );
  }
}
