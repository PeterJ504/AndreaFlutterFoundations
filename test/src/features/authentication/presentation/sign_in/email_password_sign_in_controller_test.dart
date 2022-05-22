import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  const testEmail = 'test@gmail.com';
  const testPassword = 'testPassword';

  group('Email/password SignInController (submit) -', () {
    test(
      'Should return true & state is AsyncData when signIn is successful',
      () async {
        //arrange
        final authRepository = MockAuthRepository();
        when(() => authRepository.signInWithEmailAndPassword(
            testEmail, testPassword)).thenAnswer((_) => Future.value());
        final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.signIn,
            authRepository: authRepository);
        //act
        final result = await controller.submit(testEmail, testPassword);
        //assert
        expect(result, true);
        expect(
            controller.debugState,
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: AsyncData<void>(null)));
      },
    );
    test(
      'Should return false & state is AsyncError when signIn fails',
      () async {
        //arrange
        final authRepository = MockAuthRepository();
        final exception = Exception('connection failed');
        when(() => authRepository.signInWithEmailAndPassword(
            testEmail, testPassword)).thenThrow(exception);
        final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.signIn,
            authRepository: authRepository);
        //act
        final result = await controller.submit(testEmail, testPassword);
        //assert
        expect(result, false);
        expect(
          controller.debugState,
          predicate<EmailPasswordSignInState>((state) {
            expect(state.formType, EmailPasswordSignInFormType.signIn);
            expect(state.value.hasError, true);
            return true;
          }),
        );
      },
    );
  });
  // group('Email/password SignInController (updateFormType) -', () {
  //   test(
  //     'description',
  //     () async {
  //       //arrange

  //       //act

  //       //assert
  //     },
  //   );
  // });
}
