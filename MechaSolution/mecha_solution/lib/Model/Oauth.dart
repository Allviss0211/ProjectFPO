class OauthModel {
  Data data;

  OauthModel({this.data});

  factory OauthModel.fromJson(Map<String, dynamic> json) => OauthModel(
      data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() =>
      {"data": data,};
}

class Data {
  String token;

  Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
