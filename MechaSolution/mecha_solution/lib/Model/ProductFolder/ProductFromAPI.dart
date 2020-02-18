import 'Product.dart';

class ProductFromAPI {
  int exitcode;
  Product data;
  String message;

  ProductFromAPI({
    this.exitcode,
    this.data,
    this.message,
  });

  factory ProductFromAPI.fromJson(Map<String, dynamic> json) => ProductFromAPI(
    exitcode: json["exitcode"],
    data: Product.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "exitcode": exitcode,
    "data": data.toJson(),
    "message": message,
  };
}

class ListProduct {
  int exitcode;
  List<Product> data;
  String message;

  ListProduct({
    this.exitcode,
    this.data,
    this.message,
  });

  factory ListProduct.fromJson(Map<String, dynamic> json) => ListProduct(
    exitcode: json["exitcode"],
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "exitcode": exitcode,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}



