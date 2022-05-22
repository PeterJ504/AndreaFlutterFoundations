import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../products/data/mocks.dart';

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

  group('Email/password SignInController (register) -', () {
    test(
      'Should return true & state is AsyncData when register is successful',
      () async {
        //arrange
        final authRepository = MockAuthRepository();
        when(() => authRepository.createUserWithEmailAndPassword(
            testEmail, testPassword)).thenAnswer((_) => Future.value());
        final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.register,
            authRepository: authRepository);
        //act
        final result = await controller.submit(testEmail, testPassword);
        //assert
        expect(result, true);
        expect(
            controller.debugState,
            EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: AsyncData<void>(null)));
      },
    );
    test(
      'Should return false & state is AsyncError when register fails',
      () async {
        //arrange
        final authRepository = MockAuthRepository();
        final exception = Exception('connection failed');
        when(() => authRepository.createUserWithEmailAndPassword(
            testEmail, testPassword)).thenThrow(exception);
        final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.register,
            authRepository: authRepository);
        //act
        final result = await controller.submit(testEmail, testPassword);
        //assert
        expect(result, false);
        expect(
          controller.debugState,
          predicate<EmailPasswordSignInState>((state) {
            expect(state.formType, EmailPasswordSignInFormType.register);
            expect(state.value.hasError, true);
            return true;
          }),
        );
      },
    );
  });

  group('UpdateFormType -', () {
    test(
      'state.formType should be register when called with register and formType is signIn',
      () async {
        //arrange
        final authRepository = MockAuthRepository();
        final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.signIn,
            authRepository: authRepository);
        //act
        controller.updateFormType(EmailPasswordSignInFormType.register);
        //assert
        expect(
          controller.debugState,
          EmailPasswordSignInState(
            formType: EmailPasswordSignInFormType.register,
            value: AsyncData<void>(null),
          ),
        );
      },
    );
    test(
      'state.formType should be signIn when called with signIn and formType is register',
      () async {
        //arrange
        final authRepository = MockAuthRepository();
        final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.register,
            authRepository: authRepository);
        //act
        controller.updateFormType(EmailPasswordSignInFormType.signIn);
        //assert
        expect(
          controller.debugState,
          EmailPasswordSignInState(
            formType: EmailPasswordSignInFormType.signIn,
            value: AsyncData<void>(null),
          ),
        );
      },
    );
  });
}
