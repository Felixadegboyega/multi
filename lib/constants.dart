import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const tabTileDecoration =
    BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)));

InputDecoration kInputDecoration(label) => InputDecoration(
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
    labelText: label,
    labelStyle: const TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.blueGrey)));

ButtonStyle kButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    )),
    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 35)),
    padding:
        MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20)));

FirebaseOptions dbOptions = const FirebaseOptions(
    apiKey: "AIzaSyD2Nchj6ZSafCTfClnYFx2x3I5LKmJpqxk",
    appId: "1:390937159710:android:ba0ee2d0c3d52a20b1a60f",
    messagingSenderId:
        "390937159710-6fe7n1p781sron9b5re9j8qetc6cqb3k.apps.googleusercontent.com",
    projectId: "practise-5e196",
    databaseURL: "https://practise-5e196-default-rtdb.firebaseio.com/");

SnackBar kSnackBar(String text) => SnackBar(
      content: Text(text),
    );
