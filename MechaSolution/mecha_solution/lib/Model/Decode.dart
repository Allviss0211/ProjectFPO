import 'package:mecha_solution/Repo/DecodeRepo.dart';

import 'package:mecha_solution/Repo/DecodeRepo.dart';

import 'package:mecha_solution/Repo/DecodeRepo.dart';

import 'package:mecha_solution/Repo/DecodeRepo.dart';

class Decode {
  int exitcode;
  Data data;
  dynamic message;

  Decode({
    this.exitcode,
    this.data,
    this.message,
  });

  factory Decode.fromJson(Map<String, dynamic> json) => Decode(
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
        userGroup: List<UserGroup>.from(
            json["userGroup"].map((x) => UserGroup.fromJson(x))),
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
