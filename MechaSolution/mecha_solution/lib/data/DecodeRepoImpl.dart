import 'package:mecha_solution/data/remote/DataFromOauth.dart';
import 'package:mecha_solution/Repo/DecodeRepo.dart';

class DecodeRepoImpl with DecodeRepo {
  static DecodeRepo instance;

  static DecodeRepo getInstance() {
    if (instance == null) instance = DecodeRepoImpl();
    return instance;
  }

  DataAPI dataAPI = DataAPI();

  @override
  Future<String> getUserName() async {
    return await dataAPI.fetchInfo().then((value){
      return value.data.username;
    });
  }

  Future<String> getEmail() async {
    return await dataAPI.fetchInfo().then((value){
      return value.data.email;
    });
  }
}
