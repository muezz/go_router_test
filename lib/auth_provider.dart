import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

enum AuthState {
  loggedOut,
  loggedIn,
  loading,
}

typedef ChildProps = ({
  String? content,
  bool? isUpdating,
});

class AuthProvider extends ChangeNotifier {
  late final StreamSubscription<AuthState> _authSubscription;
  AuthState authState = AuthState.loggedOut;

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  Future<void> initAuthProvider() async {
    setAuthState(AuthState.loading);
    log('1');
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        setAuthState(AuthState.loggedIn);
      },
    );

    _authSubscription = getRandomAuthState().listen(
      (data) async {
        setAuthState(AuthState.loading);
        await Future.delayed(
          const Duration(seconds: 1),
          () => setAuthState(data),
        );
      },
    );
  }

  Stream<AuthState> getRandomAuthState() async* {
    /// Simulates auth token refresh from your auth provider
    await Future.delayed(const Duration(seconds: 30));
    yield AuthState.loggedIn;
  }

  Future<void> login() async {
    setAuthState(AuthState.loading);
    await Future.delayed(
      const Duration(seconds: 1),
      () => setAuthState(AuthState.loggedIn),
    );
  }

  Future<void> logout() async {
    setAuthState(AuthState.loading);
    await Future.delayed(
      const Duration(seconds: 1),
      () => setAuthState(AuthState.loggedOut),
    );
  }

  void setAuthState(AuthState s) {
    authState = s;
    notifyListeners();
  }
}
