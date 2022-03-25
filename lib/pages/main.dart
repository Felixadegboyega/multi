import 'package:flutter/material.dart';
import 'package:multi/Functions/app_bar.dart';
import 'package:multi/pages/record/index.dart';
import 'package:multi/pages/todo/index.dart';

class Main extends StatefulWidget {
  Main({Key? key, required this.index}) : super(key: key);
  late int index;
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  static final List<Widget> _widgetOptions = <Widget>[
    TodoIndex(),
    RecordIndex(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Multi', false, context),
      body: _widgetOptions.elementAt(widget.index),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl_rounded),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: 'Record',
          ),
        ],
        currentIndex: widget.index,
        selectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}
