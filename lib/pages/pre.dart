import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi/pages/index.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loaded = false;
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        loaded = true;
      });
      timer.cancel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loaded
        ? const Lobby()
        : Scaffold(
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool sm = constraints.maxWidth < 600;
                return Container(
                  color: Colors.blueGrey.shade600,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Multi',
                        style: TextStyle(
                            fontSize: sm ? 30 : 60, color: Colors.white),
                      ),
                      SizedBox(
                        width: sm ? 70 : 130,
                        child: const LinearProgressIndicator(
                            backgroundColor: Colors.white,
                            color: Colors.grey,
                            minHeight: 6),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
