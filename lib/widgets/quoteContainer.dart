import 'package:flutter/material.dart';

class quoteContainer extends StatelessWidget {
  quoteContainer({
    Key? key,
  }) : super(key: key);

  late bool sm;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    sm = width < 600;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Image.asset(
        "assets/bg.jpg",
        color: Colors.black.withOpacity(0.5),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
            Container(
          color: Colors.blueGrey,
          child: child,
        ),
        colorBlendMode: BlendMode.colorBurn,
        width: 100,
        height: 100,
        // width: sm ? double.infinity : width / 2,
        // height: (!sm && height < 600) ? height - 140 : (height / 2) - 50,
        fit: BoxFit.cover,
      ),
    );
  }
}
