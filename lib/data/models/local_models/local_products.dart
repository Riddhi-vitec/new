import 'package:isar/isar.dart';
//this line is needed to generate file
//then run the command in terminal: dart run build_runner build delete-conflicting-outputs
part 'local_products.g.dart';
@Collection()
class LocalProducts{
  Id id = Isar.autoIncrement;
  late String name;
  late String price;
  late String fileUrl;
  late int stock;
}