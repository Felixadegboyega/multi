import 'package:flutter/material.dart';
import 'package:multi/Functions/app_bar.dart';
import 'package:multi/widgets/quote_container.dart';
import 'package:multi/widgets/tab_tile.dart';

class Lobby extends StatefulWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  State<Lobby> createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  late bool sm;
  late bool lg;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    sm = width < 600;
    lg = width > 1010;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget('Multi', lg, context),
      body: ListView(
          padding:
              EdgeInsets.symmetric(vertical: 12, horizontal: lg ? 100 : 15),
          children: [
            Flex(
                direction: sm ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const QuoteContainer(),
                  sm
                      ? tabColumn()
                      : Expanded(
                          flex: 5,
                          child: tabColumn(),
                        ),
                ])
          ]),
    );
  }

  Widget tabColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment:
          sm ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: const [
        TabWidget(
          index: 0,
          title: 'Todo',
          subtitle: 'Add, check, update and set time for your todos',
          color: Colors.blueAccent,
          icon: Icons.checklist_rtl_rounded,
        ),
        TabWidget(
          index: 1,
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
