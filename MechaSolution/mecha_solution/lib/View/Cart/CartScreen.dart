import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/data/ProductRepoImlp.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';

final Color borderColor = Color(0xffd6d6d6);

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  Widget _CastViewItems(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(8),
      height: 130,
      child: Row(
        children: <Widget>[
          Container(
            width: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                   "https://mechasolution.vn/source/product/raspberry-pi-4/4295-05.jpg"
                        ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 0.3)
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Raspberry ${index.toString()}",
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Container(
                          width: 50,
                          child: IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            iconSize: 25,
                            onPressed: () {},
                            splashColor: Colors.red.shade100,
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Đơn giá: ",
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "\$200",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Tổng:"),
                      SizedBox(
                        width: 37,
                      ),
                      Text(
                        "\$400",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(60),
                          //border: Border.all(color: borderColor, width: 0.5),
                        ),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.red.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.remove,
                              color: Colors.red,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("2"),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(60),
                          //border: Border.all(color: borderColor, width: 0.5),
                        ),
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.green.shade200,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.add,
                              color: Colors.green,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,)
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkoutSection() {
    return Material(
      borderRadius: BorderRadius.circular(20),
      //color: borderColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "Thành tiền:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  Text(
                    "\$800",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.red),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: 45,
                width: double.infinity,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  color: Colors.red,
                  splashColor: Colors.redAccent,
                  child: Text("Thanh toán", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),),
                  onPressed: () {},
                )
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
//      body: Column(
//        children: <Widget>[
//          Flexible(
//            child: ListView.builder(
//              itemBuilder: (context, index) {
//                return Dismissible(
//                  //key: Key(ite),
//                  child: _CastViewItems(index),
//                  onDismissed: (direction) {
//                    setState(() {
//
//                    });
//                  },
    );
  }
}


