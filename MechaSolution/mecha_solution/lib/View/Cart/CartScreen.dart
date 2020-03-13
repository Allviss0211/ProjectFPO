import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Cart/CartScreenModel.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/data/ProductRepoImlp.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:mecha_solution/View/Widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mecha_solution/data/DataOnFile.dart';

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
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _globalKey = GlobalKey<ScaffoldState>();

  // ignore: non_constant_identifier_names
  Widget _CastViewItems(int index, String name) {
    return ScopedModelDescendant<CartScreenModel>(
        builder: (context, child, model) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 130,
        child: Card(
          margin: const EdgeInsets.all(0.0),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            children: <Widget>[
              Container(
                width: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        model.getListProductSelected[index].image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
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
                        model.getListProductSelected[index].name,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: 6,
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
                            "\$${model.getListProductSelected[index].price}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: <Widget>[
                          Text("Tổng:"),
                          SizedBox(
                            width: 37,
                          ),
                          Text(
                            "\$${model.getListProductSelected[index].mount * model.getListProductSelected[index].price}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.orangeAccent),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
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
                              child: Text(
                                  "${model.getListProductSelected[index].mount}"),
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
      );
    });
  }

  Widget _checkoutSection() {
    return ScopedModelDescendant<CartScreenModel>(
        builder: (context, child, model) {
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
      );
    });
  }

  Widget dismissibleProduct(ProductSelected item, int index) {
    return ScopedModelDescendant<CartScreenModel>(
      builder: (context, child, model) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0),
          child: Dismissible(
            key: ObjectKey(item),
            //movementDuration: Duration(seconds: 1),
            confirmDismiss: (direction) => promptUser(direction, item),
            dismissThresholds: {
              DismissDirection.startToEnd: 1.0,
            },
            background: Container(),
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
            onDismissed: (DismissDirection direction) {
              final deletedItem = model.getListProductSelected[index];
              if (direction == DismissDirection.endToStart) {
                model.removeProduct(index);
                _globalKey.currentState
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.fixed,
                      content: Container(
                        height: 30,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${deletedItem.name.toString()} đã xóa",
                        ),
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
              }
            },
          ),
        );
      },
    );
  }

  Widget slidableProduct(var item, int index) {
    return ScopedModelDescendant<CartScreenModel>(
      builder: (context, child, model) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 3.0),
          child: Slidable(
            key: ObjectKey(item),
            child: _CastViewItems(index, item.toString()),
            actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.3,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Xóa',
                color: Colors.red,
                iconWidget: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onTap: () {
                  final deletedItem = model.getListProductSelected[index];
                  model.removeProduct(index);
                  _globalKey.currentState
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.fixed,
                        content: Container(
                          height: 30,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${deletedItem.name.toString()} đã xóa",
                          ),
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
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget customSlideMenuProduct(var item, int index) {
  //   return Container(
  //     margin: const EdgeInsets.all(1.0),
  //     child: SlideMenu(
  //       child: _CastViewItems(index, item.toString()),
  //       menuItems: <Widget>[
  //         RaisedButton(
  //           padding: const EdgeInsets.only(right: 3.0),
  //           color: Colors.red,
  //           child: Text("Xóa"),
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10.0),
  //           ),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<bool> promptUser(
      DismissDirection direction, ProductSelected item) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "Bạn chắc chắn xóa ${item.name} ?",
              ),
            ),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  //const SizedBox(width: 15.0,),
                  Container(
                    margin: const EdgeInsets.only(left: 21.0, right: 11.0),
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.antiAlias,
                      borderSide: BorderSide(color: Colors.green, width: 2.0),
                      splashColor: Colors.green.shade100,
                      highlightedBorderColor: Colors.green,
                      child: Container(
                          width: 100.0,
                          child: Text(
                            "Yes",
                            style:
                                TextStyle(color: Colors.green, fontSize: 15.0),
                            textAlign: TextAlign.center,
                          )),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                  //const SizedBox(width: 15.0,),
                  Container(
                    margin: const EdgeInsets.only(left: 11.0, right: 21.0),
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      clipBehavior: Clip.antiAlias,
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                      splashColor: Colors.red.shade100,
                      highlightedBorderColor: Colors.red,
                      child: Container(
                          width: 100.0,
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                            textAlign: TextAlign.center,
                          )),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  //const SizedBox(width: 15.0,),
                ],
              ),
            ],
          ),
        ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ScopedModelDescendant<CartScreenModel>(
          builder: (context, child, model) {
        return Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                  itemCount: model.getListProductSelected.length,
                  itemBuilder: (context, index) {
                    final item = model.getListProductSelected[index];
                    return dismissibleProduct(item, index);
                  }),
            ),
            _checkoutSection(),
          ],
        );
      }),
    );
  }
}

// class SlideMenu extends StatefulWidget {
//   final Widget child;
//   final List<Widget> menuItems;

//   SlideMenu({this.child, this.menuItems});

//   @override
//   _SlideMenuState createState() => new _SlideMenuState();
// }

// class _SlideMenuState extends State<SlideMenu>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;

//   @override
//   initState() {
//     super.initState();
//     _controller = new AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 200));
//   }

//   @override
//   dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final animation = new Tween(
//             begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0))
//         .animate(new CurveTween(curve: Curves.decelerate).animate(_controller));

//     return new GestureDetector(
//       onHorizontalDragUpdate: (data) {
//         // we can access context.size here
//         setState(() {
//           _controller.value -= data.primaryDelta / context.size.width;
//         });
//       },
//       onHorizontalDragEnd: (data) {
//         if (data.primaryVelocity > 2500)
//           _controller
//               .animateTo(.0); //close menu on fast swipe in the right direction
//         else if (_controller.value >= .5 ||
//             data.primaryVelocity <
//                 -2500) // fully open if dragged a lot to left or on fast swipe to left
//           _controller.animateTo(1.0);
//         else // close if none of above
//           _controller.animateTo(.0);
//       },
//       child: new Stack(
//         children: <Widget>[
//           new SlideTransition(position: animation, child: widget.child),
//           new Positioned.fill(
//             child: new LayoutBuilder(
//               builder: (context, constraint) {
//                 return new AnimatedBuilder(
//                   animation: _controller,
//                   builder: (context, child) {
//                     return new Stack(
//                       children: <Widget>[
//                         new Positioned(
//                           right: .0,
//                           top: .0,
//                           bottom: .0,
//                           width: constraint.maxWidth * animation.value.dx * -1,
//                           child: new Container(
//                             color: Color(0xFFF5F5F5),
//                             child: new Row(
//                               children: widget.menuItems.map((child) {
//                                 return new Expanded(
//                                   child: child,
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
