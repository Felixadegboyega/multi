import 'package:flutter/material.dart';
import 'package:multi/Functions/todo.dart';
import 'package:multi/constants.dart';
import 'package:multi/models/todo.dart';

class Todos extends StatefulWidget {
  const Todos({Key? key}) : super(key: key);

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: FutureBuilder(
            future: fetchTodo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as List;
                List<Todo> todos = data.map((e) => Todo.fromJSON(e)).toList();
                if (todos.isNotEmpty) {
                  return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildTodoTile(index, todos, data);
                      });
                } else {
                  return emptyTodoWidget();
                }
              } else {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.blueGrey));
              }
            }),
      ),
    );
  }

  Widget buildTodoTile(int index, List<Todo> decodedTodos, List todos) {
    return Container(
      decoration: tabTileDecoration.copyWith(color: Colors.white),
      margin: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              setState(() {
                changeTodoStatus(index, todos[index]);
              });
            },
            icon: decodedTodos[index].done
                ? const Icon(Icons.check_box_outlined, color: Colors.blueGrey)
                : const Icon(Icons.check_box_outline_blank_outlined)),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          // IconButton(
          //     onPressed: () {},
          //     splashRadius: 20,
          //     icon: Icon(Icons.edit, color: Colors.blue[300])),
          IconButton(
              onPressed: () {
                setState(() {
                  deleteTodo([index]);
                });
              },
              splashRadius: 20,
              icon: Icon(Icons.delete_outline_rounded, color: Colors.red[800])),
        ]),
        title: Text(decodedTodos[index].title),
      ),
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
