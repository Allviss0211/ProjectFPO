import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Register/RegisterScreen.dart';
import 'package:mecha_solution/View/SignIn/SignInScreen.dart';

void main() => runApp(MyApp());

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
      home: Register(),
      debugShowCheckedModeBanner: false,
    );
  }
}
