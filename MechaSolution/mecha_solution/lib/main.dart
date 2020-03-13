import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Cart/CartScreenModel.dart';
import 'package:mecha_solution/View/SignIn/SignInScreen.dart';
import 'package:mecha_solution/stogare.dart';
import 'package:scoped_model/scoped_model.dart';
import 'View/Home/HomePage.dart';
import 'View/Cart/CartScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: CartScreenModel.getInstance(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/homePage': (context) => HomePage(),
          '/detailScreen': (context) => DetailProductScreen(),
          '/cartScreen': (context) => CartScreen(),
        },
        title: 'Startup Name Genarator',
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
