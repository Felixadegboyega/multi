import 'package:flutter/material.dart';
import 'package:multi/pages/record/new_record.dart';
import 'package:multi/pages/record/records.dart';
import 'package:multi/widgets/template.dart';

class RecordIndex extends StatelessWidget {
  RecordIndex({Key? key}) : super(key: key);
  final List<Widget> routes = [
    const Records(),
    const NewRecord(),
  ];
  @override
  Widget build(BuildContext context) {
    return Template(routes: routes, name: "Record");
  }
}
