import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group('Account Screen Controller -', () {
    test('Initial state should be AsyncData(null)', () async {
      //arrange
      final authReposistory = MockAuthRepository();
      final controller =
          AccountScreenController(authRepository: authReposistory);
      //assert
      verifyNever(authReposistory.signOut);
      expect(controller.debugState, const AsyncData<void>(null));
    });
    test('signOut success', () async {
      //arrange
      final authReposistory = MockAuthRepository();
      when(authReposistory.signOut).thenAnswer(
        (_) => Future.value(),
      );
      final controller =
          AccountScreenController(authRepository: authReposistory);
      //act
      await controller.signOut();
      //assert
      verify(authReposistory.signOut).called(1);
      expect(controller.debugState, const AsyncData<void>(null));
    });
    test('signOut failure', () async {
      //arrange
      final authReposistory = MockAuthRepository();
      final exception = Exception('connection failed');
      when(authReposistory.signOut).thenThrow(exception);
      final controller =
          AccountScreenController(authRepository: authReposistory);
      //act
      await controller.signOut();
      //assert
      verify(authReposistory.signOut).called(1);
      expect(controller.debugState, isA<AsyncError>());
      expect(controller.debugState.hasError, true);
    });
  });
}
