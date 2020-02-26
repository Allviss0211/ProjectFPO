import 'dart:convert';
import 'package:mecha_solution/Model/ProductFolder/CreateProduct.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:http/http.dart' as http;
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/Model/ProductFolder/UpdateProduct.dart';
import 'package:mecha_solution/Model/ProductFolder/UpdateProduct.dart';

import '../OauthRepoImlp.dart';

class ProductAPI {

  Future<Product> getProductByID(String id) async {
    String token = await OauthRepoImlp.getInstance().getToken();
    var headers = {"x-access-token": token, "Content-Type": "application/json",};

    var body = json.encode({"productId": id});
    final responce = await http.post(
        'http://18.139.240.152:3005/product/getById',
        headers: headers,
        body: body);

    if (responce.statusCode == 200) {
      print("responce    " + responce.body);
      return (Product.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data');
    }
  }

    Future<ListProduct> getListProduct() async {
    String token = await OauthRepoImlp.getInstance().getToken();
    var headers = {"x-access-token": token};

    final responce = await http
        .post('http://18.139.240.152:3005/product/getAll', headers: headers);

    if (responce.statusCode == 200) {
      return (ListProduct.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data');
    }
  }

  Future<CreatProduct> createProduct(Product product) async {
    String token = await OauthRepoImlp.getInstance().getToken();
    var headers = {"x-access-token": token};

    var body = {
      "name": "${product.name}",
      "description": "${product.description}",
      "image": "${product.image}",
      "price": product.price,
      "quantity": product.quantity,
      "minQuantity": product.minQuantity,
      "manufacturerId": "${product.manufacturerId}",
      "categoryId": "${product.categoryId}",
      "tag": "${product.tag}",
      "rewardPoint": product.rewardPoint,
      "inDate": "${product.inDate}",
      "seo": "${product.seo}",
      "weight": "${product.weight}",
      "isActive": product.isActive,
      "document": "${product.document}",
      "isReward": product.isReward,
      "feature": "${product.feature}"
    };

    final responce = await http.post(
        'http://18.139.240.152:3005/product/create',
        headers: headers,
        body: body);

    if (responce.statusCode == 200) {
      return (CreatProduct.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data');
    }
  }

  Future<UpdateProduct> updateProduct(Product product) async {
    String token = await OauthRepoImlp.getInstance().getToken();
    var headers = {"x-access-token": token};

    var body = {
      "name": "${product.name}",
      "description": "${product.description}",
      "image": "${product.image}",
      "price": product.price,
      "quantity": product.quantity,
      "minQuantity": product.minQuantity,
      "manufacturerId": "${product.manufacturerId}",
      "categoryId": "${product.categoryId}",
      "tag": "${product.tag}",
      "rewardPoint": product.rewardPoint,
      "inDate": "${product.inDate}",
      "seo": "${product.seo}",
      "weight": "${product.weight}",
      "isActive": product.isActive,
      "document": "${product.document}",
      "isReward": product.isReward,
      "feature": "${product.feature}"
    };

    final responce = await http.post(
        'http://18.139.240.152:3005/product/update',
        headers: headers,
        body: body);

    if (responce.statusCode == 200) {
      return (UpdateProduct.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data');
    }
  }

  Future<Product> deleteProduct(String id) async {
    String token = await OauthRepoImlp.getInstance().getToken();
    var headers = {"Content-Type": "application/json", "x-access-token": token};

    var body = json.encode({"productId": id});
    final responce = await http.post(
        'http://18.139.240.152:3005/product/delete',
        headers: headers,
        body: body);

    if (responce.statusCode == 200) {
      return (Product.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data');
    }
  }
}
