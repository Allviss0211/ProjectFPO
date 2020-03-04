import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/QRScanner.dart';
import 'package:mecha_solution/View/Widget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mecha_solution/View/Cart/CartScreen.dart';
import 'package:mecha_solution/View/Product/DetailProductScreen.dart';
import 'package:mecha_solution/stogare.dart';

class HomePage extends StatelessWidget {
  final String token;
  HomePage({Key key, this.token}) : super(key: key);

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
              SizedBox(width: 25,),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Center(child: Text("Mechasolution",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.w300),),),
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
            model: HomeModel.getInstance(),
            child: ListHome()),
        bottomNavigationBar: Bottom(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: QRScanner(),
      ),
    );
  }
}
