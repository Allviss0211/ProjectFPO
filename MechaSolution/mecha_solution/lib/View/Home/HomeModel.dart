import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:mecha_solution/Model/ProductFolder/ProductFromAPI.dart';
import 'package:mecha_solution/Repo/ProductRepo.dart';
import 'package:mecha_solution/data/ProductRepoImlp.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeModel extends Model {
  static HomeModel _instance;

  static HomeModel getInstance() {
    if (_instance == null) {
      _instance = HomeModel();
    }
    return _instance;
  }

  ProductRepo productRepo = new ProductRepoImlp();
  ListProduct listProduct = new ListProduct();

  HomeModel(){
    updateProductView();
  }

  void updateProductView() async {
    listProduct = await productRepo.getProductAll();
    notifyListeners();
  }
}

