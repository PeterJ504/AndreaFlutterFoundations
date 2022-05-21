import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testEmail = 'test@gmail.com';
  const testPassword = 'testPassword';
  final testUser =
      AppUser(uid: testEmail.split('').reversed.join(), email: testEmail);
  FakeAuthRepository makeAuthRepository() =>
      FakeAuthRepository(addDelay: false);

  group('FakeAuthRepository - ', () {
    test('Current user should be null', () {
      // arrange
      final authRepository = makeAuthRepository();
      // act
      var result = authRepository.currentUser;
      // assert
      expect(result, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('Current user should not be null after signIn', (() async {
      // arrange
      final authRepository = makeAuthRepository();
      // act
      await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      // assert
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    }));
    test('Current user should not be null after registration', (() async {
      // arrange
      final authRepository = makeAuthRepository();
      // act
      await authRepository.createUserWithEmailAndPassword(
          testEmail, testPassword);
      // assert
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    }));
    test('Current user should be null after signOut', (() async {
      // arrange
      final authRepository = makeAuthRepository();
      // act
      await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      expect(authRepository.authStateChanges(), emits(testUser));
      await authRepository.signOut();
      // assert
      expect(authRepository.currentUser, null);
    }));
    test('Should throw exception if signIn after dispose', (() async {
      // arrange
      final authRepository = makeAuthRepository();
      authRepository.dispose();
      // await authRepository.signInWithEmailAndPassword(testEmail, testPassword);
      // assert
      expect(
          () => authRepository.signInWithEmailAndPassword(
              testEmail, testPassword),
          throwsStateError);
    }));
  });
}
