import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_flutter/model/user_model.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/one_screen.dart';
import 'screens/three_screen.dart';
import 'screens/two_screen.dart';

class RouterProvider extends ChangeNotifier {
  final authProvider = _AuthNotifier();

  GoRouter get routes => GoRouter(
        initialLocation: "/login",
        routes: authProvider._routes,
        redirect: authProvider._redirectLogic, // navigate 될 때마다 호출
        refreshListenable: authProvider, // authProvider 상태를 listen하여 상태가 변하면 redirect 실행
      );

  void login({required String name}) {
    authProvider._login(name: name);
  }

  void logout() {
    authProvider._logout();
  }
}

class _AuthNotifier extends ChangeNotifier {
  UserModel? _userModel;

  Future<String?> _redirectLogic(_, GoRouterState state) async {
    final user = _userModel;
    const loginPath = "/login";
    final loggingIn = state.uri.toString() == loginPath;

    if (user == null) {
      return loggingIn ? null : loginPath;
    }

    if (loggingIn) return "/";

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: "/",
          builder: (_, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: "one",
              builder: (_, state) => const OneScreen(),
              routes: [
                GoRoute(
                  path: "two",
                  builder: (_, state) => const TwoScreen(),
                  routes: [
                    GoRoute(
                      path: "three",
                      name: "three",
                      builder: (_, state) => const ThreeScreen(),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
        GoRoute(
          path: "/login",
          builder: (_, state) => const LoginScreen(),
        ),
      ];

  void _login({required String name}) {
    if (_userModel?.name != name) {
      _userModel = UserModel(name: name);
      notifyListeners();
    }
  }

  void _logout() {
    if (_userModel != null) {
      _userModel = null;
      notifyListeners();
    }
  }
}
