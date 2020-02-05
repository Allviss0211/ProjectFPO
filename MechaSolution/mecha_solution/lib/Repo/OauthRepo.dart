import 'package:mecha_solution/Model/Oauth.dart';
import 'package:mecha_solution/data/remote/OauthFromAPI.dart';

abstract class OauthRepo {

 Future<String> getToken();
}