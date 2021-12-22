import 'package:flutter/material.dart';
import 'package:multi/pages/todo/account.dart';

// class AppBarWidget extends StatelessWidget {
//   const AppBarWidget({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     bool lg = MediaQuery.of(context).size.width > 1010;

//     return AppBar(
//         iconTheme: const IconThemeData(color: Colors.blueGrey),
//         titleSpacing: lg ? 100 : null,
//         elevation: 0,
//         title: Text(title),
//         backgroundColor: Colors.white,
//         titleTextStyle: TextStyle(
//             color: Colors.blueGrey.shade600,
//             fontWeight: FontWeight.bold,
//             fontSize: 25),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 // initializeAccount();
//               },
//               style: ButtonStyle(
//                 minimumSize: MaterialStateProperty.resolveWith(
//                     (states) => const Size(100, 10)),
//                 // side: MaterialStateBorderSide.resolveWith(
//                 //     (states) => const BorderSide(width: 1))
//               ),
//               child: const Text(
//                 'Sync Now',
//                 style: TextStyle(color: Colors.blueGrey),
//               )),
//           Padding(
//             padding: EdgeInsets.only(right: lg ? 100 : 10),
//             child: IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.account_circle_rounded,
//                 size: 40,
//               ),
//             ),
//           )
//         ]);
//   }
// }

AppBar appBarWidget(String title, bool lg, BuildContext context) {
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
              Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return Account();
              }));
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
