class CreatProduct {
  int exitcode;
  Data data;
  String message;

  CreatProduct({
    this.exitcode,
    this.data,
    this.message,
  });

  factory CreatProduct.fromJson(Map<String, dynamic> json) => CreatProduct(
    exitcode: json["exitcode"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "exitcode": exitcode,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  String productId;

  Data({
    this.productId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["productId"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
  };
}
