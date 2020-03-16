
import 'dart:convert';

import 'package:http/http.dart';
import 'package:mecha_solution/Model/ProductFolder/Product.dart';
import 'package:mecha_solution/data/DataOnFile.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductSelected{
   String id;
   int mount;
   String name;
   int price;
   String image;
   int totalPricePerProduct;
   ProductSelected({this.id,this.mount = 1,this.name,this.price,this.image,this.totalPricePerProduct});

   factory ProductSelected.fromFile(Map<String, dynamic> file){
     return ProductSelected(
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

bool checkContainProduct(List<ProductSelected> list, ProductSelected product) {
  for(var e in list) {
    if(e.id == product.id)
      return false;
  }
  return true;
}




class CartScreenModel extends Model{

  static CartScreenModel _instance;

  static CartScreenModel getInstance(){
    if(_instance == null){
      _instance = CartScreenModel();
    }

    return _instance;
  }

  List<ProductSelected> _listProductSelected = [];
  int _mount = 1;
  int _totalPrice = 0;
 
  int Sum(List<ProductSelected> listProductSelected){
    int sum = 0;
    for(int i = 0;i < listProductSelected.length; i++)
      {
        sum = sum + listProductSelected[i].totalPricePerProduct;
      }
    return sum;
  }

  CartScreenModel(){
    _totalPrice = Sum(_listProductSelected);
    //updateListProductSelected(listProductSelected);
  }

  get mount => _mount;
  get totalPrice => _totalPrice;
  get getListProductSelected => _listProductSelected;

  void updateListProductSelected(List<ProductSelected> listProductSelected) async{
    listProductSelected = await readCartProduct();
    print('$listProductSelected' + ' đã update');
  }

  void addProductById(String id, String name, int price, String image){
    ProductSelected newProduct = new ProductSelected(id: id,name: name,price: price,totalPricePerProduct: price, image: image);
    print('${newProduct.id}' + ' in dòng 1');
    _listProductSelected.add(newProduct);
    writeCartProduct(newProduct);
    print(_listProductSelected[0].id);
    notifyListeners();
  }

  void removeProductById(String id, String name, int price){
    ProductSelected newProduct = new ProductSelected(id: id,name: name,price: price);
    _listProductSelected.remove(newProduct);
    notifyListeners();
  }

  void addProduct(ProductSelected newProduct){
    if(checkContainProduct(_listProductSelected, newProduct)) {
      _totalPrice = _totalPrice + newProduct.totalPricePerProduct;
      _listProductSelected.add(newProduct);
    }
    notifyListeners();
  }

  void insertProduct(int index, ProductSelected newProduct){
   if(!_listProductSelected.contains(newProduct)) {
      _totalPrice = _totalPrice + newProduct.totalPricePerProduct;
      _listProductSelected.insert(index, newProduct);
    }
    notifyListeners();
  }

  void removeProduct(int index){
    _totalPrice = Sum(_listProductSelected) - _listProductSelected[index].totalPricePerProduct;
    _listProductSelected.removeAt(index);
    notifyListeners();
  }

  void increase(int index){
    _mount++;
    _listProductSelected[index].mount++;
    _listProductSelected[index].totalPricePerProduct = _listProductSelected[index].mount * _listProductSelected[index].price;
    _totalPrice = Sum(_listProductSelected);
    notifyListeners();
  }

  void decrease(int index){
    _mount--;
    if(_listProductSelected[index].mount > 1)
      _listProductSelected[index].mount--;
    _listProductSelected[index].totalPricePerProduct = _listProductSelected[index].mount * _listProductSelected[index].price;
    _totalPrice = Sum(_listProductSelected);
    notifyListeners();
  }


  void setMount(int mount, int index){
    this._mount = mount;
    _listProductSelected[index].mount = _mount;
    _totalPrice = _mount * _listProductSelected[index].price;
    notifyListeners();
  }
}

List<ProductSelected> listSelected = [];