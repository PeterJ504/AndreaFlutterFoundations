import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepository {
  Stream<AppUser?> authStateChanges() => Stream.value(null);
  //TODO: implement
  AppUser? get currentUser => null; //TODO: implement

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    // TODO: implement signInWithEmailAndPassword
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    // TODO: implement createUserWithEmailAndPassword
  }
  Future<void> signOut() async {
    // TODO: implement signOut
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});

final authStateChangeProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
