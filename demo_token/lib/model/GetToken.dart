import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

Future<OauthModel> fecthOauthModel() async {
  var headers = {"Content-Type": "application/json"};

  var body = json.encode(
      {"username":"admin",
        "password":"827ccb0eea8a706c4c34a16891f84e7b"});
  final responce = await http.post('http://18.139.240.152:3005/oauth',
      headers: headers, body: body);

  if (responce.statusCode == 200) {
    return (OauthModel.fromJson(json.decode(responce.body)));
  } else {
    throw Exception('Lỗi load data');
  }
}

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

Future<String> getToken() async{
  return fecthOauthModel().then((value) {
    return value.data.token;
  });
}
