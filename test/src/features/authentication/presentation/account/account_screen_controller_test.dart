import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Account Screen Controller - ', () {
    test('Initial state should be AsyncData(null)', () async {
      //arrange
      final authReposistory = FakeAuthRepository();
      final controller =
          AccountScreenController(authRepository: authReposistory);
      //assert
      expect(controller.debugState, const AsyncData<void>(null));
    });
  });
}
