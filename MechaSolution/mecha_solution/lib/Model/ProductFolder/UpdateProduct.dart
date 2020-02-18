class UpdateProduct {
  int exitcode;
  Data data;
  String message;

  UpdateProduct({
    this.exitcode,
    this.data,
    this.message,
  });

  factory UpdateProduct.fromJson(Map<String, dynamic> json) => UpdateProduct(
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
  int nModified;

  Data({
    this.nModified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nModified: json["nModified"],
  );

  Map<String, dynamic> toJson() => {
    "nModified": nModified,
  };
}