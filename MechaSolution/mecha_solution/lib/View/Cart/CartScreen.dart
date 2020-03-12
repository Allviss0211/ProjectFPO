import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Cart/CartScreenModel.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/data/ProductRepoImlp.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mecha_solution/View/Widget.dart';

void logCart(ProductSelected productSelected) {
  print("""
    ${productSelected.id}, 
    ${productSelected.name}, 
    ${productSelected.price}, 
    ${productSelected.mount}, 
    ${productSelected.totalPricePerProduct}, 
    ${productSelected.image}
    """);
}

final Color borderColor = Color(0xffd6d6d6);

class CartScreen extends StatefulWidget {
  final ProductSelected productSelected;
  CartScreen({Key key, this.productSelected}) : super(key:key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  // ignore: non_constant_identifier_names
  Widget _CastViewItems(int index, String name) {
    return ScopedModelDescendant<CartScreenModel>(
      builder: (context,child,model) {
      return Container(
        margin: const EdgeInsets.all(3),
        height: 145,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 140,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          model.listProductSelected[index].image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                    //border: Border.all(width: 0.3)
                  ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.listProductSelected[index].name,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: <Widget>[
                          Text(
                            "Đơn giá: ",
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "\$${model.listProductSelected[index].price}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: <Widget>[
                          Text("Tổng:"),
                          SizedBox(
                            width: 37,
                          ),
                          Text(
                            "\$${model.listProductSelected[index].mount * model.listProductSelected[index].price}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.orangeAccent),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(60),
                                //border: Border.all(color: borderColor, width: 0.5),
                                ),
                            child: InkWell(
                              onTap: () {
                                model.decrease(index);
                              },
                              splashColor: Colors.red.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.red,
                                  size: 27,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${model.listProductSelected[index].mount}"),
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
                              onTap: () {
                                model.increase(index);
                              },
                              splashColor: Colors.green.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 27,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );}
    );
  }

  Widget _checkoutSection() {
    return ScopedModelDescendant<CartScreenModel>(
      builder: (context,child,model) {
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
                      "\$${model.totalPrice}",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.red),
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
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.red,
                    splashColor: Colors.redAccent,
                    child: Text(
                      "Thanh toán",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: () {},
                  )),
            ),
          ],
        ),
      );}
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: CartScreenModel(),
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          flexibleSpace: GradientBar(),
          title: Text(
            "Giỏ hàng",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ScopedModelDescendant<CartScreenModel>(
                  builder: (context, child, model) {
                    model.addProduct(widget.productSelected);
                return ListView.builder(
                    itemCount: model.listProductSelected.length,
                    itemBuilder: (context, index) {
                      final item = model.listProductSelected[index];
                      return Dismissible(
                        key: ObjectKey(item),
                        background: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          color: Colors.red.shade500,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          color: Colors.red.shade500,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 30,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                        child: _CastViewItems(index, item.toString()),
                        onDismissed: (direction) {
                            final deletedItem = model.listProductSelected[index];
                            model.removeProduct(index);
                            _globalKey.currentState
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.fixed,
                                  content:
                                      Container(
                                        height: 30,
                                        alignment: Alignment.centerLeft,
                                        child: Text("${deletedItem.name.toString()} đã xóa",),
                                      ),
                                  duration: Duration(seconds: 2),
                                  action: SnackBarAction(
                                    textColor: Colors.yellow,
                                    label: "Thêm lại",
                                    onPressed: () {
                                      model.insertProduct(index, deletedItem);
                                    },
                                  ),
                                ),
                              );
                        },
                      );
                    });
              }),
            ),
           
             _checkoutSection(),
          ],
        ),
      ),
    );
  }
}
