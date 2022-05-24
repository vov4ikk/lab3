import 'package:flutter/material.dart';
import 'package:lab3/Pages/Main_screen.dart';
import 'package:lab3/Pages/Menu.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.amberAccent,
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Menu(),
      //'/home': (context) => HomePage(),
    },
  ));
}


