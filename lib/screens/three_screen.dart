import 'package:flutter/material.dart';

class ThreeScreen extends StatelessWidget {
  const ThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ThreeView();
  }
}

class ThreeView extends StatefulWidget {
  const ThreeView({super.key});

  @override
  State<ThreeView> createState() => _ThreeViewState();
}

class _ThreeViewState extends State<ThreeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Three"),
      ),
      body: const SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("Here is the Three"),
            ],
          ),
        ),
      ),
    );
  }
}
