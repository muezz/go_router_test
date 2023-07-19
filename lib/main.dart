import 'package:flutter/material.dart';
import 'package:go_router_test/auth_provider.dart';
import 'package:go_router_test/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const GoRouterTestApp(),
  );
}

class GoRouterTestApp extends StatefulWidget {
  const GoRouterTestApp({
    super.key,
  });

  @override
  State<GoRouterTestApp> createState() => _GoRouterTestAppState();
}

class _GoRouterTestAppState extends State<GoRouterTestApp> {
  late AuthProvider authProvider;
  late MyRouter myRouter;
  @override
  void initState() {
    super.initState();
    authProvider = AuthProvider();
    authProvider.initAuthProvider();
    myRouter = MyRouter(authProvider);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => authProvider,
        ),
      ],
      child: MyApp(
        myRouter: myRouter,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final MyRouter myRouter;
  const MyApp({
    super.key,
    required this.myRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter.router,
    );
  }
}



// void testGoRouter(BuildContext context) {
//   log(context.currentStack.toString());
// }

// extension Routing on BuildContext {
//   /// Pops until the last remaining route
//   void popAll() {
//     while (canPop()) {
//       pop();
//     }
//   }

//   /// Pops until the first instance of [loc]
//   void popUntil(String loc) {
//     while (GoRouter.of(this).location != loc) {
//       if (!canPop()) {
//         throw Error.throwWithStackTrace(
//           'Provided Location Not Found',
//           StackTrace.current,
//         );
//       }
//       pop();
//     }
//   }

//   /// Removes all routes in stack and replaces them with the provided [loc]
//   void replaceAll(String loc) {
//     popAll();
//     pushReplacement(loc);
//   }

//   /// Removes all routes in stack until [replaceUntil] and replaces them
//   /// with the provided [replacement]
//   void replaceAllUntil(String replaceUntil, String replacement) {
//     popUntil(replaceUntil);
//     pushReplacement(replacement);
//   }

//   /// Gets the current stack as list of locations (strings)
//   List<String> get currentStack =>
//       GoRouter.maybeOf(this)
//           ?.routerDelegate
//           .currentConfiguration
//           .matches
//           .map((e) => e.matchedLocation)
//           .toList() ??
//       [];
// }
