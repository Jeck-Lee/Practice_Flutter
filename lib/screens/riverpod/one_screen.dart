import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OneScreen extends StatelessWidget {
  const OneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OneView();
  }
}

class OneView extends StatefulWidget {
  const OneView({super.key});

  @override
  State<OneView> createState() => _OneViewState();
}

class _OneViewState extends State<OneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("One (RiverPod)"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push("/one/two");
                },
                child: const Text("Push Two"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
