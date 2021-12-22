import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? response;
  bool signingUp = false;
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
              'Add Account',
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
              child: signingUp
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Add Account',
                      style: TextStyle(color: Colors.white),
                    ),
              style: kButtonStyle.copyWith(
                  padding: MaterialStateProperty.resolveWith((states) =>
                      signingUp
                          ? const EdgeInsets.symmetric(vertical: 10)
                          : const EdgeInsets.symmetric(vertical: 20)))),
        ],
      ),
    );
  }

  login() async {
    setState(() {
      signingUp = true;
      response = null;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('UID', userCredential.user?.uid ?? '');
      passwordController.clear();
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
  }
}
