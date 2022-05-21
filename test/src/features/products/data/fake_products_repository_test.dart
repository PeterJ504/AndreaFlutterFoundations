import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeProductsRepository makeProductsRepository() => FakeProductsRepository(
        addDelay: false,
      );
  group('Repository tests - ', () {
    final productsRepository = makeProductsRepository();
    test(
      'Should return global products list',
      () async {
        //arrange
        //act
        var result = await productsRepository.fetchProductsList();
        //assert
        expect(result, kTestProducts);
      },
    );
    test(
      'Should return first item in the global products list',
      () async {
        //arrange
        // final productsRepository = FakeProductsRepository();
        //act
        var result = productsRepository.getProduct('1');
        //assert
        expect(
          result,
          kTestProducts[0],
        );
      },
    );
  });

  group('Repository tests for streams and futures - ', () {
    final productsRepository = makeProductsRepository();

    test(
      'Should return null when invalid item is requested',
      () async {
        //arrange
        // final productsRepository = FakeProductsRepository();
        //act
        var result = productsRepository.getProduct('100');
        //assert
        expect(result, null);
      },
    );
    test(
      'Should return global list of products (future)',
      () async {
        //arrange
        // final productsRepository = FakeProductsRepository();
        //act
        var result = productsRepository.getProductsList();
        //assert
        expect(result, kTestProducts);
      },
    );
    test(
      'Should emit global list of products (stream)',
      () async {
        //arrange
        // final productsRepository = FakeProductsRepository();
        //act
        var result = productsRepository.watchProductsList();
        //assert
        expect(result, emits(kTestProducts));
      },
    );

    test(
      'Should emit first item (stream)',
      () async {
        //arrange
        final productsRepository = makeProductsRepository();
        //act
        var result = productsRepository.watchProduct('1');
        //assert
        expect(result, emits(kTestProducts[0]));
      },
    );
    test(
      'Should emit null for invalid item (stream)',
      () async {
        //arrange
        // final productsRepository = FakeProductsRepository();
        //act
        var result = productsRepository.watchProduct('100');
        //assert
        expect(result, emits(null));
      },
    );
  });
}
