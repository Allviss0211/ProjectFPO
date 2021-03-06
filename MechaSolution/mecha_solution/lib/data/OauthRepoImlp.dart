import 'package:mecha_solution/data/remote/OauthFromAPI.dart';
import 'package:mecha_solution/Repo/OauthRepo.dart';

class OauthRepoImlp with OauthRepo {
  static OauthRepo instance;

  static OauthRepo getInstance() {
    if (instance == null) {
      instance = OauthRepoImlp();
    }
    return instance;
  }

  OauthAPI oauthAPI = new OauthAPI();

  @override
  Future<String> getToken(String username, String password) async {
    // TODO: implement getOauth
    return await oauthAPI.fecthOauthModel(username, password).then((value) => value.token);
  }
}
