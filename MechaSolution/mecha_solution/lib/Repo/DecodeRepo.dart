import 'package:mecha_solution/Model/Decode.dart';

abstract class DecodeRepo {
  Future<String> getUserName();

  Future<String> getEmail();
}
