
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:scoped_model/scoped_model.dart';

class productSelected{
   String id;
   int mount;
   String name;
   int totalPricePerProduct;
   int price;
   String image;
   productSelected({this.id,this.mount = 1,this.name,this.totalPricePerProduct,this.price,this.image});
}

class CartScreenModel extends Model{
  static CartScreenModel _instance;

  static CartScreenModel getInstance(){
    if(_instance == null){
      _instance = CartScreenModel();
    }

    return _instance;
  }
  static productSelected testProduct1 = new productSelected(id: '1234',name: 'raperry1',price: 200,image:"https://scontent.fsgn5-4.fna.fbcdn.net/v/t1.0-9/89056507_1190953791079617_4778470602237280256_n.jpg?_nc_cat=102&_nc_sid=07e735&_nc_ohc=ekz85aJqUSkAX-ZgMYN&_nc_ht=scontent.fsgn5-4.fna&oh=456c7f8260cd43c9fb446fca10c3850a&oe=5E95F493");
  static productSelected testProduct2 = new productSelected(id: '1234',name: 'raperry1',price: 300,image:"https://scontent.fsgn5-4.fna.fbcdn.net/v/t1.0-9/89056507_1190953791079617_4778470602237280256_n.jpg?_nc_cat=102&_nc_sid=07e735&_nc_ohc=ekz85aJqUSkAX-ZgMYN&_nc_ht=scontent.fsgn5-4.fna&oh=456c7f8260cd43c9fb446fca10c3850a&oe=5E95F493");

  List<productSelected> listProductSelected = [testProduct1,testProduct2];
  List<String> listProductById = [];
  int _mount = 1;
  int _totalPrice = 0;

  int Sum(List<productSelected> listProductSelected){
    //listProductSelected.forEach((item) => _totalPrice =_totalPrice + item.totalPricePerProduct);
    int sum = 0;
    for(int i = 0;i < listProductSelected.length;i++)
      {
        sum = sum + listProductSelected[i].totalPricePerProduct;
      }
    return sum;
  }

  get mount => _mount;
  get totalPrice => _totalPrice;

  void addProductById(String id, String name, int price, String image){
    productSelected newProduct = new productSelected(id: id,name: name,price: price, image: image);
    listProductSelected.add(newProduct);
    notifyListeners();
  }

  void removeProductById(String id, String name, int price){
    productSelected newProduct = new productSelected(id: id,name: name,price: price);
    listProductSelected.remove(newProduct);
    notifyListeners();
  }

  void addProduct(productSelected newProduct){
    listProductSelected.add(newProduct);
    notifyListeners();
  }

  void removeProduct(productSelected newProduct){
    listProductSelected.remove(newProduct);
    notifyListeners();
  }

  void increase(int index){
    _mount++;
    listProductSelected[index].mount++;
    listProductSelected[index].totalPricePerProduct = listProductSelected[index].mount * listProductSelected[index].price;
    _totalPrice = Sum(listProductSelected);
    notifyListeners();
  }

  void decrease(int index){
    _mount--;
    if(listProductSelected[index].mount > 1)
      listProductSelected[index].mount--;
    listProductSelected[index].totalPricePerProduct = listProductSelected[index].mount * listProductSelected[index].price;
    _totalPrice = Sum(listProductSelected);
    notifyListeners();
  }

  void setMount(int mount, int index){
    this._mount = mount;
    listProductSelected[index].mount = _mount;
    _totalPrice = _mount * listProductSelected[index].price;
    notifyListeners();
  }
}