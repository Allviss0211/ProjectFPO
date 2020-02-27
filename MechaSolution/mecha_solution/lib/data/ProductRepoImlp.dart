import 'package:mecha_solution/Model/ProductFolder/CreateProduct.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/UpdateProduct.dart';
import 'package:mecha_solution/Repo/ProductRepo.dart';
import 'package:mecha_solution/data/remote/ProductAPI.dart';

class ProductRepoImlp with ProductRepo {
  static ProductRepo instance;

  static ProductRepo getInstance() {
    if (instance == null) {
      instance = ProductRepoImlp();
    }
    return instance;
  }

  ProductAPI productAPI = new ProductAPI();

  @override
  Future<ProductFromAPI> getProductByID(String id) async {
    return await productAPI.getProductByID(id);
  }

  Future<ListProduct> getProductAll() async {
    return await productAPI.getListProduct();
  }

  Future<void> createProduct(Product product) async {
    return await productAPI.createProduct(product);
  }

  Future<void> updateProduct(Product product) async {
    return await productAPI.updateProduct(product);
  }

  Future<void> deleteProduct(String productId) async {
    return await productAPI.deleteProduct(productId);
  }
}
