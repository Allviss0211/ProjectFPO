class User {
  int exitcode;
  Data data;
  String message;

  User({
    this.exitcode,
    this.data,
    this.message,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
  String password;
  String fullname;
  DateTime birthday;
  String email;
  String phone;
  String work;
  String avatar;

  Data({
    this.id,
    this.username,
    this.password,
    this.fullname,
    this.birthday,
    this.email,
    this.phone,
    this.work,
    this.avatar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    username: json["username"],
    password: json["password"],
    fullname: json["fullname"],
    birthday: DateTime.parse(json["birthday"]),
    email: json["email"],
    phone: json["phone"],
    work: json["work"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "password": password,
    "fullname": fullname,
    "birthday": birthday.toIso8601String(),
    "email": email,
    "phone": phone,
    "work": work,
    "avatar": avatar,
  };
}