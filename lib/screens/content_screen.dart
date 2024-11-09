import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Content Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push("/content/detail");
              },
              child: const Text(
                "push /content/detail",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
