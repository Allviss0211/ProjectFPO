import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Cart/CartScreen.dart';
import 'package:mecha_solution/View/Cart/CartScreenModel.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';

//import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailProductScreen extends StatefulWidget {
  final String productID;
  final String token;
  DetailProductScreen({Key key, this.productID, this.token}) : super(key: key);
  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  var _selection;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<int>(
            color: Colors.black87,
            onSelected: (int index) {
              setState(() {
                _selection = index;
              });
              Navigator.pop(context);
            },
            itemBuilder: (context) {
              return <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Trang chủ ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    "Danh mục ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    "Giỏ hàng ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text(
                    "Cá nhân ",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: ProductAPI().getProductByID(widget.productID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? DetailProduct(product: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class DetailProduct extends StatefulWidget {
  final Product product;
  DetailProduct({Key key, this.product}) : super(key: key);
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(0.0),
                      bottomRight: const Radius.circular(0.0)),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.product.image),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2 + 22,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text(
                widget.product.name + "  Model B - 4GB RAM",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto Italic',
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${widget.product.price}đ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lobster Regular',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              height: 50,
              child: RaisedButton(
                elevation: 3,
                color: Colors.red,
                splashColor: Colors.red.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  "Chọn mua",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                onPressed: () {
                  CartScreenModel().addProductById(widget.product.id, widget.product.name, widget.product.price, widget.product.image);
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => CartScreen()));
//                List<int> list1 = [];
//                List<int> list2 = [1,2,3];
//                list1.add(null);
//                print('$list1');
                },
              ),
            ),
            SizedBox(
              height: 9.0,
            ),
            Divider(
              thickness: 8.0,
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 4.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.assignment_turned_in,
                        size: 45.0,
                        color: Colors.blue[300],
                      ),
                      Text("Bồi thường"),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        "111%",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text("nếu hàng giả")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.thumb_up,
                        size: 45.0,
                        color: Colors.blue[300],
                      ),
                      Text("Thông tin"),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text("bảo hành"),
                      SizedBox(
                        height: 3.0,
                      ),
                      GestureDetector(
                        child: Text("XEM CHI TIẾT",
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 15)),
                        onTap: () async {
                          await showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(15.0),
                                      topRight: const Radius.circular(15.0))),
                              context: context,
                              builder: (BuildContext context) {
                                return Stack(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(10.0),
                                      height:
                                          MediaQuery.of(context).size.height / 4 + 30,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Thông tin bảo hành",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10.0),
                                            height: 43,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Nhà cung cấp",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Text(
                                                  "Mechasolution",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(10.0),
                                            height: 43,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "Thời gian bảo hành",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Text(
                                                  "12 tháng",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                            bottom: 10.0,
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              height: 50,
                                              width: MediaQuery.of(context).size.width,
                                              child: RaisedButton(
                                                elevation: 3,
                                                color: Color(0xFF0D47A1),
                                                splashColor:
                                                    Colors.blue[200],
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                child: Text(
                                                  "Tôi đã hiểu",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17),
                                                ),
                                                onPressed: () {Navigator.pop(context);},
                                              ),
                                            ),
                                          ),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.assignment_return,
                        size: 45.0,
                        color: Colors.blue[300],
                      ),
                      Text("Đổi trả trong"),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        "7 ngày",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text("nếu SP lỗi"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 9.0,
            ),
            Divider(
              thickness: 8.0,
              color: Colors.grey.shade300,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Mô tả sản phẩm",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Lobster Regular',
                        ),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.lightBlue[100],
                        child: Text(
                          "Xem thêm",
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        splashColor: Colors.lightBlue[100],
                        onPressed: () async {
                          await showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(15.0),
                                      topRight: const Radius.circular(15.0))),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: EdgeInsets.all(10.0),
                                  height:
                                      MediaQuery.of(context).size.height / 2 +
                                          71,
                                  child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: index % 2 == 1
                                                ? Colors.grey.shade100
                                                : null,
                                          ),
                                          padding: EdgeInsets.all(10.0),
                                          child:
                                              Text("${listDecription[index]}", style: TextStyle(fontSize: 15.0),),
                                        );
                                      },
                                      itemCount: listDecription.length),
                                );
                              });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("${listDecription[0]}"),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("${listDecription[1]}"),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("${listDecription[2]}"),
                ),
              ],
            ),

            // ExpansionTile(
            //   title: Text("Mô tả sản phẩm"),
            //   children: <Widget>[
            //     Container(
            //       padding: const EdgeInsets.all(8.0),
            //       height: MediaQuery.of(context).size.height / 2,
            //       child: ListView.builder(
            //         itemCount: listDecription.length,
            //         itemBuilder: (context, index) {
            //           return Container(
            //             decoration: BoxDecoration(
            //               color: index % 2 == 1 ? Colors.grey.shade300 : null
            //             ),
            //             child: ListTile(title: Text("${listDecription[index]}")),
            //           );
            //         }
            //       ),
            //     )
            //   ],
            // ),

            SizedBox(
              height: 9.0,
            ),
            Divider(
              thickness: 8.0,
              color: Colors.grey.shade300,
            ),
          ],
        ),

        // SlidingUpPanel(
        //   renderPanelSheet: true,
        //   backdropTapClosesPanel: true,
        //   borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        //   backdropEnabled: true,
        //   maxHeight: 0.5 + 0.395,
        //   minHeight: 0.3,
        //   //color: Colors.black38,
        //   panel: Container(
        //     padding: EdgeInsets.all(20.0),
        //     child: ListView.builder(
        //       itemBuilder: (context, index) {
        //         return Container(
        //           decoration: BoxDecoration(
        //             color: index % 2 == 1 ? Colors.grey.shade300 : null,
        //           ),
        //           padding: EdgeInsets.all(10.0),
        //           child: Text("${listDecription[index]}"),
        //         );
        //       },
        //       itemCount: listDecription.length,
        //     ),
        //   ),
        //   collapsed: Container(
        //     height: 25,
        //     decoration: BoxDecoration(
        //       color: Colors.lightBlue.shade300,
        //       borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        //     ),
        //     alignment: Alignment.centerLeft,
        //     child: ListTile(
        //       title: Text(
        //         "${widget.product.description}",
        //         style: TextStyle(fontSize: 20),
        //       ),
        //       trailing: Icon(
        //         Icons.arrow_upward,
        //         size: 30,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

List<String> listDecription = [
  "Broadcom BCM2711, Quad core Cortex-A72 (ARM v8) 64-bit SoC @ 1.5GHz",
  "RAM: 1GB LPDDR4-2400 SDRAM",
  "Wifi chuẩn 2.4 GHz và 5.0 GHz IEEE 802.11ac. Bluetooth 5.0, BLE",
  "Cổng mạng Gigabit Ethernet",
  "2 cổng USB 3.0 và 2 cổng USB 2.0",
  "Chuẩn 40 chân GPIO, tương thích với các phiên bản trước",
  "Hỗ trợ 2 cổng ra màn hình chuẩn Micro HDMI với độ phân giải lên tới 4K",
  "Cổng MIPI DSI",
  "Cổng MIPI CSI",
  "Cổng AV 4 chân",
  "H.265 (4kp60 decode), H264 (1080p60 decode, 1080p30 encode)",
  "OpenGL ES 3.0 graphics",
  "Khe cắm Micro-SD cho hệ điều hành và lưu trữ",
  "Nguồn điện DC 5V – 3A DC chuẩn USB-C",
  "5V DC via GPIO header (minimum 3A*)",
  "Hỗ trợ Power over Ethernet (PoE) (yêu cầu có PoE HAT)",
];

List<String> listPopUpItem = [
  "Trang chủ",
  "Danh mục",
  "Cá nhân",
  "Giỏ hàng",
];
