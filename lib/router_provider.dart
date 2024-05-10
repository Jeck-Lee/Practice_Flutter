import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_flutter/network/storage_repository.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/one_screen.dart';
import 'screens/three_screen.dart';
import 'screens/two_screen.dart';

class RouterProvider extends ChangeNotifier {
  RouterProvider({
    required this.storageRepository,
  });

  final StorageRepository storageRepository;

  final authProvider = _AuthNotifier();

  GoRouter get routes => GoRouter(
        initialLocation: "/login",
        routes: authProvider._routes,
        redirect: authProvider._redirectLogic, // navigate 될 때마다 호출
        refreshListenable: authProvider, // authProvider 상태를 listen하여 상태가 변하면 redirect 실행
      );

  Future<void> login({required String token}) async {
    await storageRepository.saveToken(token);
    authProvider._login(token: token);
  }

  Future<void> logout() async {
    await storageRepository.removeAllTokens();
    authProvider._logout();
  }
}

class _AuthNotifier extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  String? _token;

  Future<String?> _redirectLogic(_, GoRouterState state) async {
    const loginPath = "/login";
    final loggingIn = state.uri.toString() == loginPath;

    if (_token == null) {
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

  void _login({required String token}) {
    if (_token != token) {
      _token = token;
      notifyListeners();
    }
  }

  void _logout() {
    if (_token != null) {
      _token = null;
      notifyListeners();
    }
  }
}
