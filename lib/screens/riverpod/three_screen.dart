import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router_provider.dart';

class ThreeScreen extends StatelessWidget {
  const ThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThreeView();
  }
}

class ThreeView extends ConsumerWidget {
  const ThreeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Three (RiverPod)"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text("Here is the Three"),
              ElevatedButton(
                onPressed: () {
                  ref.read(userProvider.notifier).logout();
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
