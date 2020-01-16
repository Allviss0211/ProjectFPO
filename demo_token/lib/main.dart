
import 'package:demo_token/Project/LoginPrj.dart';
import 'package:demo_token/Project/RegisterPrj.dart';
import 'package:demo_token/view/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:demo_token/view/LoginPage.dart';

void main() =>runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Genarator',
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
      ),
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
