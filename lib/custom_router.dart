import 'package:go_router/go_router.dart';
import 'package:practice_flutter/screens/a_screen.dart';
import 'package:practice_flutter/screens/b_screen.dart';
import 'package:practice_flutter/screens/content_screen.dart';
import 'package:practice_flutter/screens/detail_screen.dart';
import 'package:practice_flutter/screens/home_screen.dart';
import 'package:practice_flutter/screens/sticky_header_screen.dart';

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
            name: "contentRouteName",
            builder: (context, state) => const ContentScreen(),
            routes: [
              GoRoute(
                path: "detail",
                name: "detailRouteName",
                builder: (context, state) => const DetailScreen(),
              ),
            ],
          ),

          GoRoute(
            path: "headerScrollView",
            name: "headerScrollViewRouteName",
            builder: (context, state) => const StickyHeadersScreen(),
          ),
        ],
      ),

      /// 2-a-i. 경로를 모두 루트에 작성하면?
      GoRoute(
        path: "/a",
        name: "aRouteName",
        builder: (_, __) => const AScreen(),
      ),
      GoRoute(
        path: "/b",
        name: "bRouteName",
        builder: (_, __) => const BScreen(),
      ),
      GoRoute(
        path: "/a/b",
        name: "abRouteName",
        builder: (_, __) => const BScreen(),
      ),
    ],
  );
}
