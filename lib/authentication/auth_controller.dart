import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/utils.dart';
import 'package:stanford/authentication/auth_repository.dart';

import '../models/citizen.dart';

final citizenProvider = StateProvider<Citizen?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Future<void> signUpOrLogIn(String email, String password, bool isNewUser,
      BuildContext context) async {
    state = true;
    final result =
        await _authRepository.signUpOrLogIn(email, password, isNewUser);
    state = false;
    result.fold((l) => showSnackBar(context, l.message),
        (r) => _ref.read(citizenProvider.notifier).update((state) => r));
  }
}
