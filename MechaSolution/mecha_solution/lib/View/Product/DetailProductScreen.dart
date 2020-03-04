import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mecha_solution/data/OauthRepoImlp.dart';
import 'package:mecha_solution/data/ProductRepoImlp.dart';
import 'package:mecha_solution/data/remote/OauthFromAPI.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sliding_sheet/sliding_sheet.dart';


class DetailProductScreen extends StatelessWidget {
  final String productID;
  final String token;
  DetailProductScreen({Key key, this.productID, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: productAPI.getProductByID(productID),
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
      //bottomSheet:  Container(height: 110, child: _checkoutSection()),
    );
  }
}

class DetailProduct extends StatefulWidget {
  final Product product;
  DetailProduct({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(widget.product.image),
                      fit: BoxFit.cover)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3 + 0.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w200,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '\$35.99',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),


     /*   SlidingSheet(
          color: Colors.black38,
          elevation: 0,
          cornerRadius: 20,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.1, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Container(
                padding: EdgeInsets.all(15.0),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Text("""\nMÔ TẢ SẢN PHẨM: \n
                                   \nBroadcom BCM2711, Quad core Cortex-A72 (ARM v8) 64-bit SoC @ 1.5GHz
                                   \nRAM: 1GB LPDDR4-2400 SDRAM
                                   \nWifi chuẩn 2.4 GHz và 5.0 GHz IEEE 802.11ac. Bluetooth 5.0, BLE
                                   \nCổng mạng Gigabit Ethernet
                                   \n2 cổng USB 3.0 và 2 cổng USB 2.0
                                   \nChuẩn 40 chân GPIO, tương thích với các phiên bản trước
                                   \nHỗ trợ 2 cổng ra màn hình chuẩn Micro HDMI với độ phân giải lên tới 4K
                                   \nCổng MIPI DSI
                                   \nCổng MIPI CSI
                                   \nCổng AV 4 chân
                                   \nH.265 (4kp60 decode), H264 (1080p60 decode, 1080p30 encode)
                                   \nOpenGL ES 3.0 graphics
                                   \nKhe cắm Micro-SD cho hệ điều hành và lưu trữ
                                   \nNguồn điện DC 5V – 3A DC chuẩn USB-C
                                   \n5V DC via GPIO header (minimum 3A*)
                                   \nHỗ trợ Power over Ethernet (PoE) (yêu cầu có PoE HAT)""",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
            );
          },
        ), */

        SlidingUpPanel(
          renderPanelSheet: true,
          backdropTapClosesPanel: true,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          backdropEnabled:  true,
          maxHeight: MediaQuery.of(context).size.height / 2 + 39.5,
          minHeight: MediaQuery.of(context).size.height / 10,
          //color: Colors.black38,
          panel: Container(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 1 ? Colors.grey.shade300 : null,
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text("${listDecription[index]}"),
                  );
                },
                itemCount: listDecription.length,
            ),
          ),
          collapsed: Container(
            height: 25,
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade300,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            alignment: Alignment.centerLeft,
            child: ListTile(
              title: Text("${widget.product.description}", style: TextStyle(fontSize: 20),),
              trailing: Icon(Icons.arrow_upward, size: 30,),
            ),
          ),
        ),
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
