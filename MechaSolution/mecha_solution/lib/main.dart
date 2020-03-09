import 'package:flutter/material.dart';
import 'View/Home/HomePage.dart';


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
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
