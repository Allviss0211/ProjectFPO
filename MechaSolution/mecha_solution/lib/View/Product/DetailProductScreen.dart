import 'package:flutter/material.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/data/ProductRepoImlp.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:cached_network_image/cached_network_image.dart';


int index = 0;

class DetailProductScreen extends StatelessWidget {

  final String productID;

  ProductAPI productAPI = new ProductAPI();
  DetailProductScreen({Key key,this.productID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: FutureBuilder(
        future: productAPI.getProductByID(productID),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error);
          }
          ProductFromAPI product = snapshot.data;
          return snapshot.hasData ? DetailProduct(productlist: product) : Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class DetailProduct extends StatefulWidget {
  final ProductFromAPI productlist;
  DetailProduct({Key key, this.productlist}) : super(key: key);
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: listProductByID(widget.productlist),
    );
  }
}
Widget listProductByID(ProductFromAPI product) {
  return Column(
    children: <Widget>[
      Text("${product.data.id}"),
      Text("${product.data.name}"),
    ],
  );
}





Widget listProductHome(ListProduct listProduct) {
  return ListView.builder(
      itemBuilder: (context, index) {
        return categoryProduct(listProduct, index);
      },
      itemCount: listProduct.data.length,
    scrollDirection: Axis.vertical,
  );
}


Widget categoryProduct(ListProduct listProduct, int index) {
  return InkWell(
    onTap: () {},
    child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    listProduct.data[index].image),
                fit: BoxFit.cover),
          ),
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 10),
          width: 100,
          height: 100,
        ),
        SizedBox(
          height: 10
        ),
        Text(index.toString() + "    " + listProduct.data[index].name.toString()),
        SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}