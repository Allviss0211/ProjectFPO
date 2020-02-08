import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:mecha_solution/Model/SignUp.dart';
import 'package:mecha_solution/Model/SignUpBody.dart';

class UserRegister{
  Future<SignUp> sendRegister(SignUpBody signUpBody) async {
    var headers = {"Content-Type": "application/json",};
    var body = {
      "username": "${signUpBody.username}",
      "password": "${signUpBody.password}",
      "fullname": "${signUpBody.fullname}",
      "phone": "${signUpBody.phone}",
      "birthday": "${signUpBody.birthday.toString()}",
      "work": "${signUpBody.work}",
      "email": "${signUpBody.email}",
      "avatar": "${signUpBody.avatar}",
      "score": "${signUpBody.score}",
      "gender": signUpBody.gender
    };
    final responce = await http.post('http://18.139.240.152:3005/user/signUp',
        headers: headers, body: body);

    if (responce.statusCode == 200) {
      return (SignUp.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data');
    }
  }
}