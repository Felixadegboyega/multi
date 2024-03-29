import 'package:flutter/material.dart';
import 'package:multi/constants.dart';
import 'package:multi/pages/main.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    this.color = Colors.blueGrey,
    this.icon = Icons.list_alt,
  }) : super(key: key);

  final int index;
  final Color color;
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  late bool sm;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    sm = width < 600;
    return Container(
      width: sm ? double.infinity : 400,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: sm ? 0 : 10),
      decoration: tabTileDecoration,
      child: ListTile(
        onTap: () {
          tapTile(context);
        },
        minLeadingWidth: 10,
        leading: Icon(
          widget.icon,
          color: Colors.white,
          size: 30,
        ),
        minVerticalPadding: 10,
        tileColor: widget.color,
        title: Text(widget.title,
            style: TextStyle(
                fontSize: sm ? 20 : 25,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.subtitle,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade100),
          ),
        ),
      ),
    );
  }

  Future<void> tapTile(BuildContext context) {
    return Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      // return widget.page;
      return Main(index: widget.index);
    }));
  }
}
