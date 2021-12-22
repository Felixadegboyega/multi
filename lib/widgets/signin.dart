import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.onCompleted}) : super(key: key);
  final Function() onCompleted;
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? response;
  bool signingIn = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          TextButton(
              onPressed: () {
                login();
              },
              child: signingIn
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Authenticate',
                      style: TextStyle(color: Colors.white),
                    ),
              style: kButtonStyle.copyWith(
                  padding: MaterialStateProperty.resolveWith((states) =>
                      signingIn
                          ? const EdgeInsets.symmetric(vertical: 10)
                          : const EdgeInsets.symmetric(vertical: 20)))),
        ],
      ),
    );
  }

  login() async {
    setState(() {
      signingIn = true;
      response = null;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UID', userCredential.user?.uid ?? '');
      passwordController.clear();
      print('done');
      // widget.onCompleted();
    } on FirebaseAuthException catch (e) {
      // print('done');
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
      signingIn = false;
    });
  }
}
