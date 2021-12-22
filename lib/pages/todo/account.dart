import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:multi/Functions/app_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyD2Nchj6ZSafCTfClnYFx2x3I5LKmJpqxk",
      //     appId: "1:390937159710:android:ba0ee2d0c3d52a20b1a60f",
      //     messagingSenderId:
      //         "390937159710-6fe7n1p781sron9b5re9j8qetc6cqb3k.apps.googleusercontent.com",
      //     projectId: "practise-5e196",
      //     databaseURL: "https://practise-5e196-default-rtdb.firebaseio.com/")
      );

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? response;
  bool signingUp = false;
  int authPage = 1;

  @override
  Widget build(BuildContext context) {
    bool lg = MediaQuery.of(context).size.width > 1010;
    return Scaffold(
      appBar: appBarWidget('Account', lg, context),
      body: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.hasData) {
              var user = getUser();
              if (user != null) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_box_outlined,
                      color: Colors.blueGrey,
                      size: 100,
                    ),
                    Text('You are signed in as ${user.email}'),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => Size(120, 40)),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 1))),
                        onPressed: () {},
                        child: const Text(
                          'Backup Now',
                          style: TextStyle(color: Colors.blueGrey),
                        )),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => Size(120, 40)),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                    width: 1, color: Colors.red.shade700))),
                        onPressed: () {},
                        child: const Text(
                          'Log out',
                          style: TextStyle(color: Colors.blueGrey),
                        ))
                  ],
                ));
              } else {
                return FutureBuilder(
                    future: getAccountInStorage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        authPage = 2;
                        if (authPage == 1) {
                          return buildSignUp();
                        } else {
                          return buildSignIn();
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueGrey,
                          ),
                        );
                      }
                    });
              }
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.blueGrey));
            }
          }),
    );
  }

  getAccountInStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('UID');
  }

  Center buildSignIn() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: response != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow[800]?.withOpacity(0.1),
                    )
                  : null,
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: (response != null)
                  ? ListTile(
                      iconColor: Colors.yellow[800],
                      title: Text(
                        response ?? '',
                        style: TextStyle(color: Colors.yellow[800]),
                      ),
                      leading: const Icon(Icons.info_outline),
                    )
                  : null,
            ),
            TextFormField(
              decoration: kInputDecoration('Email'),
              controller: emailController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordController,
                decoration: kInputDecoration('Password'),
              ),
            ),
            textButton('Sign In',
                login(emailController.text, passwordController.text)),
            TextButton(
                onPressed: () {
                  setState(() {
                    authPage = 1;
                  });
                },
                child: Text("Don't have an account yet? Add account here"))
          ],
        ),
      ),
    );
  }

  getUser() {
    var currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser);
    return currentUser;
  }

  buildSignUp() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: const Text(
                'Add your email and your preferred password to backup your todos and records',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              decoration: response != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow[800]?.withOpacity(0.1),
                    )
                  : null,
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: (response != null)
                  ? ListTile(
                      iconColor: Colors.yellow[800],
                      title: Text(
                        response ?? '',
                        style: TextStyle(color: Colors.yellow[800]),
                      ),
                      leading: const Icon(Icons.info_outline),
                    )
                  : null,
            ),
            TextFormField(
              decoration: kInputDecoration('Email'),
              controller: emailController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordController,
                decoration: kInputDecoration('Password'),
              ),
            ),
            textButton('Add',
                createAccount(emailController.text, passwordController.text)),
            TextButton(
                onPressed: () {
                  setState(() {
                    authPage = 2;
                  });
                },
                child: Text('SignIn instead'))
          ],
        ),
      ),
    );
  }

  TextButton textButton(text, action) {
    return TextButton(
        onPressed: action,
        child: signingUp
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
        style: kButtonStyle.copyWith(
            padding: MaterialStateProperty.resolveWith((states) => signingUp
                ? const EdgeInsets.symmetric(vertical: 10)
                : const EdgeInsets.symmetric(vertical: 20))));
  }

  createAccount(email, password) => () async {
        setState(() {
          signingUp = true;
          response = null;
        });
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('UID', userCredential.user?.uid ?? '');
        } on FirebaseAuthException catch (e) {
          setState(() {
            if (e.code == 'invalid-email') {
              response = 'The email you supplied is invalid.';
            } else if (e.code == 'email-already-in-use') {
              response = 'The account already exists for that email.';
            } else if (e.code == 'weak-password') {
              response = 'The password provided is too weak.';
            } else if (e.code == 'operation-not-allowed') {
              response = 'Operation not allowed.';
            }
          });
        } catch (e) {
          print(e);
        }
        setState(() {
          signingUp = false;
        });
      };
  login(email, password) => () async {
        setState(() {
          signingUp = true;
          response = null;
        });
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          print(userCredential);
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs
        } on FirebaseAuthException catch (e) {
          setState(() {
            if (e.code == 'invalid-email') {
              response = 'The email you supplied is invalid.';
            } else if (e.code == 'operation-not-allowed') {
              response = 'Operation not allowed.';
            }
          });
        } catch (e) {
          print(e);
        }
        setState(() {
          signingUp = false;
        });
      };
}
