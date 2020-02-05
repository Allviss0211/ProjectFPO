import 'package:mecha_solution/Model/Decode.dart';

abstract class DecodeRepo {
  Future<Decode> getData();

  Future<Decode> removeData();

  Future<Decode> updateData();
}