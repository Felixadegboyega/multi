import 'package:flutter/material.dart';
import 'package:multi/Functions/app_bar.dart';
import 'package:multi/constants.dart';

class NewTodo extends StatelessWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lg = MediaQuery.of(context).size.width > 1010;
    return Scaffold(
      appBar: appBarWidget('New Todo', lg, context),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Add New Todo',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
                child: Column(children: [
              TextFormField(
                decoration: kInputDecoration('Todo Title'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  decoration: kInputDecoration('Set a due time'),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: kButtonStyle),
            ]))
          ],
        ),
      )),
    );
  }
}
