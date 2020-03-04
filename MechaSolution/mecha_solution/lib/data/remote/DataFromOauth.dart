import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:mecha_solution/Model/Decode.dart';
import 'package:mecha_solution/Model/Oauth.dart';
import 'package:mecha_solution/Repo/OauthRepo.dart';
import 'package:mecha_solution/data/OauthRepoImlp.dart';

class DataAPI {
  Future<Decode> fetchInfo() async {
    String token = await OauthRepoImlp.getInstance().getToken();
    var headers = {"Content-Type": "application/json", "x-access-token": token};
    final responce = await http.post('http://18.139.240.152:3005/system/decode',
        headers: headers);

    if (responce.statusCode == 200) {
      return (Decode.fromJson(json.decode(responce.body)));
    } else {
      throw Exception('Lỗi load data: fetchInfo');
    }
  }
}
