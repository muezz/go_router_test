import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return authProvider.authState == AuthState.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Login Page'),
                      ElevatedButton(
                        onPressed: () async {
                          await authProvider.login().then(
                                (value) => context.push('/home'),
                              );
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return authProvider.authState == AuthState.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Home Page'),
                      ElevatedButton(
                        onPressed: () {
                          context.push(
                            '/child',
                            extra: (
                              content:
                                  'When you pushed this child page on top of the home page, you provided it with a string prop called "content" as GoRouterState.extra',
                              isUpdating: true,
                            ),
                          );
                        },
                        child: const Text('Go to child page'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          authProvider.logout();
                        },
                        child: const Text('Log out'),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  final ChildProps props;
  const ChildPage({
    super.key,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(props.content!),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
