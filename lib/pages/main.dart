import 'package:flutter/material.dart';
import 'package:multi/widgets/quoteContainer.dart';
import 'package:multi/widgets/tabTile.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late bool sm;
  late bool lg;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    sm = width < 600;
    lg = width > 1010;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          titleSpacing: lg ? 100 : null,
          elevation: 0,
          title: const Text('Multi'),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.blueGrey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 25)),
      body: GridView.count(
          // childAspectRatio: 1.15,
          reverse: sm ? true : false,
          padding:
              EdgeInsets.symmetric(vertical: 12, horizontal: lg ? 100 : 15),
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisCount: sm ? 1 : 2,
          // primary: false,
          children: [
            tabColumn(),
            quoteContainer(),
          ]),
    );
  }

  Widget tabColumn() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment:
          sm ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: const [
        TabWidget(
          title: 'Todo',
          subtitle: 'Add, check, update and set time for your todos',
          color: Colors.blueAccent,
          icon: Icons.checklist_rtl_rounded,
        ),
        TabWidget(
            title: 'Make budget',
            subtitle:
                'Set budget for instances, instance can be for a day, week, month or an event'),
        TabWidget(
          icon: Icons.my_library_books_outlined,
          title: 'Make A Record',
          subtitle:
              'Make a record of what you did and check history of added records',
          color: Colors.purple,
        ),
      ],
    );
  }
}
