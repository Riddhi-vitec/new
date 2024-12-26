import '../../di/di.dart';
import '../../imports/data.dart';

class LocalProductsRepository {
  ProductDataBaseSource localDataSource = instance<ProductDataBaseSource>();

  static Future<List<LocalProducts>> addLocalProduct(
      {required String name,
      required String price,
      required int stock,
      required String fileUrl}) async {
    LocalProductsRepository localProductsRepository = LocalProductsRepository();
    await localProductsRepository.localDataSource.addLocalProduct(
        name: name, price: price, stock: stock, fileUrl: fileUrl);
    return await LocalProductsRepository.fetchProducts();
  }

  static Future<List<LocalProducts>> updateLocalProducts(
      {required int productID,
      required String? name,
      required String? price,
      required String? fileUrl,
      required int? stock}) async {
    LocalProductsRepository localProductsRepository = LocalProductsRepository();
    await localProductsRepository.localDataSource.updateLocalProduct(
        productID: productID,
        name: name,
        price: price,
        fileUrl: fileUrl,
        stock: stock);
    return await LocalProductsRepository.fetchProducts();
  }

  static Future<List<LocalProducts>> deleteLocalProduct(
      {required int productID}) async {
    LocalProductsRepository localProductsRepository = LocalProductsRepository();
   await localProductsRepository.localDataSource
        .deleteLocalProduct(productID: productID);
    return await LocalProductsRepository.fetchProducts();
  }

  static Future<List<LocalProducts>> fetchProducts() async {
    LocalProductsRepository localProductsRepository = LocalProductsRepository();
    return await localProductsRepository.localDataSource.fetchProducts();
  }

}
