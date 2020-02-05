import 'package:scoped_model/scoped_model.dart';
import 'package:mecha_solution/data/OauthRepoImlp.dart';
import 'package:mecha_solution/Model/Oauth.dart';
import 'package:mecha_solution/Repo/OauthRepo.dart';

class SignInModel extends Model {
  static SignInModel _instance;
  static SignInModel getInstance() {
    if (_instance == null) _instance = getInstance();
    return _instance;
  }

  OauthRepo oauth = OauthRepoImlp();
  String token;

  SignInModel() {
    updateOauth();
  }

  void updateOauth() async {
    token = await oauth.getToken();
    notifyListeners();
  }

  static void destroyInstance(){
    _instance = null;
  }
}
