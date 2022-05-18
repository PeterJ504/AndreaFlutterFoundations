import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/test_products.dart';

import '../domain/product.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) => _getProduct(_products, id);

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(Duration(seconds: 2));
    // throw Exception('Failed to fetch products');
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map((products) => _getProduct(_products, id));
  }

  static Product? _getProduct(List products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}

final productsRepositoryProvider =
    Provider.autoDispose<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
});

final productProvider =
    StreamProvider.family.autoDispose<Product?, String>((ref, id) {
  // debugPrint('created productProvider with id: $id');
  // ref.onDispose(() {
  //   debugPrint('disposed productProvider with id: $id');
  // });
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
