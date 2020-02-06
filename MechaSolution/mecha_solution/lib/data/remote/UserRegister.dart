import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:mecha_solution/Model/User.dart';

class UserRegister{
  Future<User> sendRegister() async {
    var headers = {"Content-Type": "application/json",};
    final responce = await http.post('http://18.139.240.152:3005/user/signUp',
        headers: headers);

    if (responce.statusCode == 200) {
      return (User.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data');
    }
  }
}