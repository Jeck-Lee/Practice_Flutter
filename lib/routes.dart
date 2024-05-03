import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/one_screen.dart';
import 'screens/three_screen.dart';
import 'screens/two_screen.dart';

final GoRouter router = GoRouter(
  routes: [
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
  ],
);
