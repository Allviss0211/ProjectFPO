import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/Widget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mecha_solution/View/Cart/CartScreen.dart';
import 'package:mecha_solution/View/QRscanner/QRView_Custom.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Center(
                child: Text(
                  "Mechasolution",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                  ),
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
                      MaterialPageRoute<CartScreen>(builder: (context) => CartScreen()));
                }),
          ],
        ),
        flexibleSpace: GradientBar(),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: ScopedModel(model: HomeModel.getInstance(), child: ListHome()),
      ),
      bottomNavigationBar: Bottom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonQRView(),
    );
  }
}
