import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TwoScreen extends StatelessWidget {
  const TwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TwoView();
  }
}

class TwoView extends StatefulWidget {
  const TwoView({super.key});

  @override
  State<TwoView> createState() => _TwoViewState();
}

class _TwoViewState extends State<TwoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Two (RiverPod)"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push("/one/two/three");
                },
                child: const Text("Push Three"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
