import 'package:flutter/material.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function(Product product) onClick;
  final Function(Product product) onUpdate;
  final Function(Product product) onDelete;

  ProductItem({
    this.product,
    this.onClick,
    this.onUpdate,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: "hero tag container ${product.name}",
      child: Card(
        elevation: 3,
        child: InkWell(
          child: ListTile(
            onTap: (){
              onClick(product);
            },
          ),
        ),
      ),
    );
  }

}
