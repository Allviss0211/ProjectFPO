import 'package:flutter/material.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';

class ProductScreen extends StatefulWidget {
  final int initialIndex;
  final List<Product> product;

  ProductScreen(this.initialIndex, this.product);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MState(initialIndex, product);
  }
}


class MState extends State with TickerProviderStateMixin {
  int initialIndex;
  List<Product> product;

  MState(this.initialIndex, this.product);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Stack(

      ),
    );
  }

  Widget pageViewWidget() {
    return PageView.builder(
      itemBuilder: (context, index) {
        return itemPageViewWidget(product[index]);
      },
      itemCount: product.length,
      controller: PageController(
        initialPage: initialIndex,
      ),
      onPageChanged: (currentPos) {
        setState(() {
          initialIndex = currentPos;
        });
      },
    );
  }

  Widget itemPageViewWidget(Product product) {
    return Hero(
      tag: "hero tag container ${product.name}",
      child: Card(
        elevation: 3,
        margin: EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(36, 36, 0, 24),
              child: Hero(
                tag: "hero tag ${product.name}",
                child: Container(
                  width: 200,
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${product.name}",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Hero(
                tag: "hero tag ${product.name} main",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${product.document}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              leading: leadingMainWidget(product),
              subtitle: Text("${product.name}"),
            ),
            detailWidget(
              AssetImage("images/temp.png"),
              Hero(
                tag: "hero tag ${product.name} temp",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${product.price.toInt()}\$",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            detailWidget(
              AssetImage("images/pressure.png"),
              Text("${product.quantity.toInt()} item"),
            ),
            detailWidget(
              AssetImage("images/humidity.png"),
              Text("${product.minQuantity.toInt()} minItem"),
            ),
          ],
        ),
      ),
    );
  }

  Widget leadingMainWidget(Product product) {
    if (product.name == "RaperRi -3") {
      return Container(
        height: 24,
        width: 24,
        child: Image(
          image: AssetImage(
            "asser/image/raperri",
          ),
          color: Colors.black54,
        ),
      );
    } else if (product.name == "RaperRi -3") {
      return Container(
        height: 24,
        width: 24,
        child: Image(
          image: AssetImage(
            "asser/image/raperri",
          ),
          color: Colors.black54,
        ),
      );
    } else if (product.name == "RaperRi -3") {
      return Container(
        height: 24,
        width: 24,
        child: Image(
          image: AssetImage(
            "asser/image/raperri",
          ),
          color: Colors.black54,
        ),
      );
    }
  }

  Widget detailWidget(ImageProvider image, Widget title) {
    return ListTile(
      leading: Container(
        height: 24,
        width: 24,
        child: Image(
          image: image,
          color: Colors.black54,
        ),
      ),
      title: title,
    );
  }
}