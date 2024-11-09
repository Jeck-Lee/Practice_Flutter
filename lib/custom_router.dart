import 'package:go_router/go_router.dart';
import 'package:practice_flutter/screens/content_screen.dart';
import 'package:practice_flutter/screens/detail_screen.dart';
import 'package:practice_flutter/screens/home_screen.dart';

class CustomRouter {
  static GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (_, __) => const HomeScreen(),
        routes: [
          GoRoute(
            path: "content",
            builder: (context, state) => const ContentScreen(),
            routes: [
              GoRoute(
                path: "detail",
                builder: (context, state) => const DetailScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
