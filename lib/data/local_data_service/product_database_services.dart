import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:template_flutter_mvvm_repo_bloc/imports/services.dart';

import '../models/local_models/local_products.dart';

/*
We are using repository pattern to separate the data layer from the business logic layer.
If we wish to change the data source in the future, we can do so without affecting the business logic layer.
If we don't want ISAR DB we can used the same functions with another data source like SQLite, Hive, etc.
 */
class ProductDataBaseSource {
  /// C R E A T E - add a product and save to db
  Future<void> addLocalProduct(
      {required String name,
      required String price,
      required int stock,
      required String fileUrl}) async {
    final product = LocalProducts()
      ..name = name
      ..price = price
      ..fileUrl = fileUrl
      ..stock = stock;
    await IsarHelpers.isar
        .writeTxn(() => IsarHelpers.isar.localProducts.put(product));
  }

  /// R E A D - get all products from db
  Future<List<LocalProducts>> fetchProducts() async {
    List<LocalProducts> products =
        await IsarHelpers.isar.localProducts.where().findAll();
    return products;
  }

  /// U P D A T E - update a product and save to db
  Future<void> updateLocalProduct(
      {required int productID,
      required String? name,
      required String? price,
      required String? fileUrl,
      required int? stock}) async {
    final existingProduct = await IsarHelpers.isar.localProducts.get(productID);
    if (existingProduct != null) {
      existingProduct.name = name ?? existingProduct.name;
      existingProduct.price = price ?? existingProduct.price;
      existingProduct.stock = stock ?? existingProduct.stock;
      existingProduct.fileUrl = fileUrl ?? existingProduct.fileUrl;

      await IsarHelpers.isar
          .writeTxn(() => IsarHelpers.isar.localProducts.put(existingProduct));
    }
  }

  /// D E L E T E - delete a product from db
  Future<void> deleteLocalProduct({required int productID}) async {
    await IsarHelpers.isar
        .writeTxn(() => IsarHelpers.isar.localProducts.delete(productID));
  }
}
