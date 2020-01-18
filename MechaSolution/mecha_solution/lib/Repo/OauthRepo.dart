import 'package:mecha_solution/Model/Oauth.dart';

abstract class OauthRepo {
 Future<OauthModel> getOauth();
}