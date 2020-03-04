import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';

class DetailScreen extends StatefulWidget {
  final String productID;

  DetailScreen({Key key, this.productID}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductAPI().getProductByID(widget.productID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        ProductFromAPI product = snapshot.data;
        return snapshot.hasData
            ? DetailProduct(product: product)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class DetailProduct extends StatelessWidget {
  final ProductFromAPI product;
  DetailProduct({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.data.name),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image(
                image: CachedNetworkImageProvider(product.data.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    product.data.price.toString() + "\$",
                    style: TextStyle(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Container(
                    height: 63,
                    width: 154,
                    child: RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red)),
                      child: Text('Mua'.toUpperCase(),style: TextStyle(fontSize: 30),),
                      onPressed: (){},
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
