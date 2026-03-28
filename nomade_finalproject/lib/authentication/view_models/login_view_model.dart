import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomade_finalproject/authentication/repos/authentication_repo.dart';
import 'package:nomade_finalproject/post/home.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email, password),
    );
    if (state.hasError) {
      // showFirebaseErrorSnack(context, state.error);
    } else {
      // context.go("/home");
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
