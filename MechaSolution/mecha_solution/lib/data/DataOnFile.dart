import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mecha_solution/View/Cart/CartScreenModel.dart';
import 'package:path_provider/path_provider.dart';

bool CheckSelected(List<ProductSelected> list, ProductSelected product) {
  for (var e in list) {
    if (e.id == product.id) return false;
  }
  return true;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/Cart.txt');
}

Future<File> writeCartProduct(ProductSelected product) async {
  final file = await _localFile;

  List<ProductSelected> list = await readCartProduct();

  file.deleteSync();

  if (list == null) {
    list = [product];
  } else if (CheckSelected(list, product)) {
    list.add(product);
  }
  return file.writeAsString(
      jsonEncode(list.map((e) => e.toFile()).toList())); // write data on file
}

Future<File> deleteCartProduct(ProductSelected product) async {
  final file = await _localFile;
  await file.delete();

  List<ProductSelected> list = await readCartProduct();

  file.deleteSync();

  if (CheckSelected(list, product)) {
    list.remove(product);
  }

  return file.writeAsString(
      jsonEncode(list.map((e) => e.toFile()).toList())); // write data on file
}

Future<List<ProductSelected>> readCartProduct() async {
  try {
    final file = await _localFile;
    String content = await file.readAsString();
    Iterable list = jsonDecode(content);
    List<ProductSelected> listSelected =
        list.map((model) => ProductSelected.fromFile(model)).toList();

    return listSelected;
  } catch (e) {
    return null;
  }
}
