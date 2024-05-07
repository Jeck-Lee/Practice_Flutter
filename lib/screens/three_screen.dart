import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../router_provider.dart';

class ThreeScreen extends StatelessWidget {
  const ThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThreeView();
  }
}

class ThreeView extends StatelessWidget {
  const ThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.read<RouterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Three"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text("Here is the Three"),
              ElevatedButton(
                onPressed: () {
                  router.logout();
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
