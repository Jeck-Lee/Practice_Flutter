import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                /// Header section scrollView
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed("headerScrollViewRouteName");
                  },
                  child: const Text(
                    "Header ScrollView",
                  ),
                ),
                const SizedBox(height: 48),

                /// Router Test
                const Text("Router Test"),
                ElevatedButton(
                  onPressed: () {
                    context.push("/content");
                  },
                  child: const Text(
                    "push /content",
                  ),
                ),
                const SizedBox(height: 36),

                /// 1. 루트에서 /content/detail 경로로 이동하게 되면 content 화면과 detail 화면이 둘 다 추가될까?
                ElevatedButton(
                  onPressed: () {
                    context.push("/content/detail");
                  },
                  child: const Text(
                    "push /content/detail",
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.go("/content/detail");
                  },
                  child: const Text(
                    "go /content/detail",
                  ),
                ),
                const SizedBox(height: 36),

                /// 2. 상대 경로로 화면을 추가할 수 있는 방법은 없을까?
                ElevatedButton(
                  onPressed: () {
                    context.push("content");
                  },
                  child: const Text(
                    "push content",
                  ),
                ),
                const SizedBox(height: 18),

                /// 2-a-i. 경로를 모두 루트에 작성하면?
                ElevatedButton(
                  onPressed: () {
                    context.push("/a");
                  },
                  child: const Text(
                    "push /a",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push("/b");
                  },
                  child: const Text(
                    "push /b",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push("/a/b");
                  },
                  child: const Text(
                    "push /a/b",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go("/b");
                  },
                  child: const Text(
                    "go /b",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go("/a/b");
                  },
                  child: const Text(
                    "go /a/b",
                  ),
                ),
                const SizedBox(height: 18),

                /// 2-b. 라우터 코드에 name 추가
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed("detailRouteName");
                  },
                  child: const Text(
                    "pushNamed detailRouteName",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.goNamed("detailRouteName");
                  },
                  child: const Text(
                    "goNamed detailRouteName",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
