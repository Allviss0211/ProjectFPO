import 'package:mecha_solution/Model/ProductFolder/CreateProduct.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/UpdateProduct.dart';

abstract class ProductRepo{
  Future<Product> getProductByID(String id);

  Future<ListProduct> getProductAll();

  Future<CreatProduct> createProduct(Product product);

  Future<UpdateProduct> updateProduct(Product product);

  Future<Product> deleteProduct(String productId);

}