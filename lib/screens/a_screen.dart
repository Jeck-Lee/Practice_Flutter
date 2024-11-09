import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AScreen extends StatelessWidget {
  const AScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("A Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push("/a/b");
              },
              child: const Text(
                "push /a/b",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
