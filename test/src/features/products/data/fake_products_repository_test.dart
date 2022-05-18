import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Should return global products list',
    () async {
      //arrange
      //act
      final productsRepository = FakeProductsRepository();
      //assert
      expect(
        productsRepository.getProductsList(),
        kTestProducts,
      );
    },
  );
  test(
    'Should return first item in the global products list',
    () async {
      //arrange
      //act
      final productsRepository = FakeProductsRepository();
      //assert
      expect(
        productsRepository.getProduct('1'),
        kTestProducts[0],
      );
    },
  );
  test(
    'Should return null when invalid item is requested',
    () async {
      //arrange
      //act
      final productsRepository = FakeProductsRepository();
      //assert
      expect(
        productsRepository.getProduct('100'),
        null,
      );
    },
  );
}
