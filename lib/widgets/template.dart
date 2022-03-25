import 'package:flutter/material.dart';

class Template extends StatefulWidget {
  const Template({Key? key, required this.routes, required this.name})
      : super(key: key);

  final List<Widget> routes;
  final String name;

  @override
  _TemplateState createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                navButton(0, '${widget.name}s'),
                navButton(1, 'New ${widget.name}'),
              ],
            )),
        widget.routes[activeIndex]
      ],
    );
  }

  TextButton navButton(int index, String text) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) =>
                ((activeIndex == index) ? Colors.blueGrey : Colors.white))),
        onPressed: () {
          setState(() {
            activeIndex = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
              color: activeIndex == index ? Colors.white : Colors.blueGrey),
        ));
  }
}
