import 'package:flutter/material.dart';
import 'package:multi/Functions/todo.dart';
import 'package:multi/constants.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({Key? key}) : super(key: key);
  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  TextEditingController titleController = TextEditingController();
  bool isAdding = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
              child: Column(children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: titleController,
                  decoration: kInputDecoration('Todo Title'),
                )),
            TextButton(
                onPressed: () async {
                  setState(() {
                    isAdding = true;
                  });
                  if (await addTodo(titleController.text)) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(kSnackBar('New Todo added!'));
                  }
                  setState(() {
                    titleController.clear();
                    isAdding = false;
                  });
                },
                child: Text(
                  isAdding ? 'Adding...' : 'Add',
                  style: const TextStyle(color: Colors.white),
                ),
                style: kButtonStyle),
          ]))
        ],
      ),
    ));
  }
}
