import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/Widget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mecha_solution/View/Cart/CartScreen.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  String result;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Center(
                  child: Text(
                    "Mechasolution",
                    style: TextStyle(fontSize: 37, color: Colors.white),
                  ),
                ),
              ),
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  }),
            ],
          ),
          flexibleSpace: GradientBar(),
        ),
        body: ScopedModel(
            model: HomeModel(),
            child: ListHome()),
        bottomNavigationBar: Bottom(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SearchBar(),
      ),
    );
  }
}

