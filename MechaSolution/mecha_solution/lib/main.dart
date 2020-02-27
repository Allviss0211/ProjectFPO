import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/Register/RegisterScreen.dart';
import 'package:mecha_solution/View/SignIn/SignInScreen.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'View/Home/HomePage.dart';
import 'package:mecha_solution/View/Cart/CartScreen.dart';
import 'View/SignIn/SignInScreen.dart';
import 'data/ProductRepoImlp.dart';

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
      home: Login(),
    );
  }
}
