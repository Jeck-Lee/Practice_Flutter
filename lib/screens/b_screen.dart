import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BScreen extends StatelessWidget {
  const BScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("B Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go("/");
          },
          child: const Text(
            "go /",
          ),
        ),
      ),
    );
  }
}
