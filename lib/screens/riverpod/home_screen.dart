import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home (RiverPod)"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push("/one");
                },
                child: const Text("Push One"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed("three");
                },
                child: const Text("Push three for Name"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push("/one/two/three");
                },
                child: const Text("Push three for FullPath"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
