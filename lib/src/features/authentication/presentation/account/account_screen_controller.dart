import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));

  final FakeAuthRepository authRepository;

  Future<void> signOut() async {
    try {
      state = const AsyncValue.loading();
      await authRepository.signOut();
      state = AsyncValue<void>.data(null);
    } catch (e) {
      state = AsyncValue.error(e);
      // }
    }
  }
}

final accountScreenControlProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(
    authRepository: authRepository,
  );
});