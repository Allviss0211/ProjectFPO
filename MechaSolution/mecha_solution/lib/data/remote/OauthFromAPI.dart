import 'dart:async';
import 'dart:convert';
import 'package:mecha_solution/Model/Oauth.dart';
import 'package:http/http.dart' as http;

class OauthAPI {
  Future<OauthModel> fecthOauthModel() async {
    var headers = {"Content-Type": "application/json"};

    var body = json.encode(
        {"username": "admin", "password": "827ccb0eea8a706c4c34a16891f84e7b"});
    final responce = await http.post('http://18.139.240.152:3005/oauth',
        headers: headers, body: body);

    if (responce.statusCode == 200) {
      return (OauthModel.fromJson(json.decode(responce.body)["data"]));
    } else {
      throw Exception('Lỗi load data: getOauth');
    }
  }
}
