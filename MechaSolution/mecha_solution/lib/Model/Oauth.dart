class OauthModel {
  int exitcode;
  Data data;
  String message;

  OauthModel({this.exitcode, this.data, this.message});

  factory OauthModel.fromJson(Map<String, dynamic> json) => OauthModel(
      exitcode: json["exitcode"],
      data: Data.fromJson(json["data"]),
      message: json["message"]);

  Map<String, dynamic> toJson() =>
      {"exitcode": exitcode, "data": data, "message": message};
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
