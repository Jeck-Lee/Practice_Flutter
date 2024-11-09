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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
