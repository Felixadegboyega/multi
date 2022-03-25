import 'package:flutter/material.dart';
import 'package:multi/pages/account.dart';

AppBar appBarWidget(String title, bool lg, BuildContext context,
    {bool showAccount = true}) {
  return AppBar(
      iconTheme: const IconThemeData(color: Colors.blueGrey),
      titleSpacing: lg ? 100 : null,
      elevation: 0,
      title: Text(title),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.blueGrey.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 25),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: lg ? 100 : 10),
          child: IconButton(
            onPressed: () {
              if (showAccount) {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return const Account();
                }));
              }
            },
            icon: const Icon(
              Icons.account_circle_rounded,
              size: 40,
            ),
          ),
        )
      ]);
}

// void initializeAccount() => print('d');
