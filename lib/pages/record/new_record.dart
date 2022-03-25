import 'package:flutter/material.dart';
import 'package:multi/Functions/record.dart';
import 'package:multi/constants.dart';

class NewRecord extends StatefulWidget {
  const NewRecord({Key? key}) : super(key: key);
  @override
  State<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
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
                  decoration: kInputDecoration('Record Title'),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  controller: noteController,
                  decoration: kInputDecoration('Note'),
                )),
            TextButton(
                onPressed: () async {
                  setState(() {
                    isAdding = true;
                  });
                  if (await addRecord(
                      titleController.text, noteController.text)) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(kSnackBar('New Record added!'));
                  }
                  setState(() {
                    titleController.clear();
                    noteController.clear();
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
