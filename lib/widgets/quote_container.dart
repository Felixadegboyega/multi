import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multi/models/quote.dart';

class QuoteContainer extends StatefulWidget {
  const QuoteContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<QuoteContainer> createState() => _QuoteContainerState();
}

class _QuoteContainerState extends State<QuoteContainer> {
  late bool sm;
  int index = Random().nextInt(1640);

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 15), (timer) {
      setState(() {
        index = Random().nextInt(1640);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    sm = width < 600;

    return sm
        ? Stack(
            children: [
              backgroundImage(width, height),
              quoteText(context, width, height),
            ],
          )
        : Expanded(
            flex: 5,
            child: Stack(
              children: [
                backgroundImage(width, height),
                quoteText(context, width, height),
              ],
            ),
          );
  }

  FutureBuilder<String> quoteText(BuildContext context, width, height) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString("assets/quotes.json"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var json = jsonDecode(snapshot.data.toString()) as List;
            List<Quote> quotes = json.map((e) => Quote.fromJson(e)).toList();
            return Container(
              padding: const EdgeInsets.all(20),
              // height: 400,
              height: (!sm && height < 600) ? height - 140 : (height / 2) - 50,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    quotes[index].text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(quotes[index].author ?? '- -',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ],
              ),
            );
          } else {
            return const Text('- -');
          }
        });
  }

  Image backgroundImage(double width, double height) {
    return Image.asset(
      "assets/bg.jpg",
      color: Colors.black.withOpacity(0.7),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
          Container(
        color: Colors.blueGrey,
        child: child,
      ),
      colorBlendMode: BlendMode.colorBurn,
      width: sm ? double.infinity : width / 2,
      height: (!sm && height < 600) ? height - 140 : (height / 2) - 50,
      fit: BoxFit.cover,
    );
  }
}
