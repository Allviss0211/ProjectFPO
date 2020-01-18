import 'package:mecha_solution/data/remote/OauthFromAPI.dart';
import 'package:mecha_solution/Model/Oauth.dart';
import 'package:mecha_solution/Repo/OauthRepo.dart';

class OauthRepoImlp with OauthRepo {
  static OauthRepo instance;

  static OauthRepo getInstance() {
    if (instance == null) {
      instance = OauthRepoImlp();
    }
    return instance;
  }

  OauthAPI oauthAPI = OauthAPI();

  @override
  Future<OauthModel> getOauth() async{
    // TODO: implement getOauth
    OauthModel oauth = await oauthAPI.fecthOauthModel();
    return oauth;
  }
}
