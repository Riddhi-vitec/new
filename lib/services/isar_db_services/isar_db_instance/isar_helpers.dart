import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../../imports/data.dart';


class IsarHelpers{
  static late Isar isar;
  ///I N I T I A L I Z E - D A T A B A S E
  static Future<void> initializeDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [LocalProductsSchema],

      /// we got this from build_runner - generated code
      directory: dir.path,
    );
  }
}