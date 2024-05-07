import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../model/user_model.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'one_screen.dart';
import 'three_screen.dart';
import 'two_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // authProvider의 상태가 변경될 때 마다 redirection
  final authProvider = _AuthNotifier(ref: ref);

  return GoRouter(
    initialLocation: "/login",
    routes: authProvider._routes,
    redirect: authProvider._redirectLogic, // navigate 될 때마다 호출
    refreshListenable: authProvider, // authProvider 상태를 listen하여 상태가 변하면 redirect 실행
  );
});

class _AuthNotifier extends ChangeNotifier {
  final Ref ref;

  _AuthNotifier({required this.ref}) {
    // UserModel의 상태 listen
    // 상태가 변경되면 notifyListeners() 호출
    ref.listen<UserModel?>(
      userProvider,
          (previous, next) {
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  Future<String?> _redirectLogic(_, GoRouterState state) async {
    final user = ref.read(userProvider);
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
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
        (ref) => UserStateNotifier());

class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  void login({required String name}) {
    state = UserModel(name: name);
  }

  void logout() {
    state = null;
  }
}