import '../../../constants/test_products.dart';

import '../domain/product.dart';

class FakeProductsRepository {
  FakeProductsRepository._();
  static FakeProductsRepository instance = FakeProductsRepository._();
  List<Product> getProductsList() {
    return kTestProducts;
  }

  Product? getProductById(String id) {
    return kTestProducts.firstWhere((product) => product.id == id);
  }
}
