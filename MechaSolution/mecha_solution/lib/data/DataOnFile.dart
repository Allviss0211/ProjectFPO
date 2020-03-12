import 'dart:io';
import 'dart:convert';
import 'package:mecha_solution/View/Cart/CartScreenModel.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/Cart.txt');
}

Future<File> writeCartProduct(productSelected product) async {
  final file = await _localFile;
  List<productSelected> list = [];
  if(readCartProduct() != null)
    list = await readCartProduct();
  if(list == null)
    print("list này rỗng");
  list.add(product);
  return file.writeAsString(jsonEncode(list)); // write data on file
}

Future<List<productSelected>> readCartProduct() async {
  try {
    final file = await _localFile;
    String content = await file.readAsString();
    return jsonDecode(content);
  } catch (e) {
    return null;
  }
}