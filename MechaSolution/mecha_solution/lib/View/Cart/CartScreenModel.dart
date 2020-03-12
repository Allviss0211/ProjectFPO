
import 'package:http/http.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:mecha_solution/data/DataOnFile.dart';
import 'package:scoped_model/scoped_model.dart';

class productSelected{
   String id;
   int mount;
   String name;
   int price;
   String image;
   int totalPricePerProduct;
   productSelected({this.id,this.mount = 1,this.name,this.price,this.image,this.totalPricePerProduct});


   factory productSelected.fromFile(Map<String, dynamic> file){
     return productSelected(
         id: file['id'] as String,
         mount: file['mount'] as int,
         name: file['name'] as String,
         price: file['price'] as int,
         image: file['image'] as String,
         totalPricePerProduct: file['totalPricePerProduct'] as int);
   }

   Map<String, dynamic> toFile() => {
     "id" : id,
     "mount" : mount,
     "name" : name,
     "price" : price,
     "image" : image,
     "totalPricePerProduct" : totalPricePerProduct
   };
}


class CartScreenModel extends Model{
  static CartScreenModel _instance;

  static CartScreenModel getInstance(){
    if(_instance == null){
      _instance = CartScreenModel();
    }

    return _instance;
  }
  static ProductSelected testProduct1 = new ProductSelected(id: '1234',name: 'Raspberry 1',price: 200,totalPricePerProduct: 200,image:"https://yt3.ggpht.com/a/AGF-l79230VSZdeHXKwVJ9Jqc0kskW9RDXw3KoYZJQ=s900-c-k-c0xffffffff-no-rj-mo");
  static ProductSelected testProduct2 = new ProductSelected(id: '1234',name: 'Raspberry 2',price: 300,totalPricePerProduct: 300,image:"https://pbs.twimg.com/profile_images/1174747027986452480/cSlw47L-_400x400.png");
  static ProductSelected testProduct3 = new ProductSelected(id: '1234',name: 'Raspberry 3',price: 200,totalPricePerProduct: 200,image:"https://yt3.ggpht.com/a/AGF-l79230VSZdeHXKwVJ9Jqc0kskW9RDXw3KoYZJQ=s900-c-k-c0xffffffff-no-rj-mo");

    updateListProductSelected(listProductSelected);
  }
  CartScreenModel(){
  List<ProductSelected> listProductSelected = [testProduct1,testProduct2,testProduct3];
  List<String> listProductById = [];
  int _mount = 1;
  int _totalPrice = 0;
  int sum = 0;
  int Sum(List<productSelected> listProductSelected){
    //listProductSelected.forEach((item) => _totalPrice =_totalPrice + item.totalPricePerProduct)
    for(int i = 0;i < listProductSelected.length;i++)
      {
        sum = sum + listProductSelected[i].totalPricePerProduct;
      }
    }
    return sum;
  }

  get mount => _mount;
  get totalPrice => _totalPrice;

  void updateListProductSelected(List<productSelected> listProductSelected) async{
    listProductSelected = await readCartProduct();
    print('$listProductSelected' + ' đã update');
  }

  void addProductById(String id, String name, int price, String image){
    productSelected newProduct = new productSelected(id: id,name: name,price: price,totalPricePerProduct: price, image: image);
    print('${newProduct.id}' + ' in dòng 1');
    listProductSelected.add(newProduct);
    writeCartProduct(newProduct);
    print(listProductSelected[0].id);
    notifyListeners();
  }

  void removeProductById(String id, String name, int price){
    ProductSelected newProduct = new ProductSelected(id: id,name: name,price: price);
    listProductSelected.remove(newProduct);
    notifyListeners();
  }

  void addProduct(ProductSelected newProduct){
    if(!listProductSelected.contains(newProduct)) {
      _totalPrice = _totalPrice + newProduct.totalPricePerProduct;
      listProductSelected.add(newProduct);
    }
    notifyListeners();
  }
  void insertProduct(int index, ProductSelected newProduct){
   if(!listProductSelected.contains(newProduct)) {
      _totalPrice = _totalPrice + newProduct.totalPricePerProduct;
      listProductSelected.insert(index, newProduct);
    }
    notifyListeners();
  }

  void removeProduct(int index){
    _totalPrice = _Sum(listProductSelected) - listProductSelected[index].totalPricePerProduct;
    listProductSelected.removeAt(index);
    notifyListeners();
  }

  void increase(int index){
    _mount++;
    listProductSelected[index].mount++;
    listProductSelected[index].totalPricePerProduct = listProductSelected[index].mount * listProductSelected[index].price;
    _totalPrice = _Sum(listProductSelected);
    notifyListeners();
  }

  void decrease(int index){
    _mount--;
    if(listProductSelected[index].mount > 1)
      listProductSelected[index].mount--;
    listProductSelected[index].totalPricePerProduct = listProductSelected[index].mount * listProductSelected[index].price;
    _totalPrice = _Sum(listProductSelected);
    notifyListeners();
  }


  void setMount(int mount, int index){
    this._mount = mount;
    listProductSelected[index].mount = _mount;
    _totalPrice = _mount * listProductSelected[index].price;
    notifyListeners();
  }
}

List<ProductSelected> listSelected = [];