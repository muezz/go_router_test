import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/pages.dart';

import 'auth_provider.dart';

class MyRouter {
  final AuthProvider _authProvider;
  GoRouter get router => _goRouter;

  MyRouter(this._authProvider);

  late final GoRouter _goRouter = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _authProvider,
    redirect: (ctx, state) {
      final isLoggedIn = _authProvider.authState == AuthState.loggedIn;
      final isLoggedOut = _authProvider.authState == AuthState.loggedOut;

      log('Auth State: ${_authProvider.authState}');

      /// If the user is not authenticated
      if (isLoggedOut) return '/login';

      return null;
    },
    initialLocation: '/home',
    routes: <GoRoute>[
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => const CupertinoPage(
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => const CupertinoPage(
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: '/child',
        pageBuilder: (context, state) => CupertinoPage(
          child: ChildPage(
            props: state.extra as ChildProps,
          ),
        ),
      ),
    ],
    errorBuilder: (context, state) => Center(
      child: Text(
        state.error.toString(),
      ),
    ),
  );
}
