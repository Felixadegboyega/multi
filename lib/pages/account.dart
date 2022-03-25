import 'package:flutter/material.dart';
import 'package:multi/Functions/app_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi/Functions/backup.dart';
import 'package:multi/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // final Future<FirebaseApp> _fbApp = Firebase.initializeApp(options: dbOptions);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? response;
  bool signingUp = false;
  int authPage = 2;
  bool backingup = false;
  String? backupMessage;

  @override
  Widget build(BuildContext context) {
    bool lg = MediaQuery.of(context).size.width > 1010;
    return Scaffold(
      appBar: appBarWidget('Account', lg, context, showAccount: false),
      body: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: const [
                    Text('Something went wrong'),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              var user = getUser();
              if (user != null && !backingup) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_box_outlined,
                      color: Colors.blueGrey,
                      size: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text('You are signed in as ${user.email}'),
                    ),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => const Size(120, 40)),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(width: 1))),
                        onPressed: () {
                          backup();
                        },
                        child: const Text(
                          'Backup Now',
                          style: TextStyle(color: Colors.blueGrey),
                        )),
                    TextButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => const Size(120, 40)),
                            side: MaterialStateBorderSide.resolveWith(
                                (states) => BorderSide(
                                    width: 1, color: Colors.red.shade700))),
                        onPressed: () {
                          setState(() {
                            FirebaseAuth.instance.signOut();
                          });
                        },
                        child: const Text(
                          'Log out',
                          style: TextStyle(color: Colors.blueGrey),
                        ))
                  ],
                ));
              } else if (backingup) {
                return Center(
                  child: Column(
                    // mainAxisAlignment: ,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: LinearProgressIndicator(),
                      ),
                      Text(backupMessage ?? "")
                    ],
                  ),
                );
              } else {
                if (authPage == 1) {
                  return ListView(
                    children: [buildSignUp()],
                  );
                } else {
                  return ListView(
                    children: [buildSignIn()],
                  );
                }
              }
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.blueGrey));
            }
          }),
    );
  }

  void backup() async {
    setState(() {
      backingup = true;
    });
    try {
      User user = getUser();
      await backupTodos(user.email);
      await backupRecords(user.email);
      ScaffoldMessenger.of(context).showSnackBar(kSnackBar('Backup Complete!'));
    } catch (e) {
      print("backup catch $e");
    }

    setState(() {
      backingup = false;
    });
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
            TextButton(
                onPressed: () {
                  login(emailController.text, passwordController.text);
                },
                child: signingUp
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                style: kButtonStyle.copyWith(
                    padding: MaterialStateProperty.resolveWith((states) =>
                        signingUp
                            ? const EdgeInsets.symmetric(vertical: 10)
                            : const EdgeInsets.symmetric(vertical: 20)))),
            TextButton(
                onPressed: () {
                  setState(() {
                    authPage = 1;
                  });
                },
                child:
                    const Text("Don't have an account yet? Add account here"))
          ],
        ),
      ),
    );
  }

  getUser() {
    var currentUser = FirebaseAuth.instance.currentUser;
    print("currentUser $currentUser");
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
            TextButton(
                onPressed: () {
                  createAccount(emailController.text, passwordController.text);
                },
                child: signingUp
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                style: kButtonStyle.copyWith(
                    padding: MaterialStateProperty.resolveWith((states) =>
                        signingUp
                            ? const EdgeInsets.symmetric(vertical: 10)
                            : const EdgeInsets.symmetric(vertical: 20)))),
            TextButton(
                onPressed: () {
                  setState(() {
                    authPage = 2;
                  });
                },
                child: const Text('SignIn instead'))
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

  createAccount(email, password) async {
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
  }

  login(email, password) async {
    setState(() {
      signingUp = true;
      response = null;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'operation-not-allowed':
          setState(() {
            response = 'Operation not allowed.';
          });
          break;
        case 'invalid-email':
          setState(() {
            response = 'The email you supplied is invalid.';
          });
          break;
        case 'user-not-found':
          setState(() {
            response = 'No account match this email.';
          });
          break;
        case 'wrong-password':
          setState(() {
            response = 'Wrong Password.';
          });
          break;
        case 'network-request-failed':
          setState(() {
            response = 'Network error.';
          });
          break;
        default:
          setState(() {
            response = 'An error occured.';
          });
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      signingUp = false;
    });
  }
}
