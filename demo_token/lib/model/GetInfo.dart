import 'package:demo_token/model/GetToken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

GetInfo getInfoFromJson(String str) => GetInfo.fromJson(json.decode(str));

String getInfoToJson(GetInfo data) => json.encode(data.toJson());

Future<GetInfo> fetchInfo(String token) async {
  var headers = {"Content-Type": "application/json", "x-access-token": token};
  final responce = await http.post('http://18.139.240.152:3005/system/decode',
      headers: headers);

  if (responce.statusCode == 200) {
    return (GetInfo.fromJson(json.decode(responce.body)));
  } else {
    throw Exception('Lỗi load data');
  }
}

class GetInfo {
  int exitcode;
  Data data;
  dynamic message;

  GetInfo({
    this.exitcode,
    this.data,
    this.message,
  });

  factory GetInfo.fromJson(Map<String, dynamic> json) => GetInfo(
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
  String id;
  String username;
  String fullname;
  String phone;
  String email;
  String avatar;
  String birthday;
  int levelMax;
  int levelMin;
  List<UserGroup> userGroup;
  int iat;
  int exp;

  Data({
    this.id,
    this.username,
    this.fullname,
    this.phone,
    this.email,
    this.avatar,
    this.birthday,
    this.levelMax,
    this.levelMin,
    this.userGroup,
    this.iat,
    this.exp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    username: json["username"],
    fullname: json["fullname"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    birthday: json["birthday"],
    levelMax: json["levelMax"],
    levelMin: json["levelMin"],
    userGroup: List<UserGroup>.from(json["userGroup"].map((x) => UserGroup.fromJson(x))),
    iat: json["iat"],
    exp: json["exp"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "fullname": fullname,
    "phone": phone,
    "email": email,
    "avatar": avatar,
    "birthday": birthday,
    "levelMax": levelMax,
    "levelMin": levelMin,
    "userGroup": List<dynamic>.from(userGroup.map((x) => x.toJson())),
    "iat": iat,
    "exp": exp,
  };
}

class UserGroup {
  String groupId;
  String groupName;
  int groupLevel;

  UserGroup({
    this.groupId,
    this.groupName,
    this.groupLevel,
  });

  factory UserGroup.fromJson(Map<String, dynamic> json) => UserGroup(
    groupId: json["groupId"],
    groupName: json["groupName"],
    groupLevel: json["groupLevel"],
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "groupLevel": groupLevel,
  };
}

Future<GetInfo> getInfo(token) async{
  return fetchInfo(token).then((value) {
    return value;
  });
}
